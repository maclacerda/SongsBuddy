//
//  SongDetailsViewModel.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import Foundation
import Observation
import SBDomain

/// Manages the Player screen presentation data.
@MainActor
@Observable
public final class SongDetailsViewModel {
    // MARK: - Properties
    public private(set) var playbackContext: PlaybackContext
    public private(set) var playerState: AudioPlayerState
    public private(set) var currentTime: Double
    public private(set) var duration: Double
    public var isRepeatEnabled: Bool

    private let audioPlayerService: AudioPlayerServiceProtocol
    private let recentlyPlayedRepository: any RecentlyPlayedRepositoryProtocol

    public var progressValue: Double {
        guard duration > .zero else {
            return .zero
        }

        return currentTime / duration
    }

    public var playPauseSystemImage: String {
        switch self.playerState {
        case .playing:
            return "ic-pause"

        case .idle, .paused, .failed, .loading:
            return "ic-play"
        }
    }

    public var repeatButtonOpacity: Double {
        return self.isRepeatEnabled ? 1.0 : 0.45
    }

    public var backwardButtonOpacity: Double {
        return self.canGoBackward ? 1.0 : 0.35
    }

    public var forwardButtonOpacity: Double {
        return self.canGoForward ? 1.0 : 0.35
    }

    public var formattedCurrentTime: String {
        return Self.formatTime(currentTime)
    }

    public var formattedDuration: String {
        return Self.formatTime(duration)
    }

    private func loadCurrentItemAndAutoPlay() {
        currentTime = .zero
        duration = .zero
        audioPlayerService.stop()

        saveCurrentItemAsRecentlyPlayed()

        audioPlayerService.loadPreview(url: item.previewURL)
    }

    private func handlePlaybackEnded() {
        if isRepeatEnabled {
            audioPlayerService.seek(to: .zero)
            audioPlayerService.play()

            return
        }

        if canGoForward {
            playNext()

            return
        }

        playerState = .paused
    }

    private static func formatTime(
        _ seconds: Double
    ) -> String {
        guard seconds.isFinite, seconds >= .zero else {
            return "0:00"
        }

        let totalSeconds = Int(seconds)
        let minutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60

        return "\(minutes):\(String(format: "%02d", remainingSeconds))"
    }

    // MARK: - Initializer
    public init(
        playbackContext: PlaybackContext,
        audioPlayerService: AudioPlayerServiceProtocol = AudioPlayerService(),
        recentlyPlayedRepository: any RecentlyPlayedRepositoryProtocol
    ) {
        self.playbackContext = playbackContext
        self.audioPlayerService = audioPlayerService
        self.recentlyPlayedRepository = recentlyPlayedRepository

        isRepeatEnabled = false
        playerState = .idle
        currentTime = .zero
        duration = .zero

        setupAudioPlayerService()
    }

    private func setupAudioPlayerService() {
        audioPlayerService.onProgressUpdate = { [weak self] currentTime, duration in
            self?.currentTime = currentTime
            self?.duration = duration
        }

        audioPlayerService.onStateChange = { [weak self] state in
            self?.playerState = state
        }

        audioPlayerService.onPlaybackEnded = { [weak self] in
            Task { @MainActor [weak self] in
                self?.handlePlaybackEnded()
            }
        }
    }

    public var item: SongDetailsItem {
        let currentItem = playbackContext.currentItem

        return .init(
            title: currentItem?.title ?? "",
            artistName: currentItem?.artistName ?? "",
            artworkURL: currentItem?.artworkURL,
            albumName: currentItem?.albumName,
            previewURL: currentItem?.previewURL,
            albumID: currentItem?.albumID
        )
    }

    public var canGoBackward: Bool {
        return playbackContext.hasPrevious
    }

    public var canGoForward: Bool {
        return playbackContext.hasNext
    }

    public func preparePlayer() async {
        loadCurrentItemAndAutoPlay()
    }

    public func togglePlayback() {
        switch playerState {
        case .playing:
            audioPlayerService.pause()

        case .paused, .idle, .failed:
            if duration > .zero,
               currentTime >= duration {
                audioPlayerService.seek(to: .zero)
            }

            audioPlayerService.play()

        case .loading:
            return
        }
    }

    public func seek(
        to progress: Double
    ) {
        guard duration > .zero else {
            return
        }

        let targetTime = duration * progress

        audioPlayerService.seek(to: targetTime)
    }

    public func toggleRepeat() {
        isRepeatEnabled.toggle()
    }

    public func playPrevious() {
        guard let previousContext = playbackContext.previousContext() else {
            return
        }

        playbackContext = previousContext
        loadCurrentItemAndAutoPlay()
    }

    public func playNext() {
        guard let nextContext = playbackContext.nextContext() else {
            return
        }

        playbackContext = nextContext
        loadCurrentItemAndAutoPlay()
    }

    public func stopPlayer() {
        audioPlayerService.stop()
    }

    public func updatePlaybackContext(
        _ playbackContext: PlaybackContext
    ) {
        self.playbackContext = playbackContext

        loadCurrentItemAndAutoPlay()
    }

    private func saveCurrentItemAsRecentlyPlayed() {
        guard let currentItem = playbackContext.currentItem else {
            return
        }

        let song = RecentlyPlayedSong(
            id: currentItem.id,
            title: currentItem.title,
            artistName: currentItem.artistName,
            artworkURL: currentItem.artworkURL,
            previewURL: currentItem.previewURL,
            albumName: currentItem.albumName,
            albumID: currentItem.albumID,
            playedAt: Date()
        )

        Task {
            try? await recentlyPlayedRepository.save(song: song)
        }
    }
}

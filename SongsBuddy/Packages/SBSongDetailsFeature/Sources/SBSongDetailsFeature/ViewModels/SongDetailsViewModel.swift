//
//  SongDetailsViewModel.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import Foundation
import Observation

/// Manages the Player screen presentation data.
@MainActor
@Observable
public final class SongDetailsViewModel {
    // MARK: - Properties
    public let item: SongDetailsItem
    public private(set) var playerState: AudioPlayerState
    public private(set) var currentTime: Double
    public private(set) var duration: Double

    private let audioPlayerService: AudioPlayerServiceProtocol

    public var progressValue: Double {
        guard duration > .zero else {
            return .zero
        }

        return currentTime / duration
    }

    public var playPauseSystemImage: String {
        switch self.playerState {
        case .playing:
            return "pause.fill"

        case .idle, .paused, .failed, .loading:
            return "play.fill"
        }
    }

    public var formattedCurrentTime: String {
        return Self.formatTime(currentTime)
    }

    public var formattedDuration: String {
        return Self.formatTime(duration)
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
        item: SongDetailsItem,
        audioPlayerService: AudioPlayerServiceProtocol = AudioPlayerService()
    ) {
        self.item = item
        self.audioPlayerService = audioPlayerService

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
    }

    public func preparePlayer() async {
        audioPlayerService.loadPreview(
            url: item.previewURL
        )
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

    public func stopPlayer() {
        audioPlayerService.stop()
    }
}

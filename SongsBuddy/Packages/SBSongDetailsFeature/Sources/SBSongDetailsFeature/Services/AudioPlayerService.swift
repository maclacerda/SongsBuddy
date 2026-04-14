//
//  AudioPlayerService.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/14/26.
//

import AVFoundation
import Foundation

@MainActor
final class AudioPlayerService: NSObject {
    // MARK: - Properties
    var onProgressUpdate: ((Double, Double) -> Void)?
    var onStateChange: ((AudioPlayerState) -> Void)?

    private var player: AVPlayer?
    private var timeObserverToken: Any?
    private var playbackEndedObserver: NSObjectProtocol?

    // MARK: - Methods
    func loadPreview(
        url: URL?
    ) {
        guard let url else {
            onStateChange?(.failed)
            return
        }

        stop()

        onStateChange?(.loading)

        let playerItem = AVPlayerItem(
            url: url
        )

        let player = AVPlayer(
            playerItem: playerItem
        )

        player.automaticallyWaitsToMinimizeStalling = true

        self.player = player

        addPeriodicTimeObserver()
        observePlaybackEnded(for: playerItem)

        play()
    }

    func play() {
        player?.play()
        onStateChange?(.playing)
    }

    func pause() {
        player?.pause()
        onStateChange?(.paused)
    }

    func stop() {
        if let timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }

        if let playbackEndedObserver {
            NotificationCenter.default.removeObserver(playbackEndedObserver)
            self.playbackEndedObserver = nil
        }

        player?.pause()
        player?.replaceCurrentItem(with: nil)
        player = nil
    }

    func seek(
        to seconds: Double
    ) {
        let targetTime = CMTime(
            seconds: seconds,
            preferredTimescale: 600
        )

        player?.seek(
            to: targetTime
        )
    }

    private func addPeriodicTimeObserver() {
        let interval = CMTime(
            seconds: 0.25,
            preferredTimescale: 600
        )

        timeObserverToken = player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] currentTime in
            guard let item = self?.player?.currentItem else {
                return
            }

            let durationSeconds = item.duration.seconds
            let currentSeconds = currentTime.seconds

            guard durationSeconds.isFinite,
                  currentSeconds.isFinite else {
                return
            }

            self?.onProgressUpdate?(
                currentSeconds,
                durationSeconds
            )
        }
    }

    private func observePlaybackEnded(
        for playerItem: AVPlayerItem
    ) {
        playbackEndedObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { [weak self] _ in
            guard let item = self?.player?.currentItem else {
                return
            }

            let durationSeconds = item.duration.seconds
            let safeDuration = durationSeconds.isInfinite ? durationSeconds: .zero

            self?.player?.pause()
            self?.player?.seek(to: .zero)

            self?.onProgressUpdate?(
                .zero,
                safeDuration
            )

            self?.onStateChange?(.paused)
        }
    }
}

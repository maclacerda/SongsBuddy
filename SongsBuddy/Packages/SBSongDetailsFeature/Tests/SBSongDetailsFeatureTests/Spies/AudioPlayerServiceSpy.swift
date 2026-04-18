//
//  AudioPlayerServiceSpy.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
@testable import SBSongDetailsFeature

@MainActor
final class AudioPlayerServiceSpy: AudioPlayerServiceProtocol {
    // MARK: - Properties
    var onProgressUpdate: ((Double, Double) -> Void)?
    var onStateChange: ((AudioPlayerState) -> Void)?
    var onPlaybackEnded: (() -> Void)?

    var loadPreviewCallCount: Int = .zero
    var playCallCount: Int = .zero
    var pauseCallCount: Int = .zero
    var seekCallArguments: [Double] = []
    var stopCallCount: Int = .zero

    // MARK: - Methods
    func loadPreview(
        url: URL?
    ) {
        self.loadPreviewCallCount += 1
    }

    func play() {
        self.playCallCount += 1
    }

    func pause() {
        self.pauseCallCount += 1
    }

    func seek(
        to seconds: Double
    ) {
        self.seekCallArguments.append(seconds)
    }

    func stop() {
        self.stopCallCount += 1
    }
}

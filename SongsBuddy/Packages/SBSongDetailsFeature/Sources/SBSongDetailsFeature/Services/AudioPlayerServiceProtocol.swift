//
//  AudioPlayerServiceProtocol.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation

@MainActor
public protocol AudioPlayerServiceProtocol: AnyObject {
    // MARK: - Properties
    var onProgressUpdate: ((Double, Double) -> Void)? { get set }
    var onStateChange: ((AudioPlayerState) -> Void)? { get set }
    var onPlaybackEnded: (() -> Void)? { get set }

    // MARK: - Methods
    func loadPreview(
        url: URL?
    )

    func play()

    func pause()

    func seek(
        to seconds: Double
    )

    func stop()
}

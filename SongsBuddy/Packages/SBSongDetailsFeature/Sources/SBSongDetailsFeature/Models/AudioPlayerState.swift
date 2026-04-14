//
//  AudioPlayerState.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/14/26.
//

import Foundation

/// Represents the current playback state of the audio preview.
public enum AudioPlayerState: Equatable, Sendable {
    /// No preview is loaded yet.
    case idle

    /// The preview is currently loading.
    case loading

    /// The preview is currently playing.
    case playing

    /// The preview is currently paused.
    case paused

    /// Playback failed.
    case failed
}

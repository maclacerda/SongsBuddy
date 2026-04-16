//
//  SongDetailsViewModelTests.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBSongDetailsFeature
import Testing

@Suite("SongDetailsViewModel Tests")
@MainActor
struct SongDetailsViewModelTests {
    @Test("initial state is idle with zero progress")
    func initialStateIsIdleWithZeroProgress() {
        let spy = AudioPlayerServiceSpy()

        let viewModel = SongDetailsViewModel(
            item: .fixture(),
            audioPlayerService: spy
        )

        #expect(viewModel.playerState == .idle)
        #expect(viewModel.currentTime == .zero)
        #expect(viewModel.duration == .zero)
        #expect(viewModel.progressValue == .zero)
        #expect(viewModel.playPauseSystemImage == "play.fill")
        #expect(viewModel.formattedCurrentTime == "0:00")
        #expect(viewModel.formattedDuration == "0:00")
    }

    @Test("prepare player loads preview")
    func preparePlayerLoadsPreview() async {
        let spy = AudioPlayerServiceSpy()

        let viewModel = SongDetailsViewModel(
            item: .fixture(previewURL: URL(string: "https://example.com/preview.m4a")),
            audioPlayerService: spy
        )

        await viewModel.preparePlayer()

        #expect(spy.loadPreviewCallCount == 1)
    }

    @Test("toggle playback pauses when state is playing")
    func togglePlaybackPausesWhenStateIsPlaying() throws {
        let spy = AudioPlayerServiceSpy()

        let viewModel = SongDetailsViewModel(
            item: .fixture(),
            audioPlayerService: spy
        )

        spy.onStateChange?(.playing)

        viewModel.togglePlayback()

        #expect(spy.pauseCallCount == 1)
        #expect(spy.playCallCount == 0)
    }

    @Test("toggle playback plays when state is paused")
    func togglePlaybackPlaysWhenStateIsPaused() throws {
        let spy = AudioPlayerServiceSpy()

        let viewModel = SongDetailsViewModel(
            item: .fixture(),
            audioPlayerService: spy
        )

        spy.onStateChange?(.paused)

        viewModel.togglePlayback()

        #expect(spy.playCallCount == 1)
        #expect(spy.pauseCallCount == 0)
    }

    @Test("formatted current and duration strings start at zero")
    func formattedStringsStartAtZero() {
        let viewModel = SongDetailsViewModel(
            item: .fixture()
        )

        #expect(viewModel.formattedCurrentTime == "0:00")
        #expect(viewModel.formattedDuration == "0:00")
    }

    @Test("seek converts progress into target time")
    func seekConvertsProgressIntoTargetTime() {
        let spy = AudioPlayerServiceSpy()

        let viewModel = SongDetailsViewModel(
            item: .fixture(),
            audioPlayerService: spy
        )

        spy.onProgressUpdate?(15, 30)

        viewModel.seek(to: 0.5)

        #expect(spy.seekCallArguments.last == 15)
        #expect(viewModel.progressValue == 0.5)
        #expect(viewModel.formattedCurrentTime == "0:15")
        #expect(viewModel.formattedDuration == "0:30")
    }

    @Test("stop player forwards call to service")
    func stopPlayerForwardsCallToService() {
        let spy = AudioPlayerServiceSpy()

        let viewModel = SongDetailsViewModel(
            item: .fixture(),
            audioPlayerService: spy
        )

        viewModel.stopPlayer()

        #expect(spy.stopCallCount == 1)
    }
}

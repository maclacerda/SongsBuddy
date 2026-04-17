//
//  SongDetailsView.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import SBAlbumFeature
import SBData
import SBDesignSystem
import SwiftUI

public struct SongDetailsView: View {
    // MARK: - Properties
    @State private var viewModel: SongDetailsViewModel
    @State private var isShowingMoreOptions: Bool = false
    @State private var isShowingAlbum: Bool = false

    // MARK: - Initializer
    public init(
        viewModel: SongDetailsViewModel
    ) {
        self._viewModel = State(
            initialValue: viewModel
        )
    }

    public var body: some View {
        ZStack {
            SBColors.screenBackground
                .ignoresSafeArea()

            VStack(spacing: .zero) {
                Spacer()
                    .frame(
                        height: 24
                    )

                artworkView

                Spacer()

                VStack(
                    alignment: .leading,
                    spacing: .zero
                ) {
                    Text(viewModel.item.title)
                        .font(.sb(.display24))
                        .foregroundStyle(SBColors.primaryText)
                        .lineLimit(2)

                    HStack(
                        alignment: .center,
                        spacing: SBSpacingToken.spacing12.value
                    ) {
                        Text(viewModel.item.artistName)
                            .font(.sb(.text16))
                            .foregroundStyle(SBColors.secondaryText)
                            .lineLimit(1)

                        Spacer()

                        repeatButton
                    }
                    .padding(.top, SBSpacingToken.spacing8.value)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.horizontal, SBSpacingToken.spacing24.value)

                Spacer()
                    .frame(
                        height: 20
                    )

                VStack(
                    spacing: SBSpacingToken.spacing24.value
                ) {
                    progressView
                    controlsView
                }
                .padding(.horizontal, SBSpacingToken.spacing24.value)
                .padding(.bottom, 33)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.item.albumName ?? viewModel.item.artistName)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                moreOptionsButton
            }
        }
        .toolbarBackground(
            .visible,
            for: .navigationBar
        )
        .toolbarBackground(
            SBColors.screenBackground,
            for: .navigationBar
        )
        .overlay {
            if isShowingMoreOptions {
                ZStack(alignment: .bottom) {
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowingMoreOptions = false
                        }

                    MoreOptionsSheetView(
                        title: viewModel.item.title,
                        artistName: viewModel.item.artistName,
                        onViewAlbum: {
                            isShowingMoreOptions = false
                            isShowingAlbum = true
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 192)
                    .transition(.move(edge: .bottom))
                }
                .ignoresSafeArea()
            }
        }
        .animation(
            .easeInOut(duration: 0.2),
            value: isShowingMoreOptions
        )
        .navigationDestination(isPresented: $isShowingAlbum) {
            if let albumID = viewModel.item.albumID {
                let viewModel = AlbumDetailsViewModel(
                    albumID: albumID,
                    albumTitle: viewModel.item.albumName ?? "",
                    artistName: viewModel.item.artistName,
                    artworkURL: viewModel.item.artworkURL,
                    repository: MusicRepositoryFactory.makeDefault()
                )

                AlbumDetailsView(
                    viewModel: viewModel
                )
            }
        }
        .task {
            await viewModel.preparePlayer()
        }
        .onDisappear {
            viewModel.stopPlayer()
        }
    }
}

// MARK: - Subviews
private extension SongDetailsView {
    var artworkView: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: SBRadiusToken.radius32.value
            )
            .fill(SBColors.searchBackground)

            AsyncImage(
                url: viewModel.item.artworkURL
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()

                case .empty, .failure:
                    placeholderArtworkView

                @unknown default:
                    placeholderArtworkView
                }
            }
            .frame(
                width: 264,
                height: 264
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: SBRadiusToken.radius32.value
                )
            )
        }
        .frame(
            width: 264,
            height: 264
        )
    }

    var placeholderArtworkView: some View {
        RoundedRectangle(
            cornerRadius: SBRadiusToken.radius32.value
        )
        .fill(SBColors.searchBackground)
        .overlay {
            Image(systemName: "music.note")
                .font(.system(size: 56, weight: .regular))
                .foregroundStyle(SBColors.primaryIcon)
        }
    }

    var repeatButton: some View {
        Button {
            viewModel.toggleRepeat()
        } label: {
            Image("ic-repeat")
                .opacity(viewModel.repeatButtonOpacity)
                .frame(
                    width: 24,
                    height: 24
                )
        }
        .buttonStyle(.plain)
    }

    var progressView: some View {
        VStack(
            spacing: SBSpacingToken.spacing8.value
        ) {
            Slider(
                value: Binding(
                    get: {
                        return viewModel.progressValue
                    },
                    set: { newValue in
                        viewModel.seek(
                            to: newValue
                        )
                    }
                ),
                in: 0...1
            )
            .tint(SBColors.progressFill)

            HStack {
                Text(viewModel.formattedCurrentTime)
                    .font(.sb(.text12))
                    .foregroundStyle(SBColors.tertiaryText)

                Spacer()

                Text(viewModel.formattedDuration)
                    .font(.sb(.text12))
                    .foregroundStyle(SBColors.tertiaryText)
            }
        }
    }

    var controlsView: some View {
        HStack(spacing: 28) {
            Spacer()

            Button {
                viewModel.playPrevious()
            } label: {
                Image("ic-backward")
                    .opacity(viewModel.backwardButtonOpacity)
                    .frame(
                        width: 36,
                        height: 36
                    )
            }
            .buttonStyle(.plain)
            .disabled(!viewModel.canGoBackward)

            Button {
                viewModel.togglePlayback()
            } label: {
                Image(viewModel.playPauseSystemImage)
            }
            .buttonStyle(.plain)
            .frame(
                width: 72,
                height: 72
            )

            Button {
                viewModel.playNext()
            } label: {
                Image("ic-forward")
                    .opacity(viewModel.backwardButtonOpacity)
                    .frame(
                        width: 36,
                        height: 36
                    )
            }
            .buttonStyle(.plain)
            .disabled(!viewModel.canGoForward)

            Spacer()
        }
        .padding(.horizontal, SBSpacingToken.spacing24.value)
    }

    var moreOptionsButton: some View {
        Button {
            self.isShowingMoreOptions = true
        } label: {
            Image(systemName: "ellipsis")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(SBColors.primaryIcon)
        }
    }
}

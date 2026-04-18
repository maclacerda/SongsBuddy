//
//  AlbumDetailsView.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import SBDesignSystem
import SwiftUI

public struct AlbumDetailsView: View {
    // MARK: - Properties
    @State private var viewModel: AlbumDetailsViewModel
    private let onSongSelected: ((AlbumSongRowItem, [AlbumSongRowItem]) -> Void)?

    // MARK: - Initializer
    public init(
        viewModel: AlbumDetailsViewModel,
        onSongSelected: ((AlbumSongRowItem, [AlbumSongRowItem]) -> Void)? = nil
    ) {
        self._viewModel = State(initialValue: viewModel)
        self.onSongSelected = onSongSelected
    }

    public var body: some View {
        ZStack {
            SBColors.screenBackground
                .ignoresSafeArea()

            contentView
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadAlbum()
        }
    }
}

// MARK: - Views
private extension AlbumDetailsView {
    var contentView: some View {
        Group {
            if self.viewModel.isLoading {
                ProgressView()
                    .tint(SBColors.primaryIcon)
            } else if let item = viewModel.item {
                albumContentView(item: item)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.sb(.text16))
                    .foregroundStyle(SBColors.primaryText)
            }
        }
    }

    func albumContentView(
        item: AlbumDetailsItem
    ) -> some View {
        ScrollView(
            showsIndicators: false
        ) {
            VStack(
                alignment: .center,
                spacing: .zero
            ) {
                artworkView(item: item)
                    .padding(.top, SBSpacingToken.spacing24.value)

                Text(item.title)
                    .font(.sb(.display20))
                    .foregroundStyle(SBColors.primaryText)
                    .multilineTextAlignment(.center)
                    .padding(.top, SBSpacingToken.spacing16.value)
                    .padding(.horizontal, SBSpacingToken.spacing24.value)

                Text(item.artistName)
                    .font(.sb(.text14))
                    .foregroundStyle(SBColors.primaryText)
                    .multilineTextAlignment(.center)
                    .padding(.top, SBSpacingToken.spacing8.value)
                    .padding(.horizontal, SBSpacingToken.spacing24.value)

                LazyVStack(spacing: .zero) {
                    ForEach(item.songs) { song in
                        Button {
                            if let songs = viewModel.item?.songs,
                               let onSongSelected {
                                onSongSelected(song, songs)
                            }
                        } label: {
                            AlbumSongRowView(item: song)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top, SBSpacingToken.spacing40.value)
                .padding(.horizontal, SBSpacingToken.spacing20.value)
            }
            .padding(.bottom, SBSpacingToken.spacing24.value)
        }
    }

    func artworkView(
        item: AlbumDetailsItem
    ) -> some View {
        AsyncImage(url: item.artworkURL) { phase in
            switch phase {
            case let .success(image):
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
            width: 120,
            height: 120
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: SBRadiusToken.radius20.value
            )
        )
    }

    var placeholderArtworkView: some View {
        RoundedRectangle(
            cornerRadius: SBRadiusToken.radius20.value
        )
        .fill(SBColors.searchBackground)
        .overlay {
            Image(systemName: "music.note")
                .foregroundStyle(SBColors.primaryIcon)
        }
    }
}

//
//  SongsView.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Observation
import SBAlbumFeature
import SBData
import SBDesignSystem
import SBDomain
import SBSongDetailsFeature
import SwiftUI

public struct SongsView: View {
    // MARK: - Properties
    @State private var viewModel: SongsViewModel
    @State private var scrollOffset: CGFloat = .zero
    @State private var selectedSongForDetails: SongRowItem?
    @State private var selectedSong: SongRowItem?
    @State private var isShowingMoreOptions: Bool = false
    @State private var isShowingAlbumFromSheet: Bool = false
    @State private var isShowingRemoveRecentConfirmation: Bool = false

    private let recentlyPlayedRepository: any RecentlyPlayedRepositoryProtocol

    private let expandedHeaderHeight: CGFloat = 124
    private let collapsedHeaderHeight: CGFloat = 104
    private let contentTopSpacing: CGFloat = 16
    private let collapseThreshold: CGFloat = 40

    private var isCollapsed: Bool {
        return self.scrollOffset > self.collapseThreshold
    }

    private var currentHeaderHeight: CGFloat {
        return self.isCollapsed ? self.collapsedHeaderHeight : self.expandedHeaderHeight
    }

    // MARK: - Initializer
    public init(
        viewModel: SongsViewModel,
        recentlyPlayedRepository: any RecentlyPlayedRepositoryProtocol
    ) {
        self._viewModel = State(initialValue: viewModel)
        self.recentlyPlayedRepository = recentlyPlayedRepository
    }

    public var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                SBColors.screenBackground
                    .ignoresSafeArea()

                contentView

                SBSongsHeaderView(
                    isCollapsed: self.isCollapsed,
                    searchText: self.$viewModel.searchText
                )
                .frame(height: self.currentHeaderHeight, alignment: .top)
                .padding(.horizontal, SBSpacingToken.spacing20.value)
                .background(SBColors.screenBackground)
                .animation(.easeInOut(duration: 0.18), value: self.isCollapsed)
            }
            .navigationDestination(isPresented: $isShowingAlbumFromSheet) {
                if let selectedSong,
                   let albumID = selectedSong.albumID {
                    AlbumDetailsView(
                        viewModel: AlbumDetailsViewModel(
                            albumID: albumID,
                            albumTitle: selectedSong.albumName ?? "",
                            artistName: selectedSong.artistName,
                            artworkURL: selectedSong.artworkURL,
                            repository: MusicRepositoryFactory.makeDefault()
                        )
                    )
                }
            }
            .navigationDestination(item: $selectedSongForDetails) { item in
                let item = SongDetailsItem(
                    title: item.title,
                    artistName: item.artistName,
                    artworkURL: item.artworkURL,
                    albumName: item.albumName,
                    previewURL: item.previewURL,
                    albumID: item.albumID
                )

                let viewModel = SongDetailsViewModel(
                    item: item
                )

                SongDetailsView(
                    viewModel: viewModel
                )
            }
            .overlay {
                if isShowingMoreOptions, let selectedSong {
                    ZStack(alignment: .bottom) {
                        Color.black.opacity(0.2)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isShowingMoreOptions = false
                            }

                        MoreOptionsSheetView(
                            title: selectedSong.title ?? "",
                            artistName: selectedSong.artistName,
                            onViewAlbum: {
                                isShowingMoreOptions = false
                                isShowingAlbumFromSheet = true
                            },
                            showsRemoveFromRecents: true,
                            onRemoveFromRecents: {
                                isShowingMoreOptions = false

                                DispatchQueue.main.async {
                                    isShowingRemoveRecentConfirmation = true
                                }
                            }
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 228)
                        .transition(.move(edge: .bottom))
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .preferredColorScheme(.dark)
        .task {
            await viewModel.refreshRecentlyPlayed()
            await viewModel.loadInitialSongs()
        }
        .onAppear {
            Task {
                await viewModel.refreshRecentlyPlayed()
            }
        }
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.scheduleSearch()
        }
        .animation(
            .easeInOut(duration: 0.2),
            value: isShowingMoreOptions
        )
        .alert(
            "Remove from Recently Played?",
            isPresented: self.$isShowingRemoveRecentConfirmation
        ) {
            Button("Cancel", role: .cancel) {}

            Button("Remove", role: .destructive) {
                guard let selectedSong else {
                    return
                }

                Task {
                    await self.viewModel.removeRecentlyPlayed(
                        songID: selectedSong.id
                    )
                }
            }
        } message: {
            Text("This song will be removed from your recently played list.")
        }
    }
}

// MARK: - Views
private extension SongsView {
    var contentView: some View {
        switch self.viewModel.state {
        case .idle, .loading:
            AnyView(
                VStack {
                    Spacer()

                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(SBColors.primaryIcon)

                    Spacer()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
            )

        case .content(let items):
            AnyView(
                ScrollView(
                    showsIndicators: false
                ) {
                    VStack(
                        alignment: .leading,
                        spacing: .zero
                    ) {
                        Color.clear
                            .frame(height: self.currentHeaderHeight + self.contentTopSpacing)

                        listView(with: items)
                    }
                    .padding(.horizontal, SBSpacingToken.spacing20.value)
                    .padding(.bottom, SBSpacingToken.spacing24.value)
                    .background(
                        ScrollOffsetObserver { offset in
                            let normalizedOffset = max(offset, .zero)

                            guard abs(normalizedOffset - self.scrollOffset) > 0.5 else {
                                return
                            }

                            self.scrollOffset = normalizedOffset
                        }
                        .frame(
                            width: .zero,
                            height: .zero
                        )
                    )
                }
            )

        case .empty(let searchTerm):
            AnyView(
                emptyStateView(searchTerm: searchTerm)
            )

        case .error(let message):
            AnyView(
                errorStateView(message: message)
            )
        }
    }

    var recentlyPlayedSection: some View {
        VStack(
            alignment: .leading,
            spacing: .zero
        ) {
            Text("Recently Played")
                .font(.sb(.display20))
                .foregroundStyle(SBColors.primaryText)
                .padding(.bottom, SBSpacingToken.spacing12.value)

            LazyVStack(spacing: .zero) {
                ForEach(self.viewModel.recentlyPlayedItems) { item in
                    SongRowView(
                        item: item,
                        onTap: {
                            Task {
                                await viewModel.markAsRecentlyPlayed(item: item)
                                selectedSongForDetails = item
                            }
                        },
                        onMoreTapped: {
                            selectedSong = item
                            isShowingMoreOptions = true
                        }
                    )
                }
            }
        }
    }

    @ViewBuilder
    func listView(
        with items: [SongRowItem]
    ) -> some View {
        AnyView(
            LazyVStack(
                alignment: .leading,
                spacing: .zero
            ) {
                if viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                   !viewModel.recentlyPlayedItems.isEmpty {
                    recentlyPlayedSection
                        .padding(.bottom, SBSpacingToken.spacing24.value)
                }

                ForEach(items) { item in
                    SongRowView(
                        item: item,
                        onTap: {
                            Task {
                                await viewModel.markAsRecentlyPlayed(item: item)
                                selectedSongForDetails = item
                            }
                        },
                        onMoreTapped: {
                            selectedSong = item
                            isShowingMoreOptions = true
                        }
                    )
                    .onAppear {
                        Task {
                            await viewModel.loadNextPageIfneeded(
                                currentItemID: item.id
                            )
                        }
                    }
                }
            }
        )
    }

    @ViewBuilder
    func emptyStateView(
        searchTerm: String
    ) -> some View {
        VStack(
            spacing: SBSpacingToken.spacing12.value
        ) {
            Text("No results found")
                .font(.sb(.display20))
                .foregroundStyle(SBColors.primaryText)

            Text("\"\(searchTerm)\" returned no matches.")
                .font(.sb(.text14))
                .foregroundStyle(SBColors.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(SBSpacingToken.spacing24.value)
    }

    @ViewBuilder
    func errorStateView(
        message: String
    ) -> some View {
        VStack(
            spacing: SBSpacingToken.spacing12.value
        ) {
            Text("Unable to load songs")
                .font(.sb(.display20))
                .foregroundStyle(SBColors.primaryText)

            Text(message)
                .font(.sb(.text14))
                .foregroundStyle(SBColors.secondaryText)
                .multilineTextAlignment(.center)

            Button("Retry") {
                Task {
                    await self.viewModel.retry()
                }
            }
            .font(.sb(.text16))
            .foregroundStyle(SBColors.primaryText)
            .padding(.horizontal, SBSpacingToken.spacing16.value)
            .padding(.vertical, SBSpacingToken.spacing12.value)
            .background(SBColors.searchBackground)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: SBRadiusToken.radius12.value
                )
            )
        }
        .frame(maxWidth: .infinity)
        .padding(SBSpacingToken.spacing24.value)
    }
}

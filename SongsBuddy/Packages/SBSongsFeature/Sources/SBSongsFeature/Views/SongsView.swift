//
//  SongsView.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Observation
import SBDesignSystem
import SwiftUI

public struct SongsView: View {
    // MARK: - Properties
    @State private var viewModel: SongsViewModel
    @State private var scrollOffset: CGFloat = .zero

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
        viewModel: SongsViewModel = SongsViewModel()
    ) {
        self._viewModel = State(initialValue: viewModel)
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            SBColors.screenBackground
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(
                    alignment: .leading,
                    spacing: .zero
                ) {
                    Color.clear
                        .frame(height: self.currentHeaderHeight + self.contentTopSpacing)

                    contentView
                }
                .padding(.horizontal, SBSpacingToken.spacing20.value)
                .padding(.bottom, SBSpacingToken.spacing24.value)
                .background(
                    ScrollOffsetObserver { offset in
                        let normalizedOffset = max(offset, 0)

                        guard abs(normalizedOffset - self.scrollOffset) > 0.5 else {
                            return
                        }

                        self.scrollOffset = normalizedOffset
                    }
                    .frame(width: 0, height: 0)
                )
            }

            SBSongsHeaderView(
                isCollapsed: self.isCollapsed
            )
            .frame(height: self.currentHeaderHeight, alignment: .top)
            .padding(.horizontal, SBSpacingToken.spacing20.value)
            .background(SBColors.screenBackground)
            .animation(.easeInOut(duration: 0.18), value: self.isCollapsed)
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Views
private extension SongsView {
    var contentView: some View {
        switch self.viewModel.state {
        case .idle, .loading:
            AnyView(
                ProgressView()
                    .tint(SBColors.primaryIcon)
                    .frame(maxWidth: .infinity)
            )

        case let .content(items):
            AnyView(
                LazyVStack(spacing: .zero) {
                    ForEach(items) { item in
                        SongRowView(item: item)
                    }
                }
            )

        case let .empty(searchTerm):
            AnyView(
                emptyStateView(searchTerm: searchTerm)
            )
        }
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
}

//
//  SBSongsHeaderView.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import SBDesignSystem
import SwiftUI

struct SBSongsHeaderView: View {
    // MARK: - Properties
    let collapseProgress: CGFloat
    let onCollapsedSearchTapped: () -> Void

    @Binding var searchText: String
    @FocusState.Binding var isSearchFieldFocused: Bool

    /// Header animation attributes
    private var collapsedOpacity: Double {
        return Double(collapseProgress)
    }

    private var expandedOpacity: Double {
        return Double(1 - collapseProgress)
    }

    private var expandedOffsetY: CGFloat {
        return -16 * collapseProgress
    }

    private var collapsedOffsetY: CGFloat {
        return 12 * (1 - collapseProgress)
    }

    private var expandedScale: CGFloat {
        return 1 - (0.04 * collapseProgress)
    }

    private var collapsedScale: CGFloat {
        return 0.96 + (0.04 * collapseProgress)
    }

    private var isCollapsed: Bool {
        return collapseProgress > 0.5
    }

    private var containerHeight: CGFloat {
        return isCollapsed ? 58 : 124
    }

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            expandedHeader
                .opacity(expandedOpacity)
                .scaleEffect(expandedScale, anchor: .top)
                .offset(y: expandedOffsetY)
                .allowsHitTesting(collapseProgress < 0.5)

            collapsedHeader
                .opacity(collapsedOpacity)
                .scaleEffect(collapsedScale, anchor: .top)
                .offset(y: collapsedOffsetY)
                .allowsHitTesting(collapseProgress > 0.5)
        }
        .frame(
            maxWidth: .infinity,
            minHeight: containerHeight,
            maxHeight: containerHeight,
            alignment: .top
        )
        .clipped()
        .background(SBColors.screenBackground)
    }
}

// MARK: - Views
private extension SBSongsHeaderView {
    var expandedHeader: some View {
        VStack(
            alignment: .leading,
            spacing: .zero
        ) {
            VStack(spacing: .zero) {
                Text("Songs")
                    .font(.sb(.display24))
                    .foregroundStyle(SBColors.primaryText)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
            }
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .padding(.horizontal, 24)

            VStack(
                spacing: .zero
            ) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(
                            .system(
                                size: 24,
                                weight: .regular
                            )
                        )
                        .foregroundStyle(SBColors.searchIcon)
                        .frame(
                            width: 24,
                            height: 24
                        )
                        .padding(.leading, 16)

                    TextField(
                        "",
                        text: $searchText,
                        prompt: Text("Search")
                            .foregroundStyle(SBColors.searchPlaceholder)
                    )
                    .font(.sb(.text16))
                    .foregroundStyle(SBColors.primaryText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .tint(SBColors.primaryText)
                    .focused($isSearchFieldFocused)
                    .frame(
                        maxWidth: .infinity
                    )
                }
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(SBColors.searchBackground)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: SBRadiusToken.radius12.value
                    )
                )
                .padding(.horizontal, 20)
            }
            .frame(height: 60)
            .frame(
                maxWidth: .infinity,
                alignment: .center
            )
        }
    }

    var collapsedHeader: some View {
        HStack(spacing: .zero) {
            searchButton

            Spacer()

            Text("Songs")
                .font(.sb(.display16))
                .foregroundStyle(SBColors.primaryText)

            Spacer()

            Color.clear
                .frame(
                    width: 48,
                    height: 48
                )
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }

    var searchButton: some View {
        Button {
            onCollapsedSearchTapped()
        } label: {
            Image("ic-search")
                .frame(
                    width: 48,
                    height: 48
                )
        }
        .buttonStyle(.plain)
    }
}

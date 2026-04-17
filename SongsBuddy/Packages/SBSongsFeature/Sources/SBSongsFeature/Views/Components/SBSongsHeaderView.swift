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
    let isCollapsed: Bool
    let onCollapsedSearchTapped: () -> Void

    @Binding var searchText: String
    @FocusState.Binding var isSearchFieldFocused: Bool

    // MARK: - Body
    var body: some View {
        Group {
            if isCollapsed {
                collapsedHeader
            } else {
                expandedHeader
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: .top
        )
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
            Spacer()
                .frame(height: 9.5)

            Text("Songs")
                .font(.sb(.display24))
                .foregroundStyle(SBColors.primaryText)
                .padding(.leading, SBSpacingToken.spacing24.value)

            Spacer()
                .frame(height: 9.5)

            HStack(
                spacing: SBSpacingToken.spacing8.value
            ) {
                VStack {
                    Image(systemName: "magnifyingglass")
                        .font(
                            .system(
                                size: 18,
                                weight: .regular
                            )
                        )
                        .foregroundStyle(SBColors.searchIcon)
                }
                .frame(
                    width: 44,
                    height: 44,
                    alignment: .center
                )

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

                Spacer(
                    minLength: .zero
                )
            }
            .padding(.horizontal, SBSpacingToken.spacing16.value)
            .frame(height: 60)
            .background(SBColors.searchBackground)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: SBRadiusToken.radius12.value
                )
            )
            .padding(.horizontal, SBSpacingToken.spacing20.value)
        }
    }

    var collapsedHeader: some View {
        VStack(
            alignment: .leading,
            spacing: .zero
        ) {
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
            .frame(height: 48)
            .padding(.horizontal, SBSpacingToken.spacing20.value)
            .padding(.top, 28)
        }
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

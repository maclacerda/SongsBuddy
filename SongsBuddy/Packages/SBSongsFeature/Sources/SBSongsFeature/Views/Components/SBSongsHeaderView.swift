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
    @Binding var searchText: String

    // MARK: - Body
    var body: some View {
        Group {
            if self.isCollapsed {
                collapsedHeader
            } else {
                expandedHeader
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
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
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(SBColors.searchIcon)

                TextField(
                    "",
                    text: self.$searchText,
                    prompt: Text(
                        "Search"
                    )
                    .foregroundStyle(SBColors.searchPlaceholder)
                )
                .font(.sb(.text16))
                .foregroundStyle(SBColors.primaryText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .tint(SBColors.primaryText)

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
                    .font(.sb(.text16))
                    .foregroundStyle(SBColors.primaryText)

                Spacer()

                Color.clear
                    .frame(width: 48, height: 48)
            }
            .frame(height: 48)
            .padding(.horizontal, SBSpacingToken.spacing20.value)
            .padding(.top, 28)
        }
    }

    var searchButton: some View {
        ZStack {
            Circle()
                .fill(SBColors.searchBackground)
                .frame(width: 48, height: 48)

            Image(systemName: "magnifyingglass")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(SBColors.primaryIcon)
        }
    }
}

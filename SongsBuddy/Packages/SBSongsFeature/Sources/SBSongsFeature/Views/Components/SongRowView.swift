//
//  SongRowView.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import SBDesignSystem
import SwiftUI

/// Renders a single song row in the Songs list.
public struct SongRowView: View {
    // MARK: - Properties
    private let item: SongRowItem

    // MARK: - Initializer
    public init(
        item: SongRowItem
    ) {
        self.item = item
    }

    // MARK: - Body
    public var body: some View {
        HStack(spacing: SBSpacingToken.spacing16.value) {
            artworkView

            VStack(
                alignment: .leading,
                spacing: SBSpacingToken.spacing4.value
            ) {
                Text(self.item.title)
                    .font(.sb(.text16))
                    .foregroundStyle(SBColors.primaryText)
                    .lineLimit(1)

                Text(self.item.artistName)
                    .font(.sb(.text12))
                    .foregroundStyle(SBColors.tertiaryText)
                    .lineLimit(1)
            }

            Spacer()

            Image(systemName: "ellipsis")
                .foregroundStyle(SBColors.tertiaryText)
                .frame(width: 36, height: 36)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 68)
        .contentShape(Rectangle())
    }
}

// MARK: - Views
private extension SongRowView {
    var artworkView: some View {
        AsyncImage(url: self.item.artworkURL) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()

            case .empty, .failure:
                placeholderArtworkView

            @unknown default:
                placeholderArtworkView
            }
        }
        .frame(
            width: 52,
            height: 52
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: SBRadiusToken.radius8.value
            )
        )
    }

    var placeholderArtworkView: some View {
        RoundedRectangle(
            cornerRadius: SBRadiusToken.radius8.value
        )
        .fill(SBColors.searchBackground)
        .overlay {
            Image(systemName: "music.note")
                .foregroundStyle(SBColors.primaryIcon)
        }
    }
}

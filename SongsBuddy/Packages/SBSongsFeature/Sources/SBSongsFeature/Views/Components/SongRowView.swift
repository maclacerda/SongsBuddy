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
    private let onTap: () -> Void
    private let onMoreTapped: () -> Void

    // MARK: - Initializer
    public init(
        item: SongRowItem,
        onTap: @escaping () -> Void,
        onMoreTapped: @escaping () -> Void
    ) {
        self.item = item
        self.onTap = onTap
        self.onMoreTapped = onMoreTapped
    }

    // MARK: - Body
    public var body: some View {
        Button {
            onTap()
        } label: {
            HStack(
                spacing: SBSpacingToken.spacing16.value
            ) {
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

                Button {
                    onMoreTapped()
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(SBColors.secondaryIcon)
                        .frame(
                            width: 20,
                            height: 20
                        )
                }
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .frame(height: 68)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
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

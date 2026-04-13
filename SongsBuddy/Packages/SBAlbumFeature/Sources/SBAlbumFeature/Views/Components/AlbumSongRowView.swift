//
//  AlbumSongRowView.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import SBDesignSystem
import SwiftUI

struct AlbumSongRowView: View {
    // MARK: - Properties
    let item: AlbumSongRowItem

    var body: some View {
        HStack(spacing: SBSpacingToken.spacing16.value) {
            artworkView

            VStack(
                alignment: .leading,
                spacing: SBSpacingToken.spacing4.value
            ) {
                Text(self.item.title)
                    .font(.sb(.text16))
                    .foregroundStyle(SBColors.primaryText)

                Text(self.item.artistName)
                    .font(.sb(.text12))
                    .foregroundStyle(SBColors.tertiaryText)
                    .lineLimit(1)
            }

            Spacer()
        }
        .frame(
            minHeight: 60
        )
    }
}

// MARK: - Views
private extension AlbumSongRowView {
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
            width: 44,
            height: 44
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

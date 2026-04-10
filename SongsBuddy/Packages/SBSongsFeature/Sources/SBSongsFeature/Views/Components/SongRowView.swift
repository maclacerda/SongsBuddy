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
    public init(item: SongRowItem) {
        self.item = item
    }

    public var body: some View {
        return HStack(spacing: SBSpacingToken.spacing16.value) {
            RoundedRectangle(cornerRadius: SBRadiusToken.radius8.value)
                .fill(SBColors.searchBackground)
                .frame(width: 52, height: 52)
                .overlay {
                    Image(systemName: "music.note")
                        .foregroundStyle(SBColors.primaryIcon)
                }

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
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .listRowBackground(SBColors.screenBackground)
    }
}

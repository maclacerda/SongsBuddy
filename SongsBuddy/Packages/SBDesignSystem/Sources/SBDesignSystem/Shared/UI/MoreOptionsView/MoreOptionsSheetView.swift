//
//  MoreOptionsSheetView.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import SwiftUI

public struct MoreOptionsSheetView: View {
    // MARK: - Properties
    private let title: String
    private let artistName: String
    private let onViewAlbum: () -> Void
    private let showsRemoveFromRecents: Bool
    private let onRemoveFromRecents: (() -> Void)?

    // MARK: - Initializer
    public init(
        title: String,
        artistName: String,
        onViewAlbum: @escaping () -> Void,
        showsRemoveFromRecents: Bool = false,
        onRemoveFromRecents: (() -> Void)? = nil
    ) {
        self.title = title
        self.artistName = artistName
        self.onViewAlbum = onViewAlbum
        self.showsRemoveFromRecents = showsRemoveFromRecents
        self.onRemoveFromRecents = onRemoveFromRecents
    }

    public var body: some View {
        VStack(
            spacing: .zero
        ) {
            grabberView
                .padding(.top, 4.5)

            Text(self.title)
                .font(.sb(.display18))
                .foregroundStyle(SBColors.primaryText)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, SBSpacingToken.spacing16.value)
                .padding(.horizontal, SBSpacingToken.spacing24.value)

            Text(self.artistName)
                .font(.sb(.text14))
                .foregroundStyle(SBColors.primaryText)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(.top, SBSpacingToken.spacing8.value)
                .padding(.horizontal, SBSpacingToken.spacing24.value)

            Button {
                self.onViewAlbum()
            } label: {
                HStack(
                    spacing: .zero
                ) {
                    Image("ic-setlist")
                        .frame(
                            width: 24,
                            height: 24
                        )

                    Text("View Album")
                        .font(.sb(.text16))
                        .foregroundStyle(SBColors.primaryText)
                        .padding(.leading, SBSpacingToken.spacing16.value)

                    Spacer()
                }
                .padding(.horizontal, SBSpacingToken.spacing24.value)
                .frame(height: 56)
            }
            .buttonStyle(.plain)
            .padding(.top, SBSpacingToken.spacing24.value)

            if showsRemoveFromRecents {
                Button {
                    onRemoveFromRecents?()
                } label: {
                    HStack(spacing: .zero) {
                        Image(systemName: "clock.badge.xmark")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(SBColors.primaryIcon)
                            .frame(
                                width: 24,
                                height: 24
                            )

                        Text("Remove from Recents")
                            .font(.sb(.text16))
                            .foregroundStyle(SBColors.primaryText)
                            .padding(.leading, SBSpacingToken.spacing16.value)

                        Spacer()
                    }
                    .padding(.horizontal, SBSpacingToken.spacing24.value)
                    .frame(height: 56)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 4)
            }

            Spacer(minLength: .zero)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .background(.thinMaterial)
        .background(SBColors.surfaceBackground)
        .clipShape(
            RoundedRectangle(
                cornerRadius: SBRadiusToken.radius16.value
            )
        )
    }
}

// MARK: - Views
private extension MoreOptionsSheetView {
    var grabberView: some View {
        Capsule()
            .fill(SBColors.searchIcon)
            .frame(width: 56, height: 5)
    }
}

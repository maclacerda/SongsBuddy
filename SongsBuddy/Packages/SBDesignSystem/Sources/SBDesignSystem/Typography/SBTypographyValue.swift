//
//  SBTypographyValue.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/10/26.
//

import SwiftUI

/// Represents the resolved typography attributes for a design system token.
public struct SBTypographyValue: Sendable {
    /// The font family to be used.
    public let fontFamily: SBFontFamily

    /// The font size in points.
    public let fontSize: CGFloat

    /// The font line height multiplier.
    public let lineHeightMultiplier: CGFloat

    /// The SwiftUI font weight.
    public let fontWeight: Font.Weight

    // MARK: - Initializer
    public init(
        fontFamily: SBFontFamily,
        fontSize: CGFloat,
        lineHeightMultiplier: CGFloat,
        fontWeight: Font.Weight
    ) {
        self.fontFamily = fontFamily
        self.fontSize = fontSize
        self.lineHeightMultiplier = lineHeightMultiplier
        self.fontWeight = fontWeight
    }
}

public extension SBTypographyToken {
    /// Returns the resolved typography value for the current token.
    var value: SBTypographyValue {
        switch self {
        case .display16:
            return SBTypographyValue(
                fontFamily: .articulatCFDemiBold,
                fontSize: 16,
                lineHeightMultiplier: 1.2,
                fontWeight: .semibold
            )

        case .display18:
            return SBTypographyValue(
                fontFamily: .articulatCFDemiBold,
                fontSize: 18,
                lineHeightMultiplier: 1.08,
                fontWeight: .semibold
            )

        case .display20:
            return SBTypographyValue(
                fontFamily: .articulatCFDemiBold,
                fontSize: 20,
                lineHeightMultiplier: 1.2,
                fontWeight: .semibold
            )

        case .display24:
            return SBTypographyValue(
                fontFamily: .articulatCFDemiBold,
                fontSize: 24,
                lineHeightMultiplier: 1.2,
                fontWeight: .semibold
            )

        case .display32:
            return SBTypographyValue(
                fontFamily: .articulatCFDemiBold,
                fontSize: 32,
                lineHeightMultiplier: 1.2,
                fontWeight: .semibold
            )

        case .text12:
            return SBTypographyValue(
                fontFamily: .articulatCFMedium,
                fontSize: 12,
                lineHeightMultiplier: 1.4,
                fontWeight: .medium
            )

        case .text14:
            return SBTypographyValue(
                fontFamily: .articulatCFMedium,
                fontSize: 14,
                lineHeightMultiplier: 1.2,
                fontWeight: .medium
            )

        case .text16:
            return SBTypographyValue(
                fontFamily: .articulatCFMedium,
                fontSize: 16,
                lineHeightMultiplier: 1.2,
                fontWeight: .medium
            )
        }
    }
}

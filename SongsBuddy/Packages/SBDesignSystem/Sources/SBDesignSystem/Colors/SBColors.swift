//
//  SBColors.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/10/26.
//

import SwiftUI

/// Provides semantic color access for the SongsBuddy design system.
public enum SBColors {
    // MARK: - Background

    /// Primary screen background color.
    public static let screenBackground = SBColorToken.dark(.background(.background00)).value

    /// Elevated surface background (e.g. bottom sheets).
    public static let surfaceBackground = SBColorToken.dark(.background(.backgroundAlpha01)).value

    // MARK: - Text

    /// Primary text color.
    public static let primaryText = SBColorToken.dark(.text(.text03)).value

    /// Secondary text color.
    public static let secondaryText = SBColorToken.dark(.text(.text01)).value

    /// Tertiary text color.
    public static let tertiaryText = SBColorToken.dark(.text(.text00)).value

    // MARK: - Icons / Elements

    /// Primary icon color.
    public static let primaryIcon = SBColorToken.dark(.element(.element07)).value

    /// Secondary icon color.
    public static let secondaryIcon = SBColorToken.dark(.element(.element03)).value

    // MARK: - Search

    /// Search bar background.
    public static let searchBackground = SBColorToken.dark(.alphaInverted(.alpha10)).value

    /// Search icon color.
    public static let searchIcon = SBColorToken.dark(.alphaInverted(.alpha25)).value

    /// Search placeholder text color.
    public static let searchPlaceholder = SBColorToken.dark(.text(.text01)).value

    // MARK: - Player

    /// Progress track color.
    public static let progressTrack = SBColorToken.dark(.base(.white25A)).value

    /// Progress fill color.
    public static let progressFill = SBColorToken.dark(.base(.white60A)).value

    /// Slider thumb color.
    public static let sliderThumb = SBColorToken.dark(.base(.white)).value
}

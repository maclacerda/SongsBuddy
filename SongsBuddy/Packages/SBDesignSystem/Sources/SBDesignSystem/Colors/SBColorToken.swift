//
//  SBColorToken.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/9/26.
//

import Foundation

/// Defines all color tokens supported by the SongsBuddy design system.
public enum SBColorToken: Sendable {
    /// Dark appearance color token.
    case dark(SBDarkColorToken)

    /// Light appearance color token.
    case light(SBLightColorToken)
}

/// Defines the dark appearance color groups.
public enum SBDarkColorToken: Sendable {
    /// Background-related colors.
    case background(SBBackgroundColorToken)

    /// Text-related colors.
    case text(SBTextColorToken)

    /// Element-related colors (icons, controls).
    case element(SBElementColorToken)

    /// Alpha inverted colors.
    case alphaInverted(SBAlphaInvertedColorToken)

    /// Base colors (white variations).
    case base(SBBaseColorToken)
}

/// Defines the light appearance color groups.
public enum SBLightColorToken: Sendable {
    /// Background-related colors.
    case background(SBBackgroundColorToken)

    /// Text-related colors.
    case text(SBTextColorToken)

    /// Element-related colors.
    case element(SBElementColorToken)

    /// Alpha inverted colors.
    case alphaInverted(SBAlphaInvertedColorToken)

    /// Base colors.
    case base(SBBaseColorToken)
}

/// Defines background-related color tokens.
public enum SBBackgroundColorToken: Sendable {
    /// Primary screen background.
    case background00

    /// Elevated background (e.g., bottom sheet).
    case backgroundAlpha01
}

/// Defines text-related color tokens.
public enum SBTextColorToken: Sendable {
    /// Secondary/tertiary text (#737373).
    case text00

    /// Placeholder text (#ABABAB).
    case text01

    /// Primary text (#FFFFFF).
    case text03
}

/// Defines element-related color tokens.
public enum SBElementColorToken: Sendable {
    /// Primary icon/button color.
    case element07
}

/// Defines alpha-inverted color tokens.
public enum SBAlphaInvertedColorToken: Sendable {
    /// White with 10% opacity.
    case alpha10

    /// White with 25% opacity.
    case alpha25
}

/// Defines base color tokens.
public enum SBBaseColorToken: Sendable {
    /// Pure white color.
    case white

    /// White with 20% opacity.
    case white20A

    /// White with 25% opacity.
    case white25A

    /// White with 60% opacity.
    case white60A

    /// White with 70% opacity.
    case white70A
}

//
//  SBColorValue.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/10/26.
//

import SwiftUI

/// Resolves design system color tokens into concrete SwiftUI colors.
public extension SBColorToken {
    /// Returns the resolved SwiftUI color for the current token.
    var value: Color {
        switch self {
        case let .dark(token):
            return token.value

        case let .light(token):
            return token.value
        }
    }
}

private extension SBDarkColorToken {
    /// Returns the resolved SwiftUI color for a dark appearance token group.
    var value: Color {
        switch self {
        case let .background(token):
            return token.darkValue

        case let .text(token):
            return token.darkValue

        case let .element(token):
            return token.darkValue

        case let .alphaInverted(token):
            return token.darkValue

        case let .base(token):
            return token.darkValue
        }
    }
}

private extension SBLightColorToken {
    /// Returns the resolved SwiftUI color for a light appearance token group.
    var value: Color {
        switch self {
        case let .background(token):
            return token.lightValue

        case let .text(token):
            return token.lightValue

        case let .element(token):
            return token.lightValue

        case let .alphaInverted(token):
            return token.lightValue

        case let .base(token):
            return token.lightValue
        }
    }
}

private extension SBBackgroundColorToken {
    /// Returns the dark appearance value for the current background token.
    var darkValue: Color {
        switch self {
        case .background00:
            return Color(hex: "#000000")

        case .backgroundAlpha01:
            return Color(hex: "#262626").opacity(0.8)
        }
    }

    /// Returns the light appearance value for the current background token.
    var lightValue: Color {
        switch self {
        case .background00:
            return Color(hex: "#F7F7F8")

        case .backgroundAlpha01:
            return Color(hex: "#FFFFFF").opacity(0.9)
        }
    }
}

private extension SBTextColorToken {
    /// Returns the dark appearance value for the current text token.
    var darkValue: Color {
        switch self {
        case .text00:
            return Color(hex: "#737373")

        case .text01:
            return Color(hex: "#ABABAB")

        case .text03:
            return Color(hex: "#FFFFFF")
        }
    }

    /// Returns the light appearance value for the current text token.
    var lightValue: Color {
        switch self {
        case .text00:
            return Color(hex: "#8A8A8A")

        case .text01:
            return Color(hex: "#6B6B6B")

        case .text03:
            return Color(hex: "#111111")
        }
    }
}

private extension SBElementColorToken {
    /// Returns the dark appearance value for the current element token.
    var darkValue: Color {
        switch self {
        case .element07:
            return Color(hex: "#FFFFFF")

        case .element03:
            return Color(hex: "#545454")
        }
    }

    /// Returns the light appearance value for the current element token.
    var lightValue: Color {
        switch self {
        case .element07:
            return Color(hex: "#111111")

        case .element03:
            return Color(hex: "#545454")
        }
    }
}

private extension SBAlphaInvertedColorToken {
    /// Returns the dark appearance value for the current alpha-inverted token.
    var darkValue: Color {
        switch self {
        case .alpha10:
            return Color.white.opacity(0.10)

        case .alpha25:
            return Color.white.opacity(0.25)
        }
    }

    /// Returns the light appearance value for the current alpha-inverted token.
    var lightValue: Color {
        switch self {
        case .alpha10:
            return Color.black.opacity(0.06)

        case .alpha25:
            return Color.black.opacity(0.25)
        }
    }
}

private extension SBBaseColorToken {
    /// Returns the dark appearance value for the current base token.
    var darkValue: Color {
        switch self {
        case .white:
            return Color(hex: "#FFFFFF")

        case .white20A:
            return Color.white.opacity(0.20)

        case .white25A:
            return Color.white.opacity(0.25)

        case .white60A:
            return Color.white.opacity(0.60)

        case .white70A:
            return Color.white.opacity(0.70)
        }
    }

    /// Returns the light appearance value for the current base token.
    var lightValue: Color {
        switch self {
        case .white:
            return Color(hex: "#111111")

        case .white20A:
            return Color.black.opacity(0.12)

        case .white25A:
            return Color.black.opacity(0.16)

        case .white60A:
            return Color.black.opacity(0.60)

        case .white70A:
            return Color.black.opacity(0.70)
        }
    }
}

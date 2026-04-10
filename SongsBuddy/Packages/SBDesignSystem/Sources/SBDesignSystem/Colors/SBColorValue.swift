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
            token.value

        case let .light(token):
            token.value
        }
    }
}

private extension SBDarkColorToken {
    /// Returns the resolved SwiftUI color for a dark appearance token group.
    var value: Color {
        switch self {
        case let .background(token):
            token.darkValue

        case let .text(token):
            token.darkValue

        case let .element(token):
            token.darkValue

        case let .alphaInverted(token):
            token.darkValue

        case let .base(token):
            token.darkValue
        }
    }
}

private extension SBLightColorToken {
    /// Returns the resolved SwiftUI color for a light appearance token group.
    var value: Color {
        switch self {
        case let .background(token):
            token.lightValue

        case let .text(token):
            token.lightValue

        case let .element(token):
            token.lightValue

        case let .alphaInverted(token):
            token.lightValue

        case let .base(token):
            token.lightValue
        }
    }
}

private extension SBBackgroundColorToken {
    /// Returns the dark appearance value for the current background token.
    var darkValue: Color {
        switch self {
        case .background00:
            Color(hex: "#000000")

        case .backgroundAlpha01:
            Color(hex: "#262626").opacity(0.8)
        }
    }

    /// Returns the light appearance value for the current background token.
    var lightValue: Color {
        switch self {
        case .background00:
            Color(hex: "#F7F7F8")

        case .backgroundAlpha01:
            Color(hex: "#FFFFFF").opacity(0.9)
        }
    }
}

private extension SBTextColorToken {
    /// Returns the dark appearance value for the current text token.
    var darkValue: Color {
        switch self {
        case .text00:
            Color(hex: "#737373")

        case .text01:
            Color(hex: "#ABABAB")

        case .text03:
            Color(hex: "#FFFFFF")
        }
    }

    /// Returns the light appearance value for the current text token.
    var lightValue: Color {
        switch self {
        case .text00:
            Color(hex: "#8A8A8A")

        case .text01:
            Color(hex: "#6B6B6B")

        case .text03:
            Color(hex: "#111111")
        }
    }
}

private extension SBElementColorToken {
    /// Returns the dark appearance value for the current element token.
    var darkValue: Color {
        switch self {
        case .element07:
            Color(hex: "#FFFFFF")
        }
    }

    /// Returns the light appearance value for the current element token.
    var lightValue: Color {
        switch self {
        case .element07:
            Color(hex: "#111111")
        }
    }
}

private extension SBAlphaInvertedColorToken {
    /// Returns the dark appearance value for the current alpha-inverted token.
    var darkValue: Color {
        switch self {
        case .alpha10:
            Color.white.opacity(0.10)

        case .alpha25:
            Color.white.opacity(0.25)
        }
    }

    /// Returns the light appearance value for the current alpha-inverted token.
    var lightValue: Color {
        switch self {
        case .alpha10:
            Color.black.opacity(0.06)

        case .alpha25:
            Color.black.opacity(0.25)
        }
    }
}

private extension SBBaseColorToken {
    /// Returns the dark appearance value for the current base token.
    var darkValue: Color {
        switch self {
        case .white:
            Color(hex: "#FFFFFF")

        case .white20A:
            Color.white.opacity(0.20)

        case .white25A:
            Color.white.opacity(0.25)

        case .white60A:
            Color.white.opacity(0.60)

        case .white70A:
            Color.white.opacity(0.70)
        }
    }

    /// Returns the light appearance value for the current base token.
    var lightValue: Color {
        switch self {
        case .white:
            Color(hex: "#111111")

        case .white20A:
            Color.black.opacity(0.12)

        case .white25A:
            Color.black.opacity(0.16)

        case .white60A:
            Color.black.opacity(0.60)

        case .white70A:
            Color.black.opacity(0.70)
        }
    }
}

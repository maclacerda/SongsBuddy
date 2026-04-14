//
//  SBGradientToken.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/14/26.
//

import SwiftUI

/// Defines the gradient tokens available in the design system.
public enum SBGradientToken: String, Sendable {
    /// Spotlight gradient used in the splash background.
    case spotlight

    public var value: LinearGradient {
        switch self {
        case .spotlight:
            return LinearGradient(
                colors: [
                    Color(hex: "#000000"),
                    Color(hex: "#0086A0")
                ],
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
        }
    }
}

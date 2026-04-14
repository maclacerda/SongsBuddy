//
//  SBGradients.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/14/26.
//

import SwiftUI

/// Exposes semantic gradient values used by the application.
public enum SBGradients {
    /// Spotlight gradient used in the splash screen background.
    public static var spotlight: LinearGradient {
        return SBGradientToken.spotlight.value
    }
}

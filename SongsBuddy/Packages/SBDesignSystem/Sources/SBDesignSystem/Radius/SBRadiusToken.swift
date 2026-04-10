//
//  SBRadiusToken.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/9/26.
//

import Foundation

/// Defines the corner radius scale used across the SongsBuddy design system.
public enum SBRadiusToken: CGFloat, CaseIterable, Sendable {
    /// 5pt corner radius.
    case radius5 = 5

    /// 8pt corner radius.
    case radius8 = 8

    /// 12pt corner radius.
    case radius12 = 12

    /// 16pt corner radius.
    case radius16 = 16

    /// 20pt corner radius.
    case radius20 = 20

    /// 24pt corner radius.
    case radius24 = 24

    /// 32pt corner radius (used in player artwork).
    case radius32 = 32

    /// 35pt corner radius (used in slider thumb).
    case radius35 = 35

    /// 100pt radius (pill / fully rounded).
    case radius100 = 100
}

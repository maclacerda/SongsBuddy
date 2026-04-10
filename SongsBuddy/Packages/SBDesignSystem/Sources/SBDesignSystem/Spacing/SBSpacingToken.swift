//
//  SBSpacingToken.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/9/26.
//

import Foundation

/// Defines the spacing scale used across the SongsBuddy design system.
public enum SBSpacingToken: CGFloat, CaseIterable, Sendable {
    /// 4pt spacing.
    case spacing4 = 4

    /// 8pt spacing.
    case spacing8 = 8

    /// 10pt spacing.
    case spacing10 = 10

    /// 12pt spacing.
    case spacing12 = 12

    /// 16pt spacing.
    case spacing16 = 16

    /// 20pt spacing.
    case spacing20 = 20

    /// 24pt spacing.
    case spacing24 = 24

    /// 32pt spacing.
    case spacing32 = 32

    /// 33pt spacing (used in player bottom spacing).
    case spacing33 = 33

    /// 40pt spacing.
    case spacing40 = 40

    /// Returns the numeric value of the spacing token.
    public var value: CGFloat {
        return self.rawValue
    }
}

//
//  Font+SB.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/10/26.
//

import SwiftUI

public extension Font {
    /// Creates a SwiftUI font from a SongsBuddy typography token.
    static func sb(_ token: SBTypographyToken) -> Font {
        let value = token.value
        return .custom(value.fontFamily.rawValue, size: value.fontSize)
    }
}

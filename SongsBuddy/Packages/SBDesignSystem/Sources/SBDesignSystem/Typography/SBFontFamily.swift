//
//  SBFontFamily.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/9/26.
//

import Foundation

/// Defines the custom font family names used by the SongsBuddy design system.
public enum SBFontFamily: String, Sendable {
    /// Articulat CF Medium font.
    case articulatCFMedium = "ArticulatCF-Medium"

    /// Articulat CF DemiBold font.
    case articulatCFDemiBold = "ArticulatCF-DemiBold"

    /// Returns the resource file name.
    var fileName: String {
        return self.rawValue
    }

    /// Returns the font file extension.
    var fileExtension: String {
        return "otf"
    }

    /// Returns the font family name.
    public var value: String {
        return self.rawValue
    }
}

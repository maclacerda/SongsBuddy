//
//  SBFontRegister.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/17/26.
//

import CoreText
import Foundation

enum SBFontRegister {
    // MARK: - Properties
    private static let registerFontsOnce: Void = {
        let allFonts: [SBFontFamily] = [
            .articulatCFMedium,
            .articulatCFDemiBold
        ]

        for font in allFonts {
            guard let fontURL = Bundle.module.url(
                forResource: font.fileName,
                withExtension: font.fileExtension,
                subdirectory: "Fonts"
            ) ?? Bundle.module.url(
                forResource: font.fileName,
                withExtension: font.fileExtension
            ) else {
                continue
            }

            CTFontManagerRegisterFontsForURL(
                fontURL as CFURL,
                .process,
                nil
            )
        }
    }()

    // MARK: - Methods
    static func registerIfNeeded() {
        _ = Self.registerFontsOnce
    }
}

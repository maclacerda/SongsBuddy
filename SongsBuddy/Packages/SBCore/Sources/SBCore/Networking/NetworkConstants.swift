//
//  NetworkConstants.swift
//  SBCore
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Centralizes networking constants used across the application.
public enum NetworkConstants {
    // MARK: - Properties
    private static let baseURLParts: [String] = [
        "https://",
        "itunes",
        ".apple",
        ".com"
    ]

    /// Base URL used by the remote APIs.
    public static var baseURLString: String {
        return self.baseURLParts.joined()
    }
}

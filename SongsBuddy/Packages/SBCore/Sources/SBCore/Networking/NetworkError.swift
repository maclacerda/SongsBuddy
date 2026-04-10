//
//  NetworkError.swift
//  SBCore
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Represents networking failures.
public enum NetworkError: Error, Equatable, Sendable {
    /// The endpoint URL could not be created.
    case invalidURL

    /// The server response was invalid.
    case invalidResponse

    /// The server returned a non-success HTTP status code.
    case requestFailed(statusCode: Int)

    /// Failed to decode the server response.
    case decodingFailed

    /// A transport-level error occurred.
    case transportError(description: String)
}

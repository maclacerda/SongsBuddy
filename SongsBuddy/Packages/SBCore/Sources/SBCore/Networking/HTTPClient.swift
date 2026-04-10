//
//  HTTPClient.swift
//  SBCore
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Defines the contract for executing HTTP requests.
public protocol HTTPClient: Sendable {
    // MARK: - Methods
    func send<Response: Decodable>(
        _ request: URLRequestProtocol,
        responseType: Response.Type
    ) async throws -> Response
}

//
//  URLRequestProtocol.swift
//  SBCore
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Defines the `HTTPMethod` enumeration to represent all methods available
public enum HTTPMethod: String {
    case GET
    case PUT
    case POST
    case DELETE
}

/// Defines the requirements to build a `URLRequest`.
public protocol URLRequestProtocol: Sendable {
    // MARK: - Properties
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }

    // MARK: - Methods
    func makeURLRequest() throws -> URLRequest
}

public extension URLRequestProtocol {
    var method: HTTPMethod {
        return .GET
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var headers: [String: String]? {
        return nil
    }

    func makeURLRequest() throws -> URLRequest {
        guard var components = URLComponents(
            string: NetworkConstants.baseURLString
        ) else {
            throw NetworkError.invalidURL
        }

        components.path = self.path

        if let queryItems, !queryItems.isEmpty {
            components.queryItems = queryItems
        } else {
            components.queryItems = nil
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }
}

//
//  URLSessionHTTPClient.swift
//  SBCore
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Default `HTTPClient` implementation backed by `URLSession`.
public struct URLSessionHTTPClient: HTTPClient {
    // MARK: - Properties
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    // MARK: - Initializer
    public init(
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    public func send<Response: Decodable>(
        _ request: URLRequestProtocol,
        responseType: Response.Type
    ) async throws -> Response {
        let urlRequest = try request.makeURLRequest()

        do {
            let (data, response) = try await self.urlSession.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
            }

            do {
                return try self.decoder.decode(Response.self, from: data)
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.transportError(description: error.localizedDescription)
        }
    }
}

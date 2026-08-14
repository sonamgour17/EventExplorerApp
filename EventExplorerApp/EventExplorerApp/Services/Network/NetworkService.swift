//
//  NetworkService.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation

// Defines network operations.
protocol NetworkServiceProtocol: Sendable {
    func fetch<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        guard let url = endpoint.url else { throw APIError.invalidURL }

        do {
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknown
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(statusCode: httpResponse.statusCode)
            }

            return try JSONDecoder().decode(T.self, from: data)

        } catch let error as APIError {
            throw error
        } catch is DecodingError {
            throw APIError.decodingFailed
        } catch {
            throw APIError.noInternet
        }
    }
}

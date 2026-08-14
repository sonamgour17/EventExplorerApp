//
//  APIError.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation

// Defines API errors.
enum APIError: Error, LocalizedError, Equatable, Sendable {
    case invalidURL
    case noInternet
    case decodingFailed
    case serverError(statusCode: Int)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return AppConstants.Message.invalidURL

        case .noInternet:
            return AppConstants.Message.noInternet

        case .decodingFailed:
            return AppConstants.Message.decodingFailed

        case .serverError(let statusCode):
            return AppConstants.Message.serverError(
                statusCode: statusCode
            )

        case .unknown:
            return AppConstants.Message.unknownError
        }
    }
}

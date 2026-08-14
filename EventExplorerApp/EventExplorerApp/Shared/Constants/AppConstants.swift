//
//  AppConstants.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import CoreGraphics

enum AppConstants {

    enum Title {
        static let events = "Events"
        static let bookmarks = "Bookmarks"
    }

    enum Image {
        static let events = "calendar"
        static let bookmarks = "bookmark.fill"
        static let emptyBookmark = "bookmark.slash"
        static let photo = "photo"
        static let networkError = "wifi.exclamationmark"
    }
    
    enum Message {
        static let loadingEvents = "Loading events..."
        static let somethingWentWrong = "Something went wrong."
        static let invalidURL = "Invalid request URL."
        static let noInternet = "No internet connection. Please try again."
        static let decodingFailed = "Failed to parse server response."
        static let unknownError = "Something went wrong. Please try again."

        static func serverError(statusCode: Int) -> String {
            "Server error (\(statusCode)). Please try again later."
        }
    }

    enum Button {
        static let retry = "Retry"
    }

    enum API {
        static let baseURL =
            "https://6a7e37d0f8b2ed99ca4f25b9.mockapi.io/api/v1"

        static let eventsPath = "/events"
    }

    enum Layout {
        static let standardSpacing: CGFloat = 12
        static let smallSpacing: CGFloat = 4
        static let imageSize: CGFloat = 70
        static let cornerRadius: CGFloat = 8
        static let verticalPadding: CGFloat = 4
    }
}

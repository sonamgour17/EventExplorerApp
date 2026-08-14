//
//  EnvironmentValues+ImageCache.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import SwiftUI

private struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCacheServiceProtocol = ImageCacheService()
}

extension EnvironmentValues {
    var imageCache: ImageCacheServiceProtocol {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

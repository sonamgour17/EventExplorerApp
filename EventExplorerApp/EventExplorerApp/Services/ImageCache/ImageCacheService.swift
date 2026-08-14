//
//  ImageCacheService.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import UIKit

protocol ImageCacheServiceProtocol: Sendable {
    func loadImage(from url: URL) async -> UIImage?
}

actor ImageCacheService: ImageCacheServiceProtocol {
    private var cache: [URL: UIImage] = [:]
    private var accessOrder: [URL] = []
    private let maxItems: Int
    private let session: URLSession

    init(maxItems: Int = 50, session: URLSession = .shared) {
        self.maxItems = maxItems
        self.session = session
    }

    func loadImage(from url: URL) async -> UIImage? {
        if let cached = cache[url] {
            return cached
        }

        do {
            let (data, _) = try await session.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            store(image, for: url)
            return image
        } catch {
            return nil
        }
    }

    private func store(_ image: UIImage, for url: URL) {
        if cache[url] == nil {
            accessOrder.append(url)
        }
        cache[url] = image

        if accessOrder.count > maxItems {
            let oldest = accessOrder.removeFirst()
            cache.removeValue(forKey: oldest)
        }
    }
}

//
//  AppContainer+Mock.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import SwiftUI

actor MockImageCacheService: ImageCacheServiceProtocol {
    func loadImage(from url: URL) async -> UIImage? { nil }
}

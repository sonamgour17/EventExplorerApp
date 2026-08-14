//
//  CachedAsyncImage.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?

    @Environment(\.imageCache) private var imageCache

    @State private var uiImage: UIImage?
    @State private var isLoading = false

    var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if isLoading {
                Color.gray.opacity(0.1)
                    .overlay(ProgressView())
            } else {
                Color.gray.opacity(0.2)
                    .overlay(Image(systemName: "photo").foregroundColor(.gray))
            }
        }
        .task(id: url) {
            guard let url else { return }
            isLoading = true
            uiImage = await imageCache.loadImage(from: url)
            isLoading = false
        }
    }
}

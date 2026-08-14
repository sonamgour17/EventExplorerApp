//
//  EventRowView.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import SwiftUI

struct EventRowView: View {
    let event: Event

    var body: some View {
        
        HStack(spacing: AppConstants.Layout.standardSpacing) {
            
            AsyncImage(url: URL(string: event.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.2)
                    .overlay {
                        Image(systemName: AppConstants.Image.photo)
                            .foregroundColor(.gray)
                    }
            }
            .frame(
                width: AppConstants.Layout.imageSize,
                height: AppConstants.Layout.imageSize
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: AppConstants.Layout.cornerRadius
                )
            )

            VStack(
                alignment: .leading,
                spacing: AppConstants.Layout.smallSpacing
            ) {
                Text(event.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(event.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(
            .vertical,
            AppConstants.Layout.verticalPadding
        )
    }
}



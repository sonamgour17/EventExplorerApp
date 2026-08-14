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
            
            CachedAsyncImage(url: URL(string: event.imageUrl))
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
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



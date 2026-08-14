//
//  AppRouter.swift
//  EventExplorerApp
//
//  Created by Sonam Gour on 14/08/26.
//

import Foundation
import Combine

// Manages the selected tab.
@MainActor
final class AppRouter: ObservableObject {
    @Published var selectedTab: AppTab = .events
}

//
//  NavigationPatternApp.swift
//  NavigationPattern
//
//  Created by David Diego Gomez on 04/08/2023.
//

import SwiftUI

@main
struct NavigationPatternApp: App {
    @StateObject var coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorMainView()
                .environmentObject(coordinator)
        }
    }
}

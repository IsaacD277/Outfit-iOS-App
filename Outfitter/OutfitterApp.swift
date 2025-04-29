//
//  OutfitterApp.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/10/25.
//
import SwiftData
import SwiftUI

@main
struct OutfitterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Outfit.self, Tag.self])
        }
    }
}

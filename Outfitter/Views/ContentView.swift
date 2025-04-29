//
//  ContentView.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/10/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab = 0
    
    // Custom initializer with default tab selected
    init(tab: Int = 0) {
        _selectedTab = State(initialValue: tab)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Outfits", systemImage: "tshirt.fill", value: 0) {
                AllOutfitsView()
            }
            
            Tab("Add", systemImage: "plus", value: 1) {
                NewSelectImageView()
            }
            
            Tab("Settings", systemImage: "gear", value: 2) {
                // Add settings somehow
                
                //MARK: TEMPORARY
                // AddOutfitView(image: UIImage(imageLiteralResourceName: "image2"))
//                EditOutfitView(Outfit(image: UIImage(imageLiteralResourceName: "image2"), tags: [Tag("Test"), Tag("Work"), Tag("Play"), Tag("Suit"), Tag("Testing"), Tag("What"), Tag("Is"), Tag("Happening")]))
            }
        }
    }
}

#Preview("Home") {
    ContentView()
}

#Preview("Dummy Data") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Outfit.self, configurations: config)
        let example = Outfit(image: UIImage(imageLiteralResourceName: "image2"), tags: [Tag("Work"), Tag("Formal")], favorite: false)
        return EditOutfitView(outfit: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}

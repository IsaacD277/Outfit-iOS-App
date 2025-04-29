//
//  AllOutfitsView.swift
//  Outfitter
//
//  Created by Isaac D2 on 4/22/25.
//

import SwiftUI

struct AllOutfitsView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Outfit]()
    @State private var sortOrder = SortDescriptor(\Outfit.dateAdded)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            OutfitListingView(sort: sortOrder, searchString: searchText)
                .padding()
                .navigationTitle("All Outfits")
                .searchable(text: $searchText)
                .navigationDestination(for: Outfit.self, destination: EditOutfitView.init)
        }
    }
}

#Preview {
    AllOutfitsView()
}

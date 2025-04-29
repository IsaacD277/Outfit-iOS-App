//
//  OutfitListingView.swift
//  Outfitter
//
//  Created by Isaac D2 on 4/22/25.
//

import SwiftData
import SwiftUI

struct OutfitListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query var outfits: [Outfit]
    
    var body: some View {
        ScrollView {
            ForEach(outfits) { outfit in
                NavigationLink(value: outfit) {
                    OutfitCard(outfit)
                }
            }
        }
    }
    
    init(sort: SortDescriptor<Outfit>, searchString: String) {
        if searchString.isEmpty {
            _outfits = Query(filter: #Predicate { _ in true })
        } else {
            _outfits = Query(filter: #Predicate { $0.tags.contains(where: { $0.name == searchString }) })
        }
    }
    
    func deleteOutfits(_ indexset: IndexSet) {
        for index in indexset {
            let outfit = outfits[index]
            modelContext.delete(outfit)
        }
    }
}

#Preview {
    OutfitListingView(sort: SortDescriptor(\Outfit.dateAdded), searchString: "")
}

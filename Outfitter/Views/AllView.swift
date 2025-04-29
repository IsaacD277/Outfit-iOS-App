//
//  AllView.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/20/25.
//

import SwiftData
import SwiftUI

struct AllView: View {
    @Environment(\.modelContext) var modelContext
    @Query var outfits: [Outfit]
    @State private var fill: Bool = false
    @State private var path = [Outfit]()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical) {
                LazyVStack(spacing: 20) {
                    ForEach(outfits) { outfit in
                        NavigationLink(value: outfit) {
                            OutfitCard(outfit, fill: fill)
                        }
                    }
                    // .onDelete(perform: deleteOutfit)
                }
                .padding()
                .navigationDestination(for: Outfit.self) {
                    EditOutfitView(outfit: $0)
                }
                
                Button(fill ? "Fit" : "Fill") {
                    fill.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
            // .navigationDestination(for: Outfit.Type, destination: EditOutfitView)
        }
    }
    
    func deleteOutfit(_ indexset: IndexSet) {
        for index in indexset {
            let outfit = outfits[index]
            modelContext.delete(outfit)
        }
    }
}

//#Preview {
//    let preview = PreviewContainer([Outfit.self])
//    
//    let example1 = Outfit.dummy
//    let example2 = Outfit.dummy
//    let example3 = Outfit.dummy
//    let example4 = Outfit.dummy
//    let example5 = Outfit.dummy
//    let example6 = Outfit.dummy
//    let example7 = Outfit.dummy
//    
//    preview.add(items: [example1, example2, example3, example4, example5, example6, example7])
//    
//    return AllView().modelContainer(preview.container)
//}

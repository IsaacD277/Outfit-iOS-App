//
//  AllOutfitsView.swift
//  Outfitter
//
//  Created by Isaac D2 on 4/22/25.
//

import SwiftUI
import PhotosUI

struct AllOutfitsView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhoto: UIImage?
    
    @State private var path = [Outfit]()
    @State private var sortOrder = SortDescriptor(\Outfit.dateAdded)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            OutfitListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("All Outfits")
                .navigationDestination(for: Outfit.self) { outfit in
                    EditOutfitView(outfit: outfit)
                }
                .toolbar {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        VStack(alignment: .leading, spacing: 0) {
                            Image(systemName: "plus")
                        }
                    }
                    .onChange(of: selectedItem) {
                        Task {
                            await loadImageAndNavigate(from: selectedItem)
                        }
                    }
                }
        }
    }
    
    private func loadImageAndNavigate(from item: PhotosPickerItem?) async {
        guard let item else { return }
        
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                selectedPhoto = uiImage
                let newOutfit = Outfit(image: selectedPhoto ?? UIImage())
                modelContext.insert(newOutfit)
                path.append(newOutfit)
            }
        } catch {
            print("Unable to load image. Error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AllOutfitsView()
}

//
//  NewSelectImageView.swift
//  Outfitter
//
//  Created by Isaac D2 on 4/24/25.
//

import PhotosUI
import SwiftData
import SwiftUI

struct NewSelectImageView: View {
    @Environment(\.modelContext) var modelContext
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var path: [Outfit] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                VStack(alignment: .leading, spacing: 0) {
                    GeometryReader { geometry in
                        Image("plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: geometry.size.width)
                    }
                    .aspectRatio(1.0, contentMode: .fit) // Maintain square aspect ratio
                }
                .navigationDestination(for: Outfit.self) { outfit in
                    EditOutfitView(outfit: outfit)
                }
            }
        }
    }
}

#Preview {
    NewSelectImageView()
}

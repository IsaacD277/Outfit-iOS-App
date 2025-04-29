//
//  SelectImageView.swift
//  Outfitter
//
//  Created by Isaac D2 on 4/24/25.
//

import PhotosUI
import SwiftData
import SwiftUI

struct SelectImageView: View {
    @Environment(\.modelContext) var modelContext
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geometry in
                    Image("image2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.width)
                }
                .aspectRatio(1.0, contentMode: .fit) // Maintain square aspect ratio
            }
        }
    }
}

#Preview {
    SelectImageView()
}

//
//  SelectImageView.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/10/25.
//

import PhotosUI
import SwiftUI

struct SelectImageView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var path = [UIImage]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("Select an outfit photo")
                
                PhotosPicker(
                    selection: $selectedPhoto,
                    matching: .images,
                    preferredItemEncoding: .current,
                    photoLibrary: .shared()
                ) {
                    Label("Select Photo", systemImage: "photo.on.rectangle")
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.gradient)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 12))
                }
                .photosPickerStyle(.inline)
                .photosPickerAccessoryVisibility(.visible)
                .onChange(of: selectedPhoto) { _, newPhoto in
                    Task {
                        await loadImage(from: newPhoto)
                    }
                }
            }
            .padding()
            .navigationTitle("Import Outfits")
            .navigationDestination(for: UIImage.self) { image in
                // AddOutfitView(image: image)
            }
        }
        .onChange(of: path) { oldValue, newValue in
            if newValue.isEmpty {
                selectedPhoto = nil
                selectedImage = nil
            }
        }
    }
    
    private func loadImage(from item: PhotosPickerItem?) async {
        guard let item else { return }
        
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                selectedImage = uiImage
                path.append(uiImage)
            }
        } catch {
            print("Unable to load image. Error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    SelectImageView()
}

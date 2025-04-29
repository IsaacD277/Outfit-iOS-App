//
//  OutfitCard.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/20/25.
//

import SwiftData
import SwiftUI

struct OutfitCard: View {
    let outfit: Outfit
    var photoFill: Bool
    
    init(_ outfit: Outfit, fill: Bool = true) {
        self.outfit = outfit
        self.photoFill = fill
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geometry in
                Group {
                    if let imageData = outfit.imageData, let image = UIImage(data: imageData) {
                        if photoFill {
                            ZStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width, height: geometry.size.width)
                                    .opacity(photoFill ? 0 : 1)
                                
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.width)
                                    .clipped()
                                    .opacity(photoFill ? 1 : 0)
                            }
                        } else {
                            ZStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.width)
                                    .blur(radius: 20)
                                    .clipped()
                                
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width, height: geometry.size.width)
                                    .clipped()
                            }
                        }
                    }
                }
            }
            .aspectRatio(1.0, contentMode: .fit) // Maintain square aspect ratio
            
            HStack {
                Text("Uploaded on \(formattedDate(outfit.id))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Image(systemName: outfit.favorite ? "heart.fill" : "heart")
                    .imageScale(.large)
                    .bold()
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        outfit.favorite.toggle()
                    }
                    .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
                
                Menu {
                    Button(action: {
                        // Delete the outfit
                    }) {
                        Label("Delete", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                        .bold()
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 12)) // Rounded corners for image
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
    
    private func formattedDate(_ id: UUID) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
}

#Preview {
    OutfitCard(Outfit(image: UIImage(imageLiteralResourceName: "image2"), tags: [Tag("Test"), Tag("Work")]))
        .padding()
}

//
//  EditOutfitView.swift
//  Outfitter
//
//  Created by Isaac D2 on 4/19/25.
//

import SwiftData
import SwiftUI

struct EditOutfitView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tags: [Tag]
    
    @Bindable var outfit: Outfit
    @State private var draftTag: String = ""
    
    @FocusState private var tagBarFocus
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    ZStack {
                        // Blurred Background Image
                        Image(uiImage: outfit.image ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .blur(radius: 25)
                            .clipped()
                        
                        // Actual Image
                        Image(uiImage: outfit.image ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .clipped()
                    }
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(radius: 4)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(outfit.tags) { tag in
                        TagView(tag)
                            .onTapGesture {
                                deleteTag(tag)
                            }
                    }
                }
                .padding(.trailing, 16)
            }
            .padding(.vertical, 8)
            .mask(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .black, location: 0.0),
                        .init(color: .black, location: 0.95),
                        .init(color: .clear, location: 1.0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            
            HStack {
                VStack {
                    HStack {
                        // Tag Bar
                        HStack {
                            TextField("Outfit Tags", text: $draftTag)
                                .focused($tagBarFocus)
                            
                            Button {
                                addTag()
                            } label: {
                                Image(systemName: "tag.fill")
                            }
                            .disabled(draftTag.isEmpty)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                                .foregroundStyle(Color(red: 0.9, green: 0.9, blue: 0.9))
                        )
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Edit Outfit")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(tagBarFocus ? "Done" : "Edit") {
                tagBarFocus = tagBarFocus ? false : true
            }
        }
    }
    
    func addTag() {
        // Step 1: Normalize input
        let trimmedName = draftTag.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        
        // Step 2: Check for existing tag
        if let existingTag = tags.first(where: { $0.normalizedName == trimmedName }) {
            // Step 3: If it exists, add the existing tag
            if outfit.tags.contains(existingTag) == false {
                outfit.tags.append(existingTag)
            }
        } else {
            // Step 4: If it doesn't exist, create a new tag
            let newTag = Tag(trimmedName)
            modelContext.insert(newTag) // <- important, make sure SwiftData knows about it
            outfit.tags.append(newTag)
        }
        
        // Step 5: Clear the text field
        draftTag = ""
    }
        
    func deleteTag(_ tag: Tag) {
        if let index = outfit.tags.firstIndex(of: tag) {
            outfit.tags.remove(at: index)
        }
    }
}


#Preview {
    EditOutfitView(outfit: Outfit(image: UIImage(imageLiteralResourceName: "image2"), tags: [Tag("Test"), Tag("Work"), Tag("Play"), Tag("Suit"), Tag("Testing"), Tag("What"), Tag("Is"), Tag("Happening")]))
}

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
    @State private var editing: Bool = false
    
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
                    .transaction { transaction in
                        transaction.animation = nil // Prevents image from being animated
                    }
                    
                    Button(editing ? "Done" : "Edit") {
                        tagBarFocus = tagBarFocus ? false : true
                        editing = !editing
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(outfit.tags) { tag in
                        TagView(tag, editing ? "xmark.circle" : tag.symbol)
                            .contentTransition(.symbolEffect(.replace))
                            .onTapGesture {
                                if editing {
                                    deleteTag(tag)
                                }
                            }
                            .transition(.scale)
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
                                    .foregroundStyle(draftTag.isEmpty ? .gray : Color.d2Orange)
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
            Button(editing ? "Done" : "Edit") {
                tagBarFocus = tagBarFocus ? false : true
                editing = !editing
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
                outfit.tags.insert(existingTag, at: 0)
            }
        } else {
            // Step 4: If it doesn't exist, create a new tag
            let newTag = Tag(trimmedName)
            modelContext.insert(newTag) // <- important, make sure SwiftData knows about it
            outfit.tags.insert(newTag, at: 0)
        }
        
        // Step 5: Clear the text field
        draftTag = ""
    }
    
    func deleteTag(_ tag: Tag) {
        withAnimation {
            if let index = outfit.tags.firstIndex(of: tag) {
                outfit.tags.remove(at: index)
            }
        }
    }
}


#Preview {
    EditOutfitView(outfit: Outfit(image: UIImage(imageLiteralResourceName: "image2"), tags: [Tag("Test"), Tag("Work"), Tag("Play"), Tag("Suit"), Tag("Testing"), Tag("What"), Tag("Is"), Tag("Happening")]))
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

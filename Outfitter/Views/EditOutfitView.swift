//
//  EditOutfitView.swift
//  Outfitter
//
//  Created by Isaac D2 on 4/19/25.
//

import SwiftData
import SwiftUI

struct EditOutfitView: View {
    @Bindable var outfit: Outfit
    @State private var draftTag: String = ""
    
    var body: some View {
        NavigationStack {
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
                
                FilterBar(filter: outfit.tags)
                
                HStack {
                    TagBar(shuffle: false, filter: $outfit.tags)
                    
                    Button("Add") {
                        addTag()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .padding()
            .navigationTitle("Add Tags")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    addTag()
                    #warning("Undo focus from the text field")
                    #warning("Change \"Done\" to \"Edit\"")
                }
            }
        }
    }
    
    // Maybe rename this function to be more descriptive
    func addTag() {
        guard draftTag.isEmpty == false else { return }
        
        withAnimation {
            let tag = Tag(draftTag)
            outfit.tags.insert(tag, at: 0)
            draftTag = ""
        }
    }
}


//#Preview {
//    EditOutfitView(Outfit(image: UIImage(imageLiteralResourceName: "image2"), tags: [Tag("Test"), Tag("Work"), Tag("Play"), Tag("Suit"), Tag("Testing"), Tag("What"), Tag("Is"), Tag("Happening")]))
//}


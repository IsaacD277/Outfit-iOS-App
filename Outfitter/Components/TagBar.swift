////
////  TagBar.swift
////  Outfitter
////
////  Created by Isaac D2 on 3/10/25.
////
//
//import SwiftData
//import SwiftUI
//
//struct TagBar: View {
//    @Environment(\.modelContext) var modelContext
//    @Query var tags: [Tag]
//    @Query var outfits: [Outfit]
//    @State private var tag: String = ""
//    @State private var filter: [Tag] = []
//    @State private var validOutfits: [Outfit] = []
//    
//    let shuffle: Bool
//    
//    init(shuffle: Bool = true, filter: Binding<[Tag]>) {
//        self.shuffle = shuffle
//    }
//    
//    var body: some View {
//        VStack {
//            FilterBar(filter: filter)
//            HStack {
//                // Tag Bar
//                HStack {
//                    TextField("Outfit Tags", text: $tag)
//                        .focused($tagBarFocus)
//                    
//                    Button {
//                        addTag(named: tag)
//                    } label: {
//                        Image(systemName: "tag.fill")
//                    }
//                    .disabled(tag.isEmpty)
//                }
//                .padding()
//                .background(
//                    RoundedRectangle(cornerRadius: 12.0)
//                        .foregroundStyle(Color(red: 0.9, green: 0.9, blue: 0.9))
//                )
//                
//                // Shuffle Button
//                if shuffle {
//                    Button {
//                        validOutfits.shuffle()
//                    } label: {
//                        Image(systemName: "shuffle")
//                            .bold()
//                            .background(
//                                Circle()
//                                    .fill(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.2))
//                                    .frame(width: 50, height: 50)
//                            )
//                            .padding(.horizontal)
//                    }
//                }
//            }
//        }
//    }
//    
//    func addTag(named name: String) {
//        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
//        guard !trimmedName.isEmpty else { return }
//        
//        if let existingTag = tags.first(where: { $0.normalizedName == trimmedName }) {
//            filter.insert(existingTag, at: 0)
//        } else {
//            let newTag = Tag(name)
//            modelContext.insert(newTag)
//            filter.insert(newTag, at: 0)
//        }
//        tag = ""
//    }
//}
//
////#Preview("With Shuffle") {
////    TagBar(filter: .constant([Tag("Work"), Tag("Plaid"), Tag("Blue"), Tag("Winter")])) // Cannot convert value of type '[Tag]' to expected argument type 'Binding<[Tag]>'
////}
////
////#Preview("Without Shuffle") {
////    TagBar(shuffle: false, filter: .constant([]))
////}

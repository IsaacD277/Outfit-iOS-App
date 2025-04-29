////
////  OutfitDetail.swift
////  Outfitter
////
////  Created by Isaac D2 on 4/13/25.
////
//
//import SwiftData
//import SwiftUI
//
//struct OutfitDetail: View {
//    let outfit: Outfit
//    
//    init(_ outfit: Outfit) {
//        self.outfit = outfit
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            GeometryReader { geometry in
//                VStack {
//                    Group {
//                        if let imageData = outfit.imageData, let image = UIImage(data: imageData) {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: geometry.size.width, height: geometry.size.width)
//                        }
//                    }
//                    
//                    FlowLayout(items: outfit.tags) { tag in
//                        TagView(tag.name)
//                    }
//                }
//            }
//            
//            HStack {
//                Text("Uploaded on \(formattedDate(outfit.id))")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                
//                Spacer()
//                
//                Image(systemName: outfit.favorite ? "heart.fill" : "heart")
//                    .imageScale(.large)
//                    .bold()
//                    .foregroundColor(.secondary)
//                    .onTapGesture {
//                        outfit.favorite.toggle()
//                    }
//                    .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
//                
//                Menu {
//                    Button(action: {
//                        // Delete the outfit
//                    }) {
//                        Label("Delete", systemImage: "trash")
//                            .foregroundColor(.red)
//                    }
//                } label: {
//                    Image(systemName: "ellipsis.circle")
//                        .imageScale(.large)
//                        .bold()
//                        .foregroundColor(.secondary)
//                }
//            }
//            .padding()
//        }
//        .background(Color.white)
//    }
//    
//    private func formattedDate(_ id: UUID) -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: Date())
//    }
//}
//
////#Preview {
////    OutfitDetail(Outfit(image: UIImage(imageLiteralResourceName: "image2"), tags: [Tag("Test"), Tag("Work"), Tag("Play"), Tag("Suit"), Tag("Testing"), Tag("What"), Tag("Is"), Tag("Happening")]))
////        .padding()
////}
//
//
//struct FlowLayout<Content: View>: View {
//    let items: [Tag]
//    let spacing: CGFloat
//    let content: (Tag) -> Content
//    
//    init(items: [Tag], spacing: CGFloat = 6, @ViewBuilder content: @escaping (Tag) -> Content) {
//        self.items = items
//        self.spacing = spacing
//        self.content = content
//    }
//    
//    var body: some View {
//        GeometryReader { geometry in
//            self.generateContent(in: geometry)
//        }
//    }
//    
//    private func generateContent(in geometry: GeometryProxy) -> some View {
//        var width: CGFloat = 0
//        var height: CGFloat = 0
//        
//        return ZStack(alignment: .topLeading) {
//            ForEach(items, id: \.self) { tag in
//                content(tag)
//                    .padding(.horizontal, 4)
//                    .padding(.vertical, 2)
//                    .alignmentGuide(.leading) { d in
//                        if abs(width - d.width) > geometry.size.width {
//                            width = 0
//                            height -= d.height + spacing
//                        }
//                        let result = width
//                        if tag == items.last {
//                            width = 0 // reset for next render
//                        } else {
//                            width -= d.width + spacing
//                        }
//                        return result
//                    }
//                    .alignmentGuide(.top) { _ in height }
//            }
//        }
//    }
//}

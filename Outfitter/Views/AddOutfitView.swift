////
////  AddOutfitView.swift
////  Outfitter
////
////  Created by Isaac D2 on 3/10/25.
////
//
//import SwiftUI
//
//struct AddOutfitView: View {
//    let image: UIImage
//    @Environment(\.dismiss) private var dismiss
//    @Environment(\.modelContext) private var modelContext
//    
//    @State private var filter: [Tag]
//    @State private var draftTag: String = ""
//    
//    init(image: UIImage, filter: [Tag] = []) {
//        self.image = image
//        self.filter = filter
//    }
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                GeometryReader { geometry in
//                    VStack(spacing: 20) {
//                        ZStack {
//                            // Blurred Background
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: geometry.size.width, height: geometry.size.width)
//                                .blur(radius: 25)
//                                .clipped()
//                            
//                            // Actual Image
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: geometry.size.width, height: geometry.size.width)
//                                .clipped()
//                        }
//                        .clipShape(.rect(cornerRadius: 12))
//                        .shadow(radius: 4)
//                    }
//                }
//                
//                TagBar(shuffle: false, filter: $filter, using: modelContext)
//            }
//            .padding()
//            .navigationTitle("Add Tags")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                Button("Done") {
//                    submit()
//                }
//            }
//            .onAppear {
//                print("AddOutfitView appeared")
//            }
//            .onDisappear {
//                print("AddOutfitView disappeared")
//            }
//        }
//    }
//    
//    func submit() {
//        if !draftTag.trimmingCharacters(in: .whitespaces).isEmpty {
//            
//        }
//        
//        let outfit = Outfit(image: image, tags: filter)
//        
//        do {
//            modelContext.insert(outfit)
//            try modelContext.save()
//        } catch {
//            print("Unable to save outfit. Error: \(error.localizedDescription)")
//        }
//        
//        dismiss()
//    }
//}
//
//
//#Preview {
//    AddOutfitView(image: UIImage(imageLiteralResourceName: "image2"))
//}

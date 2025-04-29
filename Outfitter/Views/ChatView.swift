//
//  ChatView.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/12/25.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var outfit: Outfit
    
    @State private var tagName: String = ""
    @State private var suggestedTags: [Tag] = []
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add a tag...", text: $tagName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: tagName) {
                        fetchSuggestions()
                    }
                
                Button("Add") {
                    addTag()
                }
                .disabled(tagName.isEmpty)
            }
            
            if !suggestedTags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(suggestedTags, id: \.name) { tag in
                            Text(tag.name)
                                .padding(8)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                                .onTapGesture {
                                    selectTag(tag)
                                }
                        }
                    }
                }
            }
            
            // Display the tags for the outfit
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(outfit.tags, id: \.name) { tag in
                        HStack {
                            Text(tag.name)
                            Image(systemName: "xmark.circle.fill")
                                .onTapGesture {
                                    removeTag(tag)
                                }
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
    }
    
    // Fetch suggestions based on input text
    private func fetchSuggestions() {
        // Fetch
    }
    
    // Select an existing tag
    private func selectTag(_ tag: Tag) {
        if !outfit.tags.contains(where: { $0.name == tag.name }) {
            outfit.tags.append(tag)
        }
        tagName = ""
        suggestedTags = []
        try? modelContext.save()
    }
    
    // Add a new tag or use an existing one
    private func addTag() {
        let tag = fetchOrCreateTag(named: tagName)
        if !outfit.tags.contains(where: { $0.name == tag.name }) {
            outfit.tags.append(tag)
        }
        tagName = ""
        suggestedTags = []
        try? modelContext.save()
    }
    
    // Remove a tag from the outfit
    private func removeTag(_ tag: Tag) {
        outfit.tags.removeAll { $0.name == tag.name }
        try? modelContext.save()
    }
    
    // Fetch or create a tag in SwiftData
    private func fetchOrCreateTag(named name: String) -> Tag {
        let fetchDescriptor = FetchDescriptor<Tag>(predicate: #Predicate { $0.name == name })
        
        if let existingTag = try? modelContext.fetch(fetchDescriptor).first {
            return existingTag
        }
        
        let newTag = Tag(name)
        modelContext.insert(newTag)
        return newTag
    }
}

#Preview {
    ChatView(outfit: Outfit(image: UIImage(), tags: [Tag("Work")]))
}

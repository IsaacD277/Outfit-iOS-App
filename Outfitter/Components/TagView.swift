//
//  TagView.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/10/25.
//

import SwiftUI

struct TagView: View {
    var tag: Tag
    
    init(_ tag: Tag) {
        self.tag = tag
    }
    
    var body: some View {
        HStack {
            Image(systemName: "tag")
                .foregroundStyle(.white)
                .padding(.vertical, 6)
                .padding(.leading, 8)
            Text(tag.name)
                .padding(.trailing, 8) // Add padding around the text
                .foregroundColor(.white) // Set the text color to white
        }
        .background(
            RoundedRectangle(cornerRadius: 12.0)
                .fill(Color.blue) // Create a blue capsule background
        )
    }
}

#Preview {
    TagView(Tag("Work"))
}


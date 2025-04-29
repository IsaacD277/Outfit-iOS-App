//
//  TagView.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/10/25.
//

import SwiftUI

struct TagView: View {
    var content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        HStack {
            Image(systemName: "tag")
                .foregroundStyle(.white)
                .padding(.vertical, 6)
                .padding(.leading, 8)
            Text(content)
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
    TagView("Work")
}


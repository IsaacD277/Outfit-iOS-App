//
//  TagView.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/10/25.
//

import SwiftUI

struct TagView: View {
    var tag: Tag
    var symbol: String
    
    init(_ tag: Tag, _ symbol: String? = nil) {
        self.tag = tag
        self.symbol = symbol ?? tag.symbol ?? "tag.circle"
    }
    
    var body: some View {
        Label {
            Text(tag.name)
                .font(.headline)
                .foregroundStyle(.white)
        } icon: {
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20) // Set consistent size
                .foregroundStyle(.white)
        }
        .symbolRenderingMode(.hierarchical)
        .padding(10)
        .background(Color.d2Orange, in: Capsule())
    }
}

#Preview {
    TagView(Tag("Work"), "folder")
}

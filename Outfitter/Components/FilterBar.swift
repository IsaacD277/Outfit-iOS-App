//
//  FilterBar.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/23/25.
//

import SwiftUI

struct FilterBar: View {
    
    var filter: [Tag]
    
    init(filter: [Tag]) {
        self.filter = filter
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(filter) { tag in
                    TagView(tag.name)
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
    }
}

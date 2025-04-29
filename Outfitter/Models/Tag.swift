//
//  Tag.swift
//  Outfitter
//
//  Created by Isaac D2 on 2/20/25.
//

import SwiftData
import SwiftUI

@Model
class Tag: Identifiable, Hashable {
    @Attribute(.unique) var name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    var normalizedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(normalizedName)
    }
    
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        lhs.normalizedName == rhs.normalizedName
    }
}

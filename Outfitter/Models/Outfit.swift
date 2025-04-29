//
//  Outfit.swift
//  Outfitter
//
//  Created by Isaac D2 on 2/16/25.
//

import SwiftData
import SwiftUI

@Model
class Outfit: Identifiable, Hashable {
    var id = UUID()
    @Attribute(.externalStorage) var imageData: Data?
    var tags: [Tag]
    var dateAdded: Date
    @Relationship(deleteRule: .cascade) var datesWorn: [WornDate] = []
    var favorite: Bool
    
    init(image: UIImage = UIImage(), tags: [Tag] = [], favorite: Bool = false) {
        self.imageData = image.jpegData(compressionQuality: 1.0)
        self.tags = tags
        self.dateAdded = Date.now
        self.favorite = favorite
    }
    
    var image: UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
}

extension Outfit {
    func containsTags(_ searchTags: [Tag]) -> Bool {
        let searchTagNames = Set(searchTags.map { $0.name })
        let outfitTagNames = Set(tags.map { $0.name })
        return searchTagNames.isSubset(of: outfitTagNames)
    }
}


extension Outfit {
    static var dummy: Outfit {
        .init(image: UIImage(imageLiteralResourceName: "image2"), tags: [Tag("Test"), Tag("Work")])
    }
}

extension Outfit {
    static func == (lhs: Outfit, rhs: Outfit) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

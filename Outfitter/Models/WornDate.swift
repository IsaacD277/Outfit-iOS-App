//
//  WornDate.swift
//  Outfitter
//
//  Created by Isaac D2 on 3/9/25.
//

import SwiftData
import SwiftUI

@Model
class WornDate {
    var date: Date
    var outfit: Outfit?
    
    init(date: Date) {
        self.date = date
    }
}

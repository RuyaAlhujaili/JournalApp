//
//  JournalEntry.swift
//  JournalApp
//
//  Created by Ruya Alhujaili on 02/06/1448 AH.
//

import Foundation
import SwiftData

@Model
class JournalEntry {

    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool

    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.date = Date()
        self.isBookmarked = false
    }
}

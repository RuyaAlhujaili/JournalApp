//
//  JournalViewModel.swift
//  JournalApp
//
//  Created by Ruya Alhujaili on 02/06/1448 AH.
//


import Foundation
import Observation

@Observable
class JournalViewModel {

    var entries: [JournalEntry] = []

    func addEntry(title: String, content: String) {
        let newEntry = JournalEntry(
            title: title,
            content: content
        )

        entries.append(newEntry)
    }

    func toggleBookmark(for entry: JournalEntry) {
        guard let index = entries.firstIndex(where: {
            $0.id == entry.id
        }) else {
            return
        }

        entries[index].isBookmarked.toggle()
    }
}

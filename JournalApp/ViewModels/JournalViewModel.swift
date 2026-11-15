import Foundation
import SwiftData
import Observation

@Observable
class JournalViewModel {

    func addEntry(title: String, content: String, context: ModelContext) {
        let newEntry = JournalEntry(title: title, content: content)
        context.insert(newEntry)
    }

    func toggleBookmark(for entry: JournalEntry) {
        entry.isBookmarked.toggle()
    }
    func deleteEntry(_ entry: JournalEntry, context: ModelContext) {
        context.delete(entry)
    }
    
}

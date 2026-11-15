import SwiftUI

struct EditJournalView: View {
    
    let entry: JournalEntry
    
    @State private var title: String
    @State private var content: String
    @State private var showDiscardAlert = false
    @Environment(\.dismiss) private var dismiss
    
    init(entry: JournalEntry) {
        self.entry = entry
        _title = State(initialValue: entry.title)
        _content = State(initialValue: entry.content)
    }
    
    private var hasChanges: Bool {
        title != entry.title || content != entry.content
    }
    
    var body: some View {
        
        Form {
            TextField("Title", text: $title)
            
            TextField(
                "Write your thoughts...",
                text: $content,
                axis: .vertical
            )
            .lineLimit(5...15)
        }
        .navigationTitle("Edit Journal")
        .navigationBarTitleDisplayMode(.inline)
        .interactiveDismissDisabled(hasChanges)
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    if hasChanges {
                        showDiscardAlert = true
                    } else {
                        dismiss()
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    entry.title = title
                    entry.content = content
                    dismiss()
                }
                .fontWeight(.semibold)
                .disabled(
                    title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
            }
        }
        .alert(
            "Are you sure you want to discard changes on this journal?",
            isPresented: $showDiscardAlert
        ) {
            Button("Keep Editing", role: .cancel) { }
            Button("Discard Changes", role: .destructive) {
                dismiss()
            }
        }
    }
}

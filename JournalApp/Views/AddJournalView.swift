//
//  AddJournalView.swift
//  JournalApp
//
//  Created by Ruya Alhujaili on 02/06/1448 AH.
//


import SwiftUI

struct AddJournalView: View {

    @State private var title = ""
    @State private var content = ""

    let onSave: (String, String) -> Void

    @Environment(\.dismiss) private var dismiss

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
        .navigationTitle("New Journal")
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {

            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {

                    onSave(title, content)
                    dismiss()

                }
                .fontWeight(.semibold)
                .disabled(
                    title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
            }

        }
    }
}

#Preview {
    NavigationStack {
        AddJournalView { title, content in
            print(title, content)
        }
    }
    .preferredColorScheme(.dark)
}

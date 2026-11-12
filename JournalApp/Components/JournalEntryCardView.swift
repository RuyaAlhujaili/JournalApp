//
//  JournalEntryCardView.swift
//  JournalApp
//
//  Created by Ruya Alhujaili on 02/06/1448 AH.
//

import SwiftUI

struct JournalEntryCardView: View {

    let entry: JournalEntry
    let onBookmarkTap: () -> Void

    private let purple = Color(
        red: 175/255,
        green: 153/255,
        blue: 253/255
    )

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .top) {

                VStack(alignment: .leading, spacing: 6) {

                    Text(entry.title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(purple)

                    Text(
                        entry.date,
                        format: .dateTime.day().month().year()
                    )
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                    onBookmarkTap()
                } label: {
                    Image(
                        systemName: entry.isBookmarked
                        ? "bookmark.fill"
                        : "bookmark"
                    )
                    .font(.system(size: 24))
                }
                .buttonStyle(.plain)
                .foregroundStyle(purple)
                .accessibilityLabel(
                    entry.isBookmarked
                    ? "Remove bookmark"
                    : "Add bookmark"
                )
            }

            Text(entry.content)
                .font(.system(size: 16))
                .lineLimit(5)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(uiColor: .secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}

#Preview {
    JournalEntryCardView(
        entry: JournalEntry(
            title: "My Birthday",
            content: "Today was a wonderful day!"
        ),
        onBookmarkTap: {}
    )
    .padding()
    .preferredColorScheme(.dark)
}

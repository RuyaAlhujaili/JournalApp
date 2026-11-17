import SwiftUI

struct JournalEditorView: View {

    @State private var title: String
    @State private var content: String
    @State private var showDiscardAlert = false
    @FocusState private var isTitleFocused: Bool

    private let entry: JournalEntry?
    private let date: Date
    let onSave: (String, String) -> Void

    @Environment(\.dismiss) private var dismiss

    private let purple = Color(
        red: 135/255,
        green: 123/255,
        blue: 255/255
    )

    private let background = Color(
        red: 28/255,
        green: 28/255,
        blue: 30/255
    )

    init(entry: JournalEntry? = nil, onSave: @escaping (String, String) -> Void) {
        self.entry = entry
        self.date = entry?.date ?? Date()
        self.onSave = onSave
        // Edit a local draft so cancelling never changes the saved entry.
        _title = State(initialValue: entry?.title ?? "")
        _content = State(initialValue: entry?.content ?? "")
    }

    private var hasChanges: Bool {
        guard let entry else { return false }
        return title != entry.title || content != entry.content
    }

    private var isEmpty: Bool {
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            HStack {
                Button {
                    if hasChanges {
                        showDiscardAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 21))
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.glass)
                .tint(.white)
                .accessibilityLabel("Cancel")

                Spacer()

                Button {
                    // Keep the native purple appearance while preventing empty entries.
                    guard !isEmpty else { return }
                    onSave(title, content)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundStyle(.black)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.glassProminent)
                .tint(purple)
                .accessibilityLabel("Save")
            }
            .buttonBorderShape(.circle)
            .controlSize(.large)
            .padding(.bottom, 4)

            TextField("Title", text: $title)
                .font(.system(size: 34, weight: .bold))
                .focused($isTitleFocused)

            Text(date, format: .dateTime.day().month(.twoDigits).year().locale(Locale(identifier: "en_GB")))
                .font(.system(size: 16))
                .foregroundStyle(.secondary)

            TextField(
                "Type your Journal...",
                text: $content,
                axis: .vertical
            )
            .font(.system(size: 20))
            .padding(.top, 16)

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(background.ignoresSafeArea())
        .tint(purple)
        .toolbar(.hidden, for: .navigationBar)
        .preferredColorScheme(.dark)
        .overlay(alignment: .top) {
            // Match the shorter handle in the design; the sheet still handles dragging.
            Capsule()
                .fill(Color.white.opacity(0.25))
                .frame(width: 36, height: 4)
                .padding(.top, 6)
                .allowsHitTesting(false)
                .accessibilityHidden(true)
        }
        .presentationDragIndicator(.hidden)
        .presentationCornerRadius(36)
        .presentationBackground(background)
        .interactiveDismissDisabled(hasChanges)
        .alert(
            "Are you sure you want to discard changes on this journal?",
            isPresented: $showDiscardAlert
        ) {
            Button("Keep Editing", role: .cancel) { }
            Button("Discard Changes", role: .destructive) {
                dismiss()
            }
        }
        .task {
            isTitleFocused = true
        }
    }
}

#Preview {
    NavigationStack {
        JournalEditorView { title, content in
            print(title, content)
        }
    }
    .preferredColorScheme(.dark)
}

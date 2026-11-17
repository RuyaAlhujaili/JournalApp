import SwiftUI
import SwiftData

struct JournalHomeView: View {

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]
    @State private var searchText = ""
    @State private var viewModel = JournalViewModel()
    @State private var showAddJournal = false
    @State private var sortByBookmark = false
    @State private var entryToDelete: JournalEntry?
    @State private var showDeleteAlert = false
    @State private var entryToEdit: JournalEntry?

    private var displayedEntries: [JournalEntry] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        let filtered = query.isEmpty ? entries : entries.filter {
            $0.title.localizedCaseInsensitiveContains(query) ||
            $0.content.localizedCaseInsensitiveContains(query)
        }

        return filtered.sorted {
            if sortByBookmark && $0.isBookmarked != $1.isBookmarked {
                return $0.isBookmarked
            }
            return $0.date > $1.date
        }
    }

    var body: some View {

        NavigationStack {

            VStack {

                if entries.isEmpty {

                    Spacer()

                    JournalEmptyStateView()

                    Spacer()

                } else {

                    List {
                        ForEach(displayedEntries) { entry in
                            JournalEntryCardView(
                                entry: entry,
                                onBookmarkTap: {
                                    viewModel.toggleBookmark(for: entry)
                                }
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .contentShape(Rectangle())
                            .onTapGesture {
                                entryToEdit = entry
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    entryToDelete = entry
                                    showDeleteAlert = true
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(Color(red: 253/255, green: 69/255, blue: 60/255))
                                .accessibilityLabel("Delete")
                            }
                        }
                    }
                    .listStyle(.plain)

                }

            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)

            .toolbar {

                ToolbarItemGroup(placement: .topBarTrailing) {

                    Menu {
                        Button("Sort by Bookmark") {
                            sortByBookmark = true
                        }
                        Button("Sort by Entry Date") {
                            sortByBookmark = false
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }

                    Button {
                        showAddJournal = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }

            }

            .searchable(
                text: $searchText,
                placement: .toolbar,
                prompt: "Search"
            )
            .sheet(isPresented: $showAddJournal) {
                NavigationStack {
                    JournalEditorView { title, content in
                        viewModel.addEntry(
                            title: title,
                            content: content,
                            context: modelContext
                        )
                    }
                }
            }
            .sheet(item: $entryToEdit) { entry in
                NavigationStack {
                    JournalEditorView(entry: entry) { title, content in
                        viewModel.updateEntry(entry, title: title, content: content)
                    }
                }
            }
            .alert("Delete Journal?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {
                    entryToDelete = nil
                }
                Button("Delete", role: .destructive) {
                    if let entry = entryToDelete {
                        viewModel.deleteEntry(entry, context: modelContext)
                    }
                    entryToDelete = nil
                }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }

        }

    }
}

#Preview {
    JournalHomeView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
        .preferredColorScheme(.dark)
}

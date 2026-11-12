
import SwiftUI

struct JournalHomeView: View {

    @State private var searchText = ""
    @State private var viewModel = JournalViewModel()
    @State private var showAddJournal = false

    var body: some View {

        NavigationStack {

            VStack {

                if viewModel.entries.isEmpty {

                    Spacer()

                    JournalEmptyStateView()

                    Spacer()

                } else {

                    ScrollView {

                        LazyVStack(spacing: 16) {

                            ForEach(viewModel.entries) { entry in

                                JournalEntryCardView(
                                    entry: entry,
                                    onBookmarkTap: {
                                        viewModel.toggleBookmark(for: entry)
                                    }
                                )

                            }

                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)

                    }

                }

            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)

            .toolbar {

                ToolbarItemGroup(placement: .topBarTrailing) {

                    Button {
                        // Filter action
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
                    AddJournalView { title, content in
                        viewModel.addEntry(
                            title: title,
                            content: content
                        )
                    }
                }
            }

        }

    }
}

#Preview {
    JournalHomeView()
        .preferredColorScheme(.dark)
}

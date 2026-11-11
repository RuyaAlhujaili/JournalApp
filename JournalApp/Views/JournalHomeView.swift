import SwiftUI

struct JournalHomeView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
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
                        // Add journal action
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
        }
    }
}

#Preview {
    JournalHomeView()
        .preferredColorScheme(.dark)
}

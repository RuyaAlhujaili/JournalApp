import SwiftUI
import SwiftData

@main
struct JournalApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            Group {
                if showSplash {
                    SplashView()
                } else {
                    JournalHomeView()
                }
            }
            .preferredColorScheme(.dark)
            .task {
                try? await Task.sleep(for: .seconds(2))
                showSplash = false
            }
        }
        .modelContainer(for: JournalEntry.self)
    }
}

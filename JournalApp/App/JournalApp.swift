import SwiftUI
import SwiftData

// The entry point of the application
@main
struct JournalApp: App {
    // Controls whether the splash screen is displayed
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
            // Use dark mode throughout the app
            .preferredColorScheme(.dark)
            
            // Wait before transitioning to the home screen
            .task {
                try? await Task.sleep(for: .seconds(2))
                showSplash = false
            }
        }
        // Configure SwiftData storage for journal entries
        .modelContainer(for: JournalEntry.self)
    }
}

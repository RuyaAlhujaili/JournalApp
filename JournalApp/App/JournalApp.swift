import SwiftUI

@main
struct JournalApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            JournalHomeView() .preferredColorScheme(.dark)
                    Group {
                        if showSplash {
                            SplashView()
                        } else {
                            JournalHomeView()
                        }
                    }
                    .task {
                        try? await Task.sleep(for: .seconds(2))
                        showSplash = false
            }
        }
    }
}



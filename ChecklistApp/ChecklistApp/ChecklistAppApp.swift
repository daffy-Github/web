import SwiftUI

@main
struct ChecklistAppApp: App {
    @StateObject private var store = ChecklistStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}

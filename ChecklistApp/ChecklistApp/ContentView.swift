import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: ChecklistStore
    @State private var selectedItem: ChecklistItem?
    @State private var searchText = ""

    private var filteredSections: [ChecklistSection] {
        guard !searchText.isEmpty else { return store.sections }

        let lowercasedQuery = searchText.lowercased()
        return store.sections.compactMap { section in
            let filteredItems = section.items.filter { item in
                item.title.lowercased().contains(lowercasedQuery) ||
                (item.notes?.lowercased().contains(lowercasedQuery) ?? false)
            }

            guard !filteredItems.isEmpty else { return nil }
            return ChecklistSection(id: section.id, title: section.title, items: filteredItems)
        }
    }

    var body: some View {
        NavigationSplitView {
            ChecklistListView(sections: filteredSections, selectedItem: $selectedItem)
                .searchable(text: $searchText, prompt: "Search tasks")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: store.resetProgress) {
                                Label("Reset Progress", systemImage: "arrow.counterclockwise")
                            }
                            Button(action: store.markAllComplete) {
                                Label("Complete All", systemImage: "checkmark.circle")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
        } detail: {
            if let item = selectedItem ?? filteredSections.first?.items.first {
                ChecklistDetailView(item: item)
                    .environmentObject(store)
                    .toolbarRole(.editor)
            } else {
                ContentUnavailableView("No Task Selected", systemImage: "checklist", description: Text("Choose a task to view details."))
            }
        }
        .onReceive(store.$sections) { sections in
            if let selected = selectedItem,
               let updated = sections.lazy.flatMap({ $0.items }).first(where: { $0.id == selected.id }) {
                selectedItem = updated
            } else if selectedItem == nil {
                selectedItem = sections.first?.items.first
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ChecklistStore.preview)
}

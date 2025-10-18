import SwiftUI

struct ChecklistListView: View {
    let sections: [ChecklistSection]
    @Binding var selectedItem: ChecklistItem?

    var body: some View {
        List(selection: $selectedItem) {
            ForEach(sections) { section in
                Section(header: ChecklistSectionHeader(title: section.title, progress: progress(for: section))) {
                    ForEach(section.items) { item in
                        NavigationLink(value: item) {
                            ChecklistRow(item: item)
                        }
                    }
                }
            }
        }
        .navigationTitle("Event Checklist")
        .navigationDestination(for: ChecklistItem.self) { item in
            ChecklistDetailView(item: item)
        }
    }

    private func progress(for section: ChecklistSection) -> Double {
        guard !section.items.isEmpty else { return 0 }
        let completed = section.items.filter { $0.isCompleted }.count
        return Double(completed) / Double(section.items.count)
    }
}

private struct ChecklistRow: View {
    let item: ChecklistItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .secondary)
                .font(.title3)
                .accessibilityHidden(true)

        VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                ChecklistProgressView(subtasks: item.subtasks)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Label(item.category.rawValue, systemImage: item.category.systemImage)
                    .labelStyle(.iconOnly)
                    .foregroundStyle(.accent)
                if let due = item.dueDate {
                    Text(due, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(item.title)
        .accessibilityValue(item.isCompleted ? "Completed" : "Pending")
    }
}

#Preview {
    NavigationStack {
        ChecklistListView(sections: MockData.sections, selectedItem: .constant(MockData.sections.first?.items.first))
    }
}

import SwiftUI

struct ChecklistDetailView: View {
    @EnvironmentObject private var store: ChecklistStore
    @State private var notes: String
    @State private var lastSyncedNotes: String
    @State private var isExpanded: Bool = true
    private let initialItem: ChecklistItem

    init(item: ChecklistItem) {
        self.initialItem = item
        let initialNotes = item.notes ?? ""
        _notes = State(initialValue: initialNotes)
        _lastSyncedNotes = State(initialValue: initialNotes)
    }

    private var item: ChecklistItem {
        store.item(withID: initialItem.id) ?? initialItem
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                detail
                subtasks
                notesSection
            }
            .padding()
        }
        .navigationTitle(item.title)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    store.toggle(item)
                } label: {
                    Label(item.isCompleted ? "Mark Incomplete" : "Mark Complete", systemImage: item.isCompleted ? "arrow.uturn.backward" : "checkmark")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onDisappear {
            store.updateNotes(for: item, notes: notes)
            lastSyncedNotes = notes
        }
        .onReceive(store.$sections) { _ in
            let current = item.notes ?? ""
            if current != lastSyncedNotes {
                notes = current
                lastSyncedNotes = current
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: item.category.systemImage)
                    .font(.title2)
                    .foregroundStyle(.accent)
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.category.rawValue)
                        .font(.headline)
                    if let due = item.dueDate {
                        Label(due.formatted(date: .abbreviated, time: .shortened), systemImage: "calendar")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    if let duration = item.estimatedDuration {
                        Label(durationFormatter.string(from: duration) ?? "", systemImage: "hourglass")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(item.isCompleted ? .green : .secondary)
            }
            Text(item.summary)
                .font(.body)
        }
    }

    private var detail: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Details")
                .font(.headline)
            Text(item.summary)
                .font(.body)
                .foregroundStyle(.primary)
        }
    }

    private var subtasks: some View {
        VStack(alignment: .leading, spacing: 8) {
            DisclosureGroup(isExpanded: $isExpanded) {
                ForEach(item.subtasks) { subtask in
                    Toggle(isOn: binding(for: subtask)) {
                        Text(subtask.title)
                    }
                    .toggleStyle(.switch)
                }
            } label: {
                HStack {
                    Text("Subtasks")
                        .font(.headline)
                    Spacer()
                    Text("\(item.subtasks.filter { $0.isCompleted }.count)/\(item.subtasks.count)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Notes")
                .font(.headline)
            TextEditor(text: $notes)
                .frame(minHeight: 120)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                }
        }
    }

    private func binding(for subtask: ChecklistItem.Subtask) -> Binding<Bool> {
        Binding {
            subtask.isCompleted
        } set: { newValue in
            var updated = subtask
            updated.isCompleted = newValue
            store.updateSubtask(updated, for: item)
        }
    }

    private var durationFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter
    }
}
#Preview {
    NavigationStack {
        ChecklistDetailView(item: MockData.sections.first!.items.first!)
            .environmentObject(ChecklistStore.preview)
    }
}

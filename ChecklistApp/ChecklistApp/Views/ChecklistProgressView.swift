import SwiftUI

struct ChecklistProgressView: View {
    let subtasks: [ChecklistItem.Subtask]

    var body: some View {
        if !subtasks.isEmpty {
            HStack(spacing: 8) {
                ProgressView(value: progress)
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 20, height: 20)
                Text("\(completedCount)/\(subtasks.count) subtasks")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Subtask progress")
            .accessibilityValue("\(completedCount) of \(subtasks.count) subtasks complete")
        }
    }

    private var completedCount: Int {
        subtasks.filter { $0.isCompleted }.count
    }

    private var progress: Double {
        guard !subtasks.isEmpty else { return 0 }
        return Double(completedCount) / Double(subtasks.count)
    }
}

#Preview {
    ChecklistProgressView(subtasks: MockData.sections.first?.items.first?.subtasks ?? [])
        .padding()
}

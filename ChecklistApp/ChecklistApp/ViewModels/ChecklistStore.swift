import Foundation

final class ChecklistStore: ObservableObject {
    @Published private(set) var sections: [ChecklistSection]

    init(sections: [ChecklistSection] = MockData.sections) {
        self.sections = sections
    }

    func toggle(_ item: ChecklistItem) {
        update(itemID: item.id) { $0.isCompleted.toggle() }
    }

    func updateNotes(for item: ChecklistItem, notes: String) {
        update(itemID: item.id) { $0.notes = notes }
    }

    func updateSubtask(_ subtask: ChecklistItem.Subtask, for item: ChecklistItem) {
        update(itemID: item.id) { parent in
            guard let index = parent.subtasks.firstIndex(where: { $0.id == subtask.id }) else { return }
            parent.subtasks[index] = subtask
            parent.isCompleted = parent.subtasks.allSatisfy { $0.isCompleted }
        }
    }

    func resetProgress() {
        sections = sections.map { section in
            var newSection = section
            newSection.items = section.items.map { item in
                var mutableItem = item
                mutableItem.isCompleted = false
                mutableItem.subtasks = item.subtasks.map { subtask in
                    var mutableSubtask = subtask
                    mutableSubtask.isCompleted = false
                    return mutableSubtask
                }
                return mutableItem
            }
            return newSection
        }
    }

    func markAllComplete() {
        sections = sections.map { section in
            var newSection = section
            newSection.items = section.items.map { item in
                var mutableItem = item
                mutableItem.isCompleted = true
                mutableItem.subtasks = item.subtasks.map { subtask in
                    var mutableSubtask = subtask
                    mutableSubtask.isCompleted = true
                    return mutableSubtask
                }
                return mutableItem
            }
            return newSection
        }
    }

    func item(withID id: ChecklistItem.ID) -> ChecklistItem? {
        sections.lazy.flatMap { $0.items }.first { $0.id == id }
    }

    private func update(itemID: ChecklistItem.ID, mutate: (inout ChecklistItem) -> Void) {
        guard let sectionIndex = sections.firstIndex(where: { section in
            section.items.contains(where: { $0.id == itemID })
        }) else { return }

        guard let itemIndex = sections[sectionIndex].items.firstIndex(where: { $0.id == itemID }) else { return }

        var newSections = sections
        var newItem = newSections[sectionIndex].items[itemIndex]
        mutate(&newItem)
        newSections[sectionIndex].items[itemIndex] = newItem
        sections = newSections
    }
}

extension ChecklistStore {
    static var preview: ChecklistStore {
        ChecklistStore(sections: MockData.sections)
    }
}

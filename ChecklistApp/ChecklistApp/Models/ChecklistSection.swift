import Foundation

struct ChecklistSection: Identifiable, Hashable {
    let id: UUID
    var title: String
    var items: [ChecklistItem]

    init(id: UUID = UUID(), title: String, items: [ChecklistItem]) {
        self.id = id
        self.title = title
        self.items = items
    }
}

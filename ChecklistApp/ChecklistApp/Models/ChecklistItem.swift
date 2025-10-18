import Foundation

struct ChecklistItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var summary: String
    var dueDate: Date?
    var isCompleted: Bool
    var notes: String?
    var subtasks: [Subtask]
    var category: Category
    var estimatedDuration: TimeInterval?

    struct Subtask: Identifiable, Hashable {
        let id: UUID
        var title: String
        var isCompleted: Bool

        init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
            self.id = id
            self.title = title
            self.isCompleted = isCompleted
        }
    }

    enum Category: String, CaseIterable, Identifiable, Codable {
        case preparation = "Preparation"
        case venue = "Venue"
        case equipment = "Equipment"
        case hospitality = "Hospitality"
        case wrapUp = "Wrap-Up"

        var id: String { rawValue }
        var systemImage: String {
            switch self {
            case .preparation: return "pencil"
            case .venue: return "building.2"
            case .equipment: return "wrench.and.screwdriver"
            case .hospitality: return "fork.knife"
            case .wrapUp: return "checkmark.seal"
            }
        }
    }

    init(
        id: UUID = UUID(),
        title: String,
        summary: String,
        dueDate: Date? = nil,
        isCompleted: Bool = false,
        notes: String? = nil,
        subtasks: [Subtask] = [],
        category: Category,
        estimatedDuration: TimeInterval? = nil
    ) {
        self.id = id
        self.title = title
        self.summary = summary
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.notes = notes
        self.subtasks = subtasks
        self.category = category
        self.estimatedDuration = estimatedDuration
    }
}

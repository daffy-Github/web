import Foundation

enum MockData {
    static let sections: [ChecklistSection] = {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let preparationItems = [
            ChecklistItem(
                title: "Confirm event brief",
                summary: "Review objectives, audience, and logistics with stakeholders.",
                dueDate: today,
                notes: "Coordinate with marketing lead for updated agenda.",
                subtasks: [
                    .init(title: "Gather attendee demographics", isCompleted: true),
                    .init(title: "Finalize slide deck"),
                    .init(title: "Distribute agenda to speakers")
                ],
                category: .preparation,
                estimatedDuration: 60 * 60
            ),
            ChecklistItem(
                title: "Confirm vendor contracts",
                summary: "Ensure all vendor agreements are signed and filed.",
                dueDate: calendar.date(byAdding: .day, value: 1, to: today),
                notes: "Waiting on catering signature.",
                subtasks: [
                    .init(title: "Audio/Visual"),
                    .init(title: "Catering"),
                    .init(title: "Decor")
                ],
                category: .preparation,
                estimatedDuration: 45 * 60
            )
        ]

        let venueItems = [
            ChecklistItem(
                title: "Site walk-through",
                summary: "Inspect venue layout, signage, and emergency exits.",
                dueDate: calendar.date(byAdding: .day, value: 2, to: today),
                notes: "Capture updated floor plan in shared drive.",
                subtasks: [
                    .init(title: "Confirm accessibility routes"),
                    .init(title: "Check Wi-Fi coverage"),
                    .init(title: "Verify security contacts")
                ],
                category: .venue,
                estimatedDuration: 90 * 60
            ),
            ChecklistItem(
                title: "Seating layout",
                summary: "Finalize seating arrangements and VIP sections.",
                dueDate: calendar.date(byAdding: .day, value: 3, to: today),
                subtasks: [
                    .init(title: "Assign VIP rows"),
                    .init(title: "Reserve accessibility seating", isCompleted: true)
                ],
                category: .venue,
                estimatedDuration: 30 * 60
            )
        ]

        let equipmentItems = [
            ChecklistItem(
                title: "Audio check",
                summary: "Test microphones, speakers, and mixers.",
                dueDate: calendar.date(byAdding: .day, value: 1, to: today),
                subtasks: [
                    .init(title: "Wireless mics"),
                    .init(title: "Stage monitors"),
                    .init(title: "Backup batteries")
                ],
                category: .equipment,
                estimatedDuration: 75 * 60
            ),
            ChecklistItem(
                title: "Lighting cues",
                summary: "Finalize lighting scenes for each agenda segment.",
                dueDate: calendar.date(byAdding: .day, value: 2, to: today),
                subtasks: [
                    .init(title: "Load keynote cues"),
                    .init(title: "Program walk-on lights"),
                    .init(title: "Verify stage wash")
                ],
                category: .equipment,
                estimatedDuration: 60 * 60
            )
        ]

        let hospitalityItems = [
            ChecklistItem(
                title: "Catering menu",
                summary: "Confirm dietary accommodations and final headcount.",
                dueDate: calendar.date(byAdding: .day, value: 1, to: today),
                notes: "Provide vegan and gluten-free options.",
                subtasks: [
                    .init(title: "Confirm dessert selection"),
                    .init(title: "Update beverage list", isCompleted: true)
                ],
                category: .hospitality,
                estimatedDuration: 50 * 60
            ),
            ChecklistItem(
                title: "Speaker hospitality",
                summary: "Arrange green room amenities and transport schedules.",
                dueDate: calendar.date(byAdding: .day, value: 2, to: today),
                subtasks: [
                    .init(title: "Confirm arrival times"),
                    .init(title: "Stock refreshments"),
                    .init(title: "Prepare welcome packets")
                ],
                category: .hospitality,
                estimatedDuration: 40 * 60
            )
        ]

        let wrapUpItems = [
            ChecklistItem(
                title: "Post-event survey",
                summary: "Send attendee feedback form and collect responses.",
                dueDate: calendar.date(byAdding: .day, value: 5, to: today),
                subtasks: [
                    .init(title: "Draft questions"),
                    .init(title: "Configure email list"),
                    .init(title: "Schedule send")
                ],
                category: .wrapUp,
                estimatedDuration: 35 * 60
            ),
            ChecklistItem(
                title: "Budget reconciliation",
                summary: "Compare actual spend vs. forecast and document variance.",
                dueDate: calendar.date(byAdding: .day, value: 6, to: today),
                notes: "Upload receipts to finance folder.",
                subtasks: [
                    .init(title: "Review vendor invoices"),
                    .init(title: "Approve staff expenses"),
                    .init(title: "Update finance tracker")
                ],
                category: .wrapUp,
                estimatedDuration: 90 * 60
            )
        ]

        return [
            ChecklistSection(title: "Preparation", items: preparationItems),
            ChecklistSection(title: "Venue", items: venueItems),
            ChecklistSection(title: "Equipment", items: equipmentItems),
            ChecklistSection(title: "Hospitality", items: hospitalityItems),
            ChecklistSection(title: "Wrap-Up", items: wrapUpItems)
        ]
    }()
}

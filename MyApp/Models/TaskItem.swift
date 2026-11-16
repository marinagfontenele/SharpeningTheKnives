import Foundation

struct TaskItem: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var priority: Priority?
    var tag: Tag?
    var subtasks: [Subtask]
    var order: Int
    var isCompleted: Bool
    var showInGeneralSchedule: Bool

    init(
        id: UUID = UUID(),
        name: String,
        priority: Priority? = nil,
        tag: Tag? = nil,
        subtasks: [Subtask] = [],
        order: Int = 0,
        isCompleted: Bool = false,
        showInGeneralSchedule: Bool = true
    ) {
        self.id = id
        self.name = name
        self.priority = priority
        self.tag = tag
        self.subtasks = subtasks
        self.order = order
        self.isCompleted = isCompleted
        self.showInGeneralSchedule = showInGeneralSchedule
    }

    var subtaskProgress: Double {
        guard !subtasks.isEmpty else { return 0 }
        let completed = subtasks.filter { $0.isCompleted }.count
        return Double(completed) / Double(subtasks.count)
    }

    var completedSubtasksCount: Int {
        subtasks.filter { $0.isCompleted }.count
    }
}

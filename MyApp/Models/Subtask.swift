import Foundation

struct Subtask: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var priority: Priority?
    var tag: Tag?
    var isCompleted: Bool
    var order: Int

    init(
        id: UUID = UUID(),
        name: String,
        priority: Priority? = nil,
        tag: Tag? = nil,
        isCompleted: Bool = false,
        order: Int = 0
    ) {
        self.id = id
        self.name = name
        self.priority = priority
        self.tag = tag
        self.isCompleted = isCompleted
        self.order = order
    }
}

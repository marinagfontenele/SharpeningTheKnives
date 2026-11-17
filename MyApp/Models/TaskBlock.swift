import SwiftData
import Foundation

@Model
final class TaskBlock {

    var id: UUID
    var name: String
    var tasks: [TaskItem]
    var order: Int

    init(
        id: UUID = UUID(),
        name: String,
        tasks: [TaskItem] = [],
        order: Int = 0
    ) {
        self.id = id
        self.name = name
        self.tasks = tasks
        self.order = order
    }
}

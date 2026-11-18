import Foundation
import SwiftData

@MainActor
final class DataManager {
    static let shared = try! DataManager()

    private let container: ModelContainer
    private var context: ModelContext { container.mainContext }

    init() throws {
        self.container = try ModelContainer(
            for: TaskBlock.self,
            TaskItem.self,
            Subtask.self,
            Tag.self,
            Project.self
        )
    }

    // TaskBlock

    func fetchTaskBlocks() throws -> [TaskBlock] {
        let descriptor = FetchDescriptor<TaskBlock>(
            sortBy: [SortDescriptor(\.order)]
        )
        return try context.fetch(descriptor)
    }

    func addTaskBlock(_ block: TaskBlock) throws {
        context.insert(block)
        try context.save()
    }

    func deleteTaskBlock(_ block: TaskBlock) throws {
        context.delete(block)
        try context.save()
    }

    func updateTaskBlock(_ block: TaskBlock, name: String) throws {
        block.name = name
        try context.save()
    }

    // TaskItem

    func fetchTaskItems() throws -> [TaskItem] {
        let descriptor = FetchDescriptor<TaskItem>(
            sortBy: [SortDescriptor(\.order)]
        )
        return try context.fetch(descriptor)
    }

    func addTaskItem(_ item: TaskItem) throws {
        context.insert(item)
        try context.save()
    }

    func deleteTaskItem(_ item: TaskItem) throws {
        context.delete(item)
        try context.save()
    }

    func updateTaskItemCompletion(_ item: TaskItem, isCompleted: Bool) throws {
        item.isCompleted = isCompleted
        try context.save()
    }

    // Subtask

    func fetchSubtasks() throws -> [Subtask] {
        let descriptor = FetchDescriptor<Subtask>(
            sortBy: [SortDescriptor(\.order)]
        )
        return try context.fetch(descriptor)
    }

    func addSubtask(_ subtask: Subtask) throws {
        context.insert(subtask)
        try context.save()
    }

    func deleteSubtask(_ subtask: Subtask) throws {
        context.delete(subtask)
        try context.save()
    }

    func updateSubtaskCompletion(_ subtask: Subtask, isCompleted: Bool) throws {
        subtask.isCompleted = isCompleted
        try context.save()
    }

    // Tag

    func fetchTags() throws -> [Tag] {
        let descriptor = FetchDescriptor<Tag>(
            sortBy: [SortDescriptor(\.name)]
        )
        return try context.fetch(descriptor)
    }

    func addTag(_ tag: Tag) throws {
        context.insert(tag)
        try context.save()
    }

    func deleteTag(_ tag: Tag) throws {
        context.delete(tag)
        try context.save()
    }

    func updateTag(_ tag: Tag, name: String) throws {
        tag.name = name
        try context.save()
    }

    // Project

    func fetchProjects() throws -> [Project] {
        let descriptor = FetchDescriptor<Project>(
            sortBy: [SortDescriptor(\.name)]
        )
        return try context.fetch(descriptor)
    }

    func addProject(_ project: Project) throws {
        context.insert(project)
        try context.save()
    }

    func deleteProject(_ project: Project) throws {
        context.delete(project)
        try context.save()
    }

    func updateProject(_ project: Project, name: String) throws {
        project.name = name
        try context.save()
    }

    func save() throws {
        try context.save()
    }
}

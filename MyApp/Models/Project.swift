import Foundation

struct Project: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var tasks: [TaskItem]

    init(
        id: UUID = UUID(),
        name: String,
        tasks: [TaskItem] = []
    ) {
        self.id = id
        self.name = name
        self.tasks = tasks
    }

    /// Reinicia o projeto para reaproveitamento, mantendo sua estrutura
    /// e limpando o progresso das tarefas e subtarefas.
    mutating func resetProgress() {
        for taskIndex in tasks.indices {
            tasks[taskIndex].isCompleted = false
            for subtaskIndex in tasks[taskIndex].subtasks.indices {
                tasks[taskIndex].subtasks[subtaskIndex].isCompleted = false
            }
        }
    }

    /// Cria uma nova instância do projeto com o mesmo conteúdo,
    /// mas com novos identificadores e progresso zerado.
    func restartedCopy(as name: String? = nil) -> Project {
        let copiedTasks = tasks.map { task in
            TaskItem(
                name: task.name,
                priority: task.priority,
                tag: task.tag,
                subtasks: task.subtasks.map { subtask in
                    Subtask(
                        name: subtask.name,
                        priority: subtask.priority,
                        tag: subtask.tag,
                        isCompleted: false,
                        order: subtask.order
                    )
                },
                order: task.order,
                isCompleted: false,
                showInGeneralSchedule: task.showInGeneralSchedule
            )
        }

        return Project(name: name ?? self.name, tasks: copiedTasks)
    }
}

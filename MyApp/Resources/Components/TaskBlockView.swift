import UIKit

final class TaskBlockView: UIStackView {

    var onDelete: (() -> Void)?

    private let block: TaskBlock
    private let titleLabel = UILabel()
    let tasksStackView = UIStackView()
    private let addButton = UIButton()
    private let deleteButton = UIButton()
    private let blockView = UIView()

    init(block: TaskBlock) {
        self.block = block
        super.init(frame: .zero)
        configure(title: block.name)
        configureAddTaskButton()
        loadTasks()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(title: String) {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        blockView.translatesAutoresizingMaskIntoConstraints = false

        axis = .vertical
        spacing = 20
        alignment = .fill
        distribution = .fill

        layer.borderWidth = 1
        layer.borderColor = UIColor.lavander.cgColor
        layer.cornerRadius = 20

        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        // Título

        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .semibold)
        titleLabel.textColor = .white

        // Stack das tarefas

        tasksStackView.axis = .vertical
        tasksStackView.spacing = 12
        tasksStackView.alignment = .fill
        tasksStackView.distribution = .fill
        
        // botão
        
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        
        addButton.setImage(UIImage(systemName: "ellipsis.circle.fill", withConfiguration: config), for: .normal)
        addButton.tintColor = .lavander
        
        //adição de views

        blockView.addSubview(titleLabel)
        blockView.addSubview(addButton)

        addArrangedSubview(blockView)
        addArrangedSubview(tasksStackView)
        
        //posicionamento
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: blockView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: blockView.centerYAnchor),

            addButton.trailingAnchor.constraint(equalTo: blockView.trailingAnchor),
            addButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            blockView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureAddTaskButton() {
        let addTaskAction = UIAction(
            title: "Adicionar tarefa",
            image: UIImage(systemName: "plus")
        ) { [weak self] _ in
            self?.presentAddTaskSheet()
        }

        let deleteBlockAction = UIAction(
            title: "Apagar bloco",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.confirmDeleteBlock()
        }

        addButton.menu = UIMenu(children: [addTaskAction, deleteBlockAction])
        addButton.showsMenuAsPrimaryAction = true
    }

    private func presentAddTaskSheet() {
        let addTask = AddTaskView()

        let sheet = UIViewController()
        sheet.view.backgroundColor = .sheetBackground

        sheet.view.addSubview(addTask)
        addTask.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addTask.topAnchor.constraint(equalTo: sheet.view.topAnchor),
            addTask.leadingAnchor.constraint(equalTo: sheet.view.leadingAnchor),
            addTask.trailingAnchor.constraint(equalTo: sheet.view.trailingAnchor),
            addTask.bottomAnchor.constraint(equalTo: sheet.view.bottomAnchor)
        ])

        addTask.onClose = { [weak sheet] in
            sheet?.dismiss(animated: true)
        }

        addTask.onSave = { [weak self, weak sheet] name, priority in
            guard let self else { return }
            let newItem = TaskItem(name: name, priority: priority, order: self.block.tasks.count)
            self.block.tasks.append(newItem)
            try? DataManager.shared.save()
            sheet?.dismiss(animated: true)
            self.loadTasks()
        }

        sheet.modalPresentationStyle = .pageSheet

        if let presentation = sheet.sheetPresentationController {
            presentation.detents = [.medium()]
            presentation.prefersGrabberVisible = true
            presentation.preferredCornerRadius = 24
        }

        findViewController()?.present(sheet, animated: true)
    }

    private func confirmDeleteBlock() {
        let alert = UIAlertController(
            title: "Apagar bloco",
            message: "Tem certeza que deseja apagar este bloco? As tarefas pertencentes a ele também serão apagadas.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Apagar", style: .destructive) { [weak self] _ in
            guard let self else { return }
            try? DataManager.shared.deleteTaskBlock(self.block)
            self.onDelete?()
        })

        findViewController()?.present(alert, animated: true)
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self

        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }

        return nil
    }

    private func loadTasks() {
        tasksStackView.arrangedSubviews.forEach { view in
            tasksStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        let tasks = block.tasks.sorted { $0.order < $1.order }
        for task in tasks {
            let taskView = TaskCardView(
                taskName: task.name,
                isCompleted: task.isCompleted,
                priority: task.priority
            )
            tasksStackView.addArrangedSubview(taskView)
        }
    }
    
    private func showAlert(from viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Atenção",
            message: "Digite um título para a tarefa.",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        )

        alert.addAction(okAction)

        viewController.present(alert, animated: true)
    }
    
//    private func setupExample() {
//
//        let todayBlock = TaskCardView()
//
//        let vacationBlock = TaskCardView()
//
//        tasksStackView.addArrangedSubview(todayBlock)
//        tasksStackView.addArrangedSubview(vacationBlock)
//    }
}

#Preview {
    TaskBlockView(block: TaskBlock(name: "Coisas para fazer hoje"))
}

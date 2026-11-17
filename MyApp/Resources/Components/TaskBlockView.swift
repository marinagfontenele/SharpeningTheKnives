import UIKit

final class TaskBlockView: UIStackView {

    private let titleLabel = UILabel()
    let tasksStackView = UIStackView()
    private let addButton = UIButton()
    private let blockView = UIView()
    private weak var viewController: UIViewController?

    init(title: String) {
        super.init(frame: .zero)
        configure(title: title)
        configureAddTaskButton()
        setupExample()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure(title: "")
        configureAddTaskButton()
        setupExample()
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
        
        addButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: config), for: .normal)
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
        addButton.addTarget(
            self,
            action: #selector(openTaskBlock),
            for: .touchUpInside
        )
    }
    
    
    @objc private func openTaskBlock() {
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

        sheet.modalPresentationStyle = .pageSheet

        if let presentation = sheet.sheetPresentationController {
            presentation.detents = [.medium()]
            presentation.prefersGrabberVisible = true
            presentation.preferredCornerRadius = 24
        }

        findViewController()?.present(sheet, animated: true)
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
    
    private func setupExample() {

        let todayBlock = TaskCardView()

        let vacationBlock = TaskCardView()

        tasksStackView.addArrangedSubview(todayBlock)
        tasksStackView.addArrangedSubview(vacationBlock)
    }
}

#Preview {
    TaskBlockView(title: "Coisas para fazer hoje")
}

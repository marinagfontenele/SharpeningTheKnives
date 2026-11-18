import UIKit
import SwiftData

final class ContentView: UIViewController {
    
//     Liste aqui todos os seus @Model, ex.: ModelContainer(for: Item.self, Category.self)
    lazy var container: ModelContainer = {
        do {
            return try ModelContainer(for: TaskBlock.self, TaskItem.self, Tag.self, Subtask.self, Project.self)
        } catch {
            fatalError("Erro ao criar o ModelContainer: \(error)")
        }
    }()

    private var context: ModelContext { container.mainContext }

        init() {
//            self.container = container
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) não é usado")
        }

    private let titleLabel = UILabel()
    private let addButton = UIButton(type: .system)
    private let blocksStackView = UIStackView()
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true

        view.backgroundColor = .backgroundPurple

        configureHeader()
        configureBlocks()
        configureAddBlockButton()
        loadBlocks()
    }

    private func configureHeader() {

        titleLabel.text = "Tarefas"
        titleLabel.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize, weight: .bold)
        titleLabel.textColor = .white

        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)

        addButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: config), for: .normal)
        addButton.tintColor = .lavander

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            addButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)

        ])
    }


    private func configureBlocks() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        blocksStackView.translatesAutoresizingMaskIntoConstraints = false

        blocksStackView.axis = .vertical
        blocksStackView.spacing = 24
        blocksStackView.alignment = .fill
        blocksStackView.distribution = .fill

        view.addSubview(scrollView)
        scrollView.addSubview(blocksStackView)

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            blocksStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            blocksStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            blocksStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            blocksStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            blocksStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)

        ])
    }
    
    private func configureAddBlockButton() {
        addButton.addTarget(
            self,
            action: #selector(openAddBlock),
            for: .touchUpInside
        )
    }

    @objc private func openAddBlock() {
        let addBlock = AddBlockView()

        let sheet = UIViewController()
        sheet.view.backgroundColor = .sheetBackground

        sheet.view.addSubview(addBlock)
        addBlock.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addBlock.topAnchor.constraint(equalTo: sheet.view.topAnchor),
            addBlock.leadingAnchor.constraint(equalTo: sheet.view.leadingAnchor),
            addBlock.trailingAnchor.constraint(equalTo: sheet.view.trailingAnchor),
            addBlock.bottomAnchor.constraint(equalTo: sheet.view.bottomAnchor)
        ])

        //atribui função à variável onclose()
        // weak usado apenas para evitar que a closure mantenha uma referência forte ao sheet, o que poderia contribuir para um ciclo de retenção de memória.
        addBlock.onClose = { [weak sheet] in
            sheet?.dismiss(animated: true)
        }

        addBlock.onSave = { [weak self, weak sheet] name in
            let blocks = (try? DataManager.shared.fetchTaskBlocks()) ?? []
            let newBlock = TaskBlock(name: name, order: blocks.count)
            try? DataManager.shared.addTaskBlock(newBlock)
            sheet?.dismiss(animated: true)
            self?.loadBlocks()
        }

        sheet.modalPresentationStyle = .pageSheet

        if let presentation = sheet.sheetPresentationController {
            presentation.detents = [.medium()]
            presentation.prefersGrabberVisible = true
            presentation.preferredCornerRadius = 24
        }

        present(sheet, animated: true)
    }

    private func loadBlocks() {
        blocksStackView.arrangedSubviews.forEach { view in
            blocksStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        let blocks = (try? DataManager.shared.fetchTaskBlocks()) ?? []
        for block in blocks {
            let blockView = TaskBlockView(block: block)
            blocksStackView.addArrangedSubview(blockView)
        }
    }
}

//#Preview {
//    let container = try! ModelContainer(
//        for: TaskBlock.self, TaskItem.self, Tag.self, Subtask.self, Project.self,
//            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
//        )
//        return ContentView(container: container)
//}

import UIKit
import SwiftUI

final class ContentView: UIViewController {

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
        setupExample()
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

    private func setupExample() {

        let todayBlock = TaskBlockView(title: "Coisas para fazer hoje")

        let vacationBlock = TaskBlockView(title: "Tarefas para as férias")

        blocksStackView.addArrangedSubview(todayBlock)
        blocksStackView.addArrangedSubview(vacationBlock)
    }
}

#Preview {
    return ContentView()
}

import UIKit

final class TaskBlockView: UIStackView {

    private let titleLabel = UILabel()
    let tasksStackView = UIStackView()

    init(title: String) {
        super.init(frame: .zero)
        configure(title: title)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure(title: "")
    }

    private func configure(title: String) {

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
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white

        // Stack das tarefas

        tasksStackView.axis = .vertical
        tasksStackView.spacing = 12
        tasksStackView.alignment = .fill
        tasksStackView.distribution = .fill

        addArrangedSubview(titleLabel)
        addArrangedSubview(tasksStackView)
    }
}

//
//  TaskCardView.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 13/11/26.
//

import UIKit

final class TaskCard: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    let cardView = UIView()
    var cardCornerRadius: CGFloat = 20 {didSet {
            layer.cornerRadius = cardCornerRadius
        }
    }
    var cardBackgroundColor: UIColor = .darkPurple {
        didSet {
            backgroundColor = cardBackgroundColor
        }
    }

    private var contentTopConstraint: NSLayoutConstraint?
    private var contentLeadingConstraint: NSLayoutConstraint?
    private var contentTrailingConstraint: NSLayoutConstraint?
    private var contentBottomConstraint: NSLayoutConstraint?

    var contentInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12) {
        didSet {
            contentTopConstraint?.constant = contentInsets.top
            contentLeadingConstraint?.constant = contentInsets.left
            contentTrailingConstraint?.constant = -contentInsets.right
            contentBottomConstraint?.constant = -contentInsets.bottom
        }
    }

    private func setup() {

        layer.cornerRadius = cardCornerRadius
        layer.masksToBounds = true

        cardView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(cardView)

        let top = cardView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: contentInsets.top
        )

        let leading = cardView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: contentInsets.left
        )

        let trailing = cardView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -contentInsets.right
        )

        let bottom = cardView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -contentInsets.bottom
        )

        contentTopConstraint = top
        contentLeadingConstraint = leading
        contentTrailingConstraint = trailing
        contentBottomConstraint = bottom

        NSLayoutConstraint.activate([
            top, leading, trailing, bottom
        ])
    }
}

final class TaskCardView: UIView, UIContextMenuInteractionDelegate {

    private let taskLabel = TaskLabel()
    private var onDelete: (() -> Void)?

    init(taskName: String = "Fazer as unhas", isCompleted: Bool = false, priority: Priority? = nil, onDelete: (() -> Void)? = nil) {
        self.onDelete = onDelete
        super.init(frame: .zero)
        setupCards(taskName: taskName, isCompleted: isCompleted, priority: priority)
        configureContextMenu()
    }

    convenience init(task: TaskItem, onDelete: (() -> Void)? = nil) {
        self.init(taskName: task.name, isCompleted: task.isCompleted, priority: task.priority, onDelete: onDelete)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCards(taskName: "Fazer as unhas", isCompleted: false, priority: nil)
        configureContextMenu()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCards(taskName: "Fazer as unhas", isCompleted: false, priority: nil)
        configureContextMenu()
    }

    private func setupCards(taskName: String, isCompleted: Bool, priority: Priority?) {

        let card = TaskCard()

        card.cardBackgroundColor = .darkPurple
        card.cardCornerRadius = 20

        card.translatesAutoresizingMaskIntoConstraints = false

        addSubview(card)

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let checkButton = CheckButton()

        checkButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            checkButton.widthAnchor.constraint(equalToConstant: 26),
            checkButton.heightAnchor.constraint(equalToConstant: 26)
        ])

        taskLabel.text = taskName
        taskLabel.font = .boldSystemFont(ofSize: 18)
        taskLabel.textColor = .white
        taskLabel.isCompleted = isCompleted

        taskLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        taskLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let indicator = UIView()

        indicator.backgroundColor = priority?.color
        indicator.layer.cornerRadius = 6
        indicator.isHidden = priority == nil

        NSLayoutConstraint.activate([

            indicator.widthAnchor.constraint(equalToConstant: 12),
            indicator.heightAnchor.constraint(equalToConstant: 12)

        ])

        let stackView = UIStackView(arrangedSubviews: [
            checkButton,
            taskLabel,
            indicator,
        ])

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10

        stackView.translatesAutoresizingMaskIntoConstraints = false

        card.cardView.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: card.cardView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: card.cardView.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: card.cardView.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 26)

        ])

        checkButton.onToggle = { [weak self] isChecked in
            self?.taskLabel.isCompleted = isChecked
        }

        checkButton.setChecked(isCompleted)

        heightAnchor.constraint(equalToConstant: 72).isActive = true
    }

    private func configureContextMenu() {
        isUserInteractionEnabled = true
        let interaction = UIContextMenuInteraction(delegate: self)
        addInteraction(interaction)
    }

    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let onDelete else { return nil }
        return TaskMenu.contextMenuConfiguration(onDelete: onDelete)
    }
}

#Preview {
    return TaskCardView()
}

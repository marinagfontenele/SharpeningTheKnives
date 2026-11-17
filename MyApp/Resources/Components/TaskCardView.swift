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

final class TaskCardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCards()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCards()
    }

    private func setupCards() {

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

        let label = TaskLabel()

        label.text = "Fazer as unhas"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.isCompleted = true

        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let indicator = UIView()

        indicator.backgroundColor = .systemRed
        indicator.layer.cornerRadius = 6

        NSLayoutConstraint.activate([

            indicator.widthAnchor.constraint(equalToConstant: 12),
            indicator.heightAnchor.constraint(equalToConstant: 12)

        ])

       // let addButton = AddSubtaskButton()

       // addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

         //   addButton.widthAnchor.constraint(equalToConstant: 26),
          //  addButton.heightAnchor.constraint(equalToConstant: 26)

        ])

        let stackView = UIStackView(arrangedSubviews: [
            checkButton,
            label,
            indicator,
         //   addButton
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

        checkButton.onToggle = { isChecked in
            label.isCompleted = isChecked
        }

        checkButton.setChecked(true)
        
        heightAnchor.constraint(equalToConstant: 72).isActive = true
    }
}

#Preview {
    return TaskCardView()
}

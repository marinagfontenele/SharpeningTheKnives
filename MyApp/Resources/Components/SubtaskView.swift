//
//  Subtask.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 15/11/26.
//

import UIKit

final class SubtaskView: UIView {

    private let checkButton = CheckButton()
    private let subtaskLabel = TaskLabel()

    init(title: String) {
        super.init(frame: .zero)
        configure(title: title)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(title: "")
    }

    private func configure(title: String) {

        checkButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            checkButton.widthAnchor.constraint(equalToConstant: 22),
            checkButton.heightAnchor.constraint(equalToConstant: 22)
        ])

        subtaskLabel.text = title
        subtaskLabel.font = .systemFont(ofSize: 16)
        subtaskLabel.textColor = .white

        let stackView = UIStackView(arrangedSubviews: [
            checkButton,
            subtaskLabel
        ])

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8

        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])

        checkButton.onToggle = { [weak self] isChecked in
            self?.subtaskLabel.isCompleted = isChecked
        }
    }
}

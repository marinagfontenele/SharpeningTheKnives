//
//  PriorityPickerView.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 18/11/26.
//

import UIKit

final class PriorityPickerView: UIView {

    var selectedPriority: Priority?

    private let priorityContainer = UIView()
    private let priorityLabel = UILabel()
    private let priorityButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        if selectedPriority == nil {
            selectedPriority = .null
        }

        priorityContainer.backgroundColor = .textInput
        priorityContainer.layer.cornerRadius = 12
        priorityContainer.clipsToBounds = true

        priorityLabel.text = "Selecione a prioridade"
        priorityLabel.textColor = .label
        priorityLabel.font = .systemFont(ofSize: 16)

        priorityButton.showsMenuAsPrimaryAction = true
        priorityButton.changesSelectionAsPrimaryAction = true

        let priorityRow = UIStackView(
            arrangedSubviews: [
                priorityLabel,
                priorityButton
            ]
        )

        priorityRow.axis = .horizontal
        priorityRow.alignment = .center
        priorityRow.spacing = 8

        priorityLabel.setContentHuggingPriority(
            .defaultLow,
            for: .horizontal
        )

        priorityButton.setContentHuggingPriority(
            .required,
            for: .horizontal
        )

        priorityContainer.addSubview(priorityRow)
        addSubview(priorityContainer)

        priorityContainer.translatesAutoresizingMaskIntoConstraints = false
        priorityRow.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            priorityContainer.topAnchor.constraint(equalTo: topAnchor),
            priorityContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            priorityContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            priorityContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

            priorityRow.leadingAnchor.constraint(
                equalTo: priorityContainer.leadingAnchor,
                constant: 12
            ),

            priorityRow.trailingAnchor.constraint(
                equalTo: priorityContainer.trailingAnchor,
                constant: -12
            ),

            priorityRow.topAnchor.constraint(
                equalTo: priorityContainer.topAnchor
            ),

            priorityRow.bottomAnchor.constraint(
                equalTo: priorityContainer.bottomAnchor
            ),

            priorityContainer.heightAnchor.constraint(
                equalToConstant: 52
            )
        ])

        updateMenu()
        updateSelectedAppearance()
    }

    private func title(for priority: Priority) -> String {
        switch priority {
        case .null: return "Nenhuma"
        case .low: return "Baixa"
        case .medium: return "Média"
        case .high: return "Alta"
        }
    }

    private func circleImage(for priority: Priority) -> UIImage? {
        UIImage(
            systemName: "circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)
        )?.withTintColor(priority.color, renderingMode: .alwaysOriginal)
    }

    private func updateSelectedAppearance() {
        let priority = selectedPriority ?? .null
        var config = priorityButton.configuration ?? .plain()
        config.title = title(for: priority)
        config.baseForegroundColor = .secondaryLabel
        config.image = circleImage(for: priority)
        config.imagePlacement = .leading
        config.imagePadding = 6
        priorityButton.configuration = config
    }

    private func updateMenu() {
        let noneAction = UIAction(
            title: "Nenhuma",
            image: circleImage(for: .null),
            state: selectedPriority == .null ? .on : .off
        ) { [weak self] _ in
            self?.selectedPriority = .null
            self?.updateSelectedAppearance()
        }

        let lowAction = UIAction(
            title: "Baixa",
            image: circleImage(for: .low),
            state: selectedPriority == .low ? .on : .off
        ) { [weak self] _ in
            self?.selectedPriority = .low
            self?.updateSelectedAppearance()
        }

        let mediumAction = UIAction(
            title: "Média",
            image: circleImage(for: .medium),
            state: selectedPriority == .medium ? .on : .off
        ) { [weak self] _ in
            self?.selectedPriority = .medium
            self?.updateSelectedAppearance()
        }

        let highAction = UIAction(
            title: "Alta",
            image: circleImage(for: .high),
            state: selectedPriority == .high ? .on : .off
        ) { [weak self] _ in
            self?.selectedPriority = .high
            self?.updateSelectedAppearance()
        }

        priorityButton.menu = UIMenu(
            children: [
                noneAction,
                lowAction,
                mediumAction,
                highAction
            ]
        )
    }
}

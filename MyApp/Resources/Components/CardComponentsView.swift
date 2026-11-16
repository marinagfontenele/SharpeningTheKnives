//
//  CheckButtonView.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 13/11/26.
//

import UIKit

final class CheckButton: UIButton {

    private(set) var isChecked = false

    var onToggle: ((Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        tintColor = .lavander
        updateAppearance()

        addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
    }

    @objc private func toggleCheck() {
        setChecked(!isChecked)
    }

    func setChecked(_ checked: Bool) {
        isChecked = checked
        updateAppearance()
        onToggle?(isChecked)
    }

    private func updateAppearance() {

        let imageName = isChecked ? "checkmark.circle.fill" : "circle"

        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)

        let image = UIImage(systemName: imageName, withConfiguration: config)

        setImage(image, for: .normal)
    }
}

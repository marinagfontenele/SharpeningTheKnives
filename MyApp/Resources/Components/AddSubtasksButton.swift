//
//  AddSubtasksButton.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 15/11/26.
//

import UIKit

final class AddSubtaskButton: UIButton {

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

        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)

        setImage(image, for: .normal)
    }
}

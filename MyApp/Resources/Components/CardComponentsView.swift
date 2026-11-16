//
//  CheckButtonView.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 13/11/26.
//

import UIKit

final class CheckButton: UIButton {

    private var isChecked = false

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        configure()
    }

    private func configure() {

        updateAppearance()
        addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
    }

    @objc private func toggleCheck() {
        
        isChecked.toggle()
        updateAppearance()
    }

    private func updateAppearance() {

        let imageName = isChecked ? "checkmark.circle.fill" : "circle"
        let image = UIImage(systemName: imageName)
        setImage(image, for: .normal)
        tintColor = .lavander
    }
}

final class AddSubtaskButton: UIButton {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        configure()
    }
}

//
//  TaskLabel.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 15/11/26.
//

import UIKit

final class TaskLabel: UILabel {

    var isCompleted: Bool = false { didSet { updateAppearance()}}
    override var text: String? { didSet { updateAppearance()}}
    override var font: UIFont! { didSet { updateAppearance()}}
    override var textColor: UIColor! { didSet {updateAppearance()}}

    private func updateAppearance() {

        guard let text = text else { return }

        var attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .semibold),
            .foregroundColor: textColor ?? .white
        ]

        if isCompleted {
            attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
            attributes[.strikethroughColor] = textColor ?? .white
        }

        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}

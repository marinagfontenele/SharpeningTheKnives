import UIKit

final class GenericCardView: UIView {

    // MARK: - Subviews

    let contentView = UIView()

    // MARK: - Configurable Appearance

    var cardCornerRadius: CGFloat = 12 {
        didSet { layer.cornerRadius = cardCornerRadius }
    }

    var cardBackgroundColor: UIColor = .darkPurple {
        didSet { backgroundColor = cardBackgroundColor }
    }

    var shadowColor: UIColor = .black {
        didSet { layer.shadowColor = shadowColor.cgColor }
    }

    var shadowOpacity: Float = 0.1 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }

    var shadowRadius: CGFloat = 4 {
        didSet { layer.shadowRadius = shadowRadius }
    }

    var shadowOffset: CGSize = CGSize(width: 0, height: 2) {
        didSet { layer.shadowOffset = shadowOffset }
    }

    var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) {
        didSet {
            contentTopConstraint?.constant = contentInsets.top
            contentLeadingConstraint?.constant = contentInsets.left
            contentTrailingConstraint?.constant = -contentInsets.right
            contentBottomConstraint?.constant = -contentInsets.bottom
        }
    }

    // MARK: - Private Constraints

    private var contentTopConstraint: NSLayoutConstraint?
    private var contentLeadingConstraint: NSLayoutConstraint?
    private var contentTrailingConstraint: NSLayoutConstraint?
    private var contentBottomConstraint: NSLayoutConstraint?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = cardBackgroundColor
        layer.cornerRadius = cardCornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.masksToBounds = false

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        addSubview(contentView)

        let top = contentView.topAnchor.constraint(equalTo: topAnchor, constant: contentInsets.top)
        let leading = contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentInsets.left)
        let trailing = contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentInsets.right)
        let bottom = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -contentInsets.bottom)

        contentTopConstraint = top
        contentLeadingConstraint = leading
        contentTrailingConstraint = trailing
        contentBottomConstraint = bottom

        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

#Preview("GenericCardView") {
    let container = UIView()
    container.backgroundColor = .softPurple

    let card = GenericCardView()
    card.translatesAutoresizingMaskIntoConstraints = false

    let titleLabel = UILabel()
    titleLabel.text = "Título do Card"
    titleLabel.font = .preferredFont(forTextStyle: .headline)
    titleLabel.textColor = .label

    let subtitleLabel = UILabel()
    subtitleLabel.text = "Conteúdo genérico para você estilizar como quiser."
    subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
    subtitleLabel.textColor = .secondaryLabel
    subtitleLabel.numberOfLines = 0

    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false

    card.contentView.addSubview(stackView)
    container.addSubview(card)

    NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: card.contentView.topAnchor),
        stackView.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor),
        stackView.trailingAnchor.constraint(equalTo: card.contentView.trailingAnchor),
        stackView.bottomAnchor.constraint(equalTo: card.contentView.bottomAnchor),

        card.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        card.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
        card.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
    ])

    return container
}
#endif

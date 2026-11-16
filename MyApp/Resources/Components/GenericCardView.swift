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



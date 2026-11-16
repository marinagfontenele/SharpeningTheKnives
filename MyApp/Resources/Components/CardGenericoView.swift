import UIKit

final class CardGenericoView: UIView {

    let contentView = UIView()

    var cardCornerRadius: CGFloat = 12 {
        didSet { layer.cornerRadius = cardCornerRadius }
    }

    var cardBackgroundColor: UIColor = .systemBackground {
        didSet { backgroundColor = cardBackgroundColor }
    }

    var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) {
        didSet {
            contentTopConstraint?.constant = contentInsets.top
            contentLeadingConstraint?.constant = contentInsets.left
            contentTrailingConstraint?.constant = -contentInsets.right
            contentBottomConstraint?.constant = -contentInsets.bottom
        }
    }

    private var contentTopConstraint: NSLayoutConstraint?
    private var contentLeadingConstraint: NSLayoutConstraint?
    private var contentTrailingConstraint: NSLayoutConstraint?
    private var contentBottomConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = cardBackgroundColor
        layer.cornerRadius = cardCornerRadius
        layer.masksToBounds = true

        contentView.translatesAutoresizingMaskIntoConstraints = false
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

final class CardGenericoPreview: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground

        setupCards()
    }

    private func setupCards() {

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // CARD 1 - Configuração padrão

        let card1 = CardGenericoView()
        card1.heightAnchor.constraint(equalToConstant: 120).isActive = true

        let label1 = createLabel(
            title: "Card padrão",
            subtitle: "Utilizando as configurações iniciais."
        )

        card1.contentView.addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label1.centerYAnchor.constraint(equalTo: card1.contentView.centerYAnchor),
            label1.leadingAnchor.constraint(equalTo: card1.contentView.leadingAnchor)
        ])

        // CARD 2 - Cor personalizada

        let card2 = CardGenericoView()
        card2.cardBackgroundColor = .systemBlue
        card2.cardCornerRadius = 24
        card2.heightAnchor.constraint(equalToConstant: 120).isActive = true

        let label2 = createLabel(
            title: "Card azul",
            subtitle: "Com cantos mais arredondados.",
            color: .white
        )

        card2.contentView.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label2.centerYAnchor.constraint(equalTo: card2.contentView.centerYAnchor),
            label2.leadingAnchor.constraint(equalTo: card2.contentView.leadingAnchor)
        ])

        // CARD 3 - Espaçamento personalizado

        let card3 = CardGenericoView()
        card3.cardBackgroundColor = .secondarySystemBackground
        card3.cardCornerRadius = 4
        card3.contentInsets = UIEdgeInsets(
            top: 30,
            left: 30,
            bottom: 30,
            right: 30
        )
        card3.heightAnchor.constraint(equalToConstant: 120).isActive = true

        let label3 = createLabel(
            title: "Card personalizado",
            subtitle: "Com espaçamento interno de 30 pontos."
        )

        card3.contentView.addSubview(label3)
        label3.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label3.centerYAnchor.constraint(equalTo: card3.contentView.centerYAnchor),
            label3.leadingAnchor.constraint(equalTo: card3.contentView.leadingAnchor)
        ])

        stackView.addArrangedSubview(card1)
        stackView.addArrangedSubview(card2)
        stackView.addArrangedSubview(card3)
    }

    private func createLabel(title: String, subtitle: String, color: UIColor = .label) -> UIStackView {

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = color

        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = color.withAlphaComponent(0.8)

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])

        stack.axis = .vertical
        stack.spacing = 6

        return stack
    }
}


#Preview {
    return CardGenericoPreview()
}

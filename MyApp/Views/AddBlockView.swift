
import UIKit

final class AddBlockView: UIStackView {

    private let titleLabel = UILabel()
    private let informationLabel = UILabel()
    private let navBarView = UIStackView()
    private let saveButton = UIButton()
    private let closeButton = UIButton()
    private let nameInput = PaddedTextField()
    
    let checkConfig = UIImage.SymbolConfiguration(
        pointSize: 40,
        weight: .regular
    )

    let closeConfig = UIImage.SymbolConfiguration(
        pointSize: 20,
        weight: .regular
    )

    // Variável que armazena o título digitado
    private var titulo: String = ""

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {

        // Configuração das views
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.translatesAutoresizingMaskIntoConstraints = false

        // Stack principal
        axis = .vertical
        spacing = 28
        alignment = .fill
        distribution = .fill

        isLayoutMarginsRelativeArrangement = true

        layoutMargins = UIEdgeInsets(
            top: 20,
            left: 20,
            bottom: 20,
            right: 20
        )

        navBarView.axis = .horizontal
        navBarView.alignment = .center
        navBarView.distribution = .equalSpacing

        titleLabel.text = "Adicionar Bloco"
        titleLabel.font = .systemFont(
            ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize,
            weight: .regular
        )
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        informationLabel.text = "Nome do bloco"
        informationLabel.font = .systemFont(
            ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize,
            weight: .regular
        )
        informationLabel.textColor = .white
        informationLabel.textAlignment = .left

        let config = UIImage.SymbolConfiguration(
            pointSize: 28,
            weight: .regular
        )

        saveButton.setImage(
            UIImage(systemName: "checkmark.circle.fill", withConfiguration: checkConfig),
            for: .normal
        )

        saveButton.tintColor = .lavander

        closeButton.setImage(
            UIImage(systemName: "xmark", withConfiguration: closeConfig),
            for: .normal
        )

        closeButton.tintColor = .lavander
        closeButton.backgroundColor = .secondarySystemFill
        closeButton.layer.cornerRadius = 22
        closeButton.layer.cornerCurve = .continuous
        closeButton.clipsToBounds = true

        // Tamanho dos botões
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: 44),
            saveButton.heightAnchor.constraint(equalToConstant: 44),

            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),

            navBarView.heightAnchor.constraint(equalToConstant: 44)
        ])

        // Adicionando elementos à navbar
        navBarView.addArrangedSubview(closeButton)
        navBarView.addArrangedSubview(titleLabel)
        navBarView.addArrangedSubview(saveButton)

        nameInput.attributedPlaceholder = NSAttributedString(
            string: "Digite aqui o nome do bloco",
            attributes: [
                .foregroundColor: UIColor.lightGray
            ]
        )
      //  nameInput.borderStyle = .roundedRect
        nameInput.font = .preferredFont(forTextStyle: .body)
        nameInput.textColor = .white
        nameInput.clearButtonMode = .whileEditing
        nameInput.backgroundColor = .textInput
        nameInput.layer.cornerRadius = 12
        nameInput.layer.masksToBounds = true
        
        let heightConstraint = nameInput.heightAnchor.constraint(equalToConstant: 52)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true

        nameInput.setContentHuggingPriority(.required, for: .vertical)
        nameInput.setContentCompressionResistancePriority(.required, for: .vertical)

        // Atualiza a variável conforme o usuário digita
        nameInput.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

        addArrangedSubview(navBarView)
        addArrangedSubview(informationLabel)
        
        setCustomSpacing(10, after: informationLabel)
        
        addArrangedSubview(nameInput)
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        addArrangedSubview(spacer)
    }

    @objc private func textDidChange() {
        titulo = nameInput.text ?? ""
    }
}

final class PaddedTextField: UITextField {
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: 52)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

#Preview {
    AddBlockView()
}

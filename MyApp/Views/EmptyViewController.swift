import UIKit

final class EmptyViewController: UIViewController {

    private let textLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundPurple

        textLabel.text = "Hello"
        textLabel.textColor = .white
        textLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textLabel)

        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

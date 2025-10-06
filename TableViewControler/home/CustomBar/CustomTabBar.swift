import UIKit

// ... (protocolo CodeView) ...

final class CustomTabBar: UIView {

    // --- FUNDO E SEPARADOR ---
    private lazy var blurEffectView: UIVisualEffectView = {
        let efeito = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: efeito)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // --- ITENS DA TABBAR ---
    private let inicioItem = CustomTabBarItem(iconName: "house.fill", title: "Início")
    private let itensItem = CustomTabBarItem(iconName: "list.bullet", title: "Itens")
    private let nunseiItem = CustomTabBarItem(iconName: "gearshape.fill", title: "Configurações")
    
    // O avatar que já tínhamos
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imagem-3") // Use o nome correto da sua imagem
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16 // Metade de 32
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var avatarContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var generalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [inicioItem, itensItem, nunseiItem, avatarContainerView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inicioItem.setSelected(true)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTabBar: CodeView {
    func setupAddView() {
        addSubview(blurEffectView)
        addSubview(topSeparatorView)
        addSubview(generalStackView)
        avatarContainerView.addSubview(avatarImageView)
    }

    func setupCosntraints() {
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            topSeparatorView.topAnchor.constraint(equalTo: self.topAnchor),
            topSeparatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            generalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            generalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            generalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            generalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 32),
            avatarImageView.widthAnchor.constraint(equalToConstant: 32),
            avatarImageView.centerXAnchor.constraint(equalTo: avatarContainerView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarContainerView.centerYAnchor, constant: -4)
        ])
    }
}

import UIKit

class PopularHotelCollectionViewCell: UICollectionViewCell {
    // MARK: - Views / Labels
    private lazy var ImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var pontuacaoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()

    private lazy var quantidadeReviesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()

    private lazy var localLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var badgeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.alignment = .leading
        
        return view
    }()

    // main container
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
    }()

    //MARK: - stacks
    private lazy var avalizacaoStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [pontuacaoLabel, quantidadeReviesLabel])
        s.axis = .horizontal
        s.alignment = .center
        s.spacing = 4
        
        return s
    }()

    private lazy var textStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [tituloLabel, avalizacaoStackView, localLabel, badgeStackView])
        s.axis = .vertical
        s.alignment = .leading
        s.spacing = 6
        s.translatesAutoresizingMaskIntoConstraints = false
        
        return s
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure
    func configure(with card: cardPopularHoteis, with badges: [BadgeViewModel]) {
        ImageView.image = UIImage(named: card.Image)
        tituloLabel.text = card.titulo
        pontuacaoLabel.text = String(format: "%.2f", card.pontuacao)
        quantidadeReviesLabel.text = "(\(card.quantidadeRevies) avaliações)"
        localLabel.text = card.local

        badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for badge in badges {
            let badgeView: UIView
            badgeView = .creatBadgeView(colorText: badge.textColor,
                                        text: badge.text,
                                        colorBadge:badge.corDeFundo,
                                        borderColor: badge.corDaBorda,
                                        conerRadius: 12
            )
    
            badgeStackView.addArrangedSubview(badgeView)
        }
        badgeStackView.isHidden = card.badges.isEmpty
    }


    // MARK: - Self-sizing override
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let targetSize = CGSize(width: layoutAttributes.frame.width, height: UIView.layoutFittingCompressedSize.height)

        let autoSize = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(autoSize.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}

// MARK: - Constraints (CodeView)
extension PopularHotelCollectionViewCell: CodeView {
    func setupCosntraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            ImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            ImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            ImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            ImageView.heightAnchor.constraint(equalTo: ImageView.widthAnchor, multiplier: 0.6),

            textStackView.topAnchor.constraint(equalTo: ImageView.bottomAnchor, constant: 16),
            textStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            textStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            textStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            
            
        ])
    }

    func setupAddView() {
        contentView.addSubview(mainView)
        mainView.addSubview(badgeStackView)
        mainView.addSubview(ImageView)
        mainView.addSubview(textStackView)
    }
}



extension UIView {
    static func creatBadgeView(colorText: UIColor,
                               text: String?,
                               colorBadge: UIColor = .systemPurple,
                               borderColor: UIColor? = nil,
                               borderWidth: CGFloat = 1.0,
                               conerRadius: Int = 8,
                               top: Int = 4,
                               bottom: Int = -4,
                               leading: Int = 8,
                               traling: Int = -8,
                               fontSize: Int = 12,
                               weight: UIFont.Weight = .medium) -> UIView {
        
        let badgeLabel = UILabel()
        badgeLabel.font = .systemFont(ofSize: CGFloat(fontSize), weight: weight)
        badgeLabel.textColor = colorText
        badgeLabel.text = " \(text ?? "") "
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.layer.cornerRadius = 8
        badgeLabel.clipsToBounds = true
        
        let badgeContainer = UIView()
        badgeContainer.backgroundColor = colorBadge
        badgeContainer.layer.cornerRadius = CGFloat(conerRadius)
        badgeContainer.clipsToBounds = true
        badgeContainer.translatesAutoresizingMaskIntoConstraints = false
        
        if let borderColor = borderColor {
            badgeContainer.layer.borderColor = borderColor.cgColor
            badgeContainer.layer.borderWidth = borderWidth
        }
        
        badgeContainer.addSubview(badgeLabel)
        
        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: badgeContainer.topAnchor, constant: CGFloat(top)),
            badgeLabel.bottomAnchor.constraint(equalTo: badgeContainer.bottomAnchor, constant: CGFloat(bottom)),
            badgeLabel.leadingAnchor.constraint(equalTo: badgeContainer.leadingAnchor, constant: CGFloat(leading)),
            badgeLabel.trailingAnchor.constraint(equalTo: badgeContainer.trailingAnchor, constant: CGFloat(traling))
        ])
        
        return badgeContainer 
    }
}

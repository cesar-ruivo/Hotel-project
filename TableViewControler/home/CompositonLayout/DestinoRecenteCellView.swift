import Foundation
import UIKit

final class DestinoRecenteCell: UICollectionViewCell {
    
    // MARK: - Componentes Visuais
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var bottomBlackBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tituloLabel, dataLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private var badgeView: UIView?
    
    // MARK: - Inicializadores
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuração
    
    func configure(with destino: destinoRecente) {
        imageView.image = UIImage(named: destino.image)
        tituloLabel.text = destino.estado
        dataLabel.text = destino.data
        
        badgeView?.removeFromSuperview()
        
        let badge = UIView.creatBadgeView(
            colorText: .darkGray,
            text: destino.badge,
            colorBadge: .white,
            borderColor: .systemGray,
            conerRadius: 12
        )
        
        contentView.addSubview(badge)
        badgeView = badge
        
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            badge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            badge.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

// MARK: - CodeView Protocol
extension DestinoRecenteCell: CodeView {
    func setupAddView() {
        contentView.addSubview(imageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(bottomBlackBarView)
        contentView.addSubview(textStackView)
    }
    
    func setupCosntraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bottomBlackBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomBlackBarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBlackBarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBlackBarView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.48),
            
            textStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            textStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -24),
            textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            textStackView.topAnchor.constraint(greaterThanOrEqualTo: bottomBlackBarView.topAnchor, constant: 8)
        ])
    }
}

import UIKit

class FilterCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .darkText
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    // MARK: - Stack View
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        
        return stackView
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
    var imageLoadTask: URLSessionDataTask?


    
    func configure(with title: String) {
        titleLabel.text = title

        mainView.backgroundColor = .white
        titleLabel.textColor = .darkText
        iconImageView.tintColor = .darkGray
    }
}

// MARK: - CodeView

extension FilterCell: CodeView {
    func setupAddView() {
        contentView.addSubview(mainView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(iconImageView)
        mainView.addSubview(stackView)
    }
    
    func setupCosntraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24)
        ])
    }
}

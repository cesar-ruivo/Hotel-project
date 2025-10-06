//  SectionHeaderView.swift

import UIKit

final class SectionHeaderView: UICollectionReusableView {

    static let reuseIdentifier = "SectionHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionHeaderView: CodeView {
    func setupAddView() {
        addSubview(titleLabel)
    }
    
    func setupCosntraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}

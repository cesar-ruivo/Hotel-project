import UIKit

class HeaderGeneralHomeView: UICollectionReusableView {
    
    // MARK: - Views
    
    private var tituloLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem-vindo, Marcos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subtituloLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore novos hoteis para sua viagem!"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // O contêiner para a barra de busca
    private let searchBarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var pesquisaSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Sua pesquisa"
        searchBar.searchBarStyle = .default
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 22
        searchBar.clipsToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    // MARK: - StackViews
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.tituloLabel, self.subtituloLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .leading
        
        return stack
    }()
    
    private lazy var generalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.textStackView, self.searchBarContainer])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CodeView

extension HeaderGeneralHomeView: CodeView {
    func setupAddView() {
        addSubview(generalStackView)
        searchBarContainer.addSubview(pesquisaSearchBar)
    }
    
    func setupCosntraints() {
        NSLayoutConstraint.activate([
            generalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            generalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            generalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            generalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            pesquisaSearchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor),
            pesquisaSearchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor),
            pesquisaSearchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor),
            pesquisaSearchBar.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor),
            
            searchBarContainer.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

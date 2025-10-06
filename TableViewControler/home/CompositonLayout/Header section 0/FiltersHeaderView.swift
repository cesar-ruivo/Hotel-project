import UIKit

class FiltersHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "FiltersHeaderView"
    
    private var filtros: [String] = []
    
    let filtersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 36)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.showsHorizontalScrollIndicator = false
                                                   
        return collectionView
    }()
    
    private let separatorView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray4
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = UIColor(white: 0.93, alpha: 1.0)
        
        filtersCollectionView.dataSource = self
        filtersCollectionView.delegate = self
        filtersCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: "FilterCell")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with filtros: [String]) {
           self.filtros = filtros
           self.filtersCollectionView.reloadData()
       }
}

extension FiltersHeaderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        let tituloFiltro = filtros[indexPath.item]
        cell.configure(with: tituloFiltro)
        return cell
    }
}

extension FiltersHeaderView: CodeView {
    func setupAddView() {
        addSubview(filtersCollectionView)
        addSubview(separatorView)
    }
    
    func setupCosntraints() {
        NSLayoutConstraint.activate([
            filtersCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            filtersCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            filtersCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            filtersCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: filtersCollectionView.bottomAnchor, constant: 16),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

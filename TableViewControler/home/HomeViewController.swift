import Foundation
import UIKit

final class HomeViewController: UIViewController {
    //MARK: - configuracao inicial
    
    private let filtro: [String] = ["Local", "Preço", "Avaliação", "Pontuação", "Mais populares"]
    
    private let visitadoRecentemente: [destinoRecente] = [
        destinoRecente(image: "destino-1", estado: "Rio de Janeiro", data: "20 de set - 29 de set", badge: "Quero visitar"),
        destinoRecente(image: "destino-2", estado: "Mato Grosso do Sul", data: "18 de set - 24 de set", badge: "Quero visitar"),
        destinoRecente(image: "destino-3", estado: "Minas Gerais", data: "30 de set - 05 de out", badge: "Quero visitar"),
    ]
    
    
    private let popularHoteis: [cardPopularHoteis] = [
        cardPopularHoteis(Image: "lugar-1", titulo: "Movenpick Hotel", pontuacao: 4.96, quantidadeRevies: 231, local: "jakatar - 38 KM do centro", badges: ["cafe da manha", "Cancelamento", "academia"]),
        cardPopularHoteis(Image: "lugar-2", titulo: "Ritz", pontuacao: 4.92, quantidadeRevies: 1002, local: "Paris - 3 KM do centro", badges: ["cafe da manha", "Restaurante", "academia", "Picina"]),
        cardPopularHoteis(Image: "lugar-3", titulo: "Sofitel Legend Old Cataract", pontuacao: 4.98, quantidadeRevies: 893, local: "Aswan - 10 KM do centro", badges: ["Academia"])
    ]
    //MARK: - Tab Bar
    private lazy var customTabBar: CustomTabBar = {
        let bar = CustomTabBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        return bar
    }()
    
    // MARK: - CompositionlLayout
    private lazy var homeCollectionView: UICollectionView = {
        let layout = HomeLayoutFactory.createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Registra os moldes das células
        collectionView.register(PopularHotelCollectionViewCell.self, forCellWithReuseIdentifier: "PopularHotelCell")
        collectionView.register(DestinoRecenteCell.self, forCellWithReuseIdentifier: "DestinoRecenteCell")
        
        collectionView.register(FilterCell.self, forCellWithReuseIdentifier: "FilterCell")
        
        collectionView.register(FiltersHeaderView.self, forSupplementaryViewOfKind: "filtersHeader", withReuseIdentifier: FiltersHeaderView.reuseIdentifier)
        collectionView.register(HeaderGeneralHomeView.self, forSupplementaryViewOfKind: "globalHeader", withReuseIdentifier: "HeaderGeneralHomeView")
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        return collectionView
    }()
    //MARK: - Cor badge
    
    private func PegarBadgeViewModel(for text: String) -> BadgeViewModel {
        switch text {
        case "cafe da manha":
            return BadgeViewModel(text: text,
                                  textColor: UIColor(hex: "#0b4fd9"),
                                  corDeFundo: UIColor(hex: "#e8edf7"),
                                  corDaBorda: UIColor(hex: "#b7c9ed"))
        case "Cancelamento":
            return BadgeViewModel(text: text,
                                  textColor: UIColor(hex: "#9b1003"),
                                  corDeFundo: UIColor(hex: "#fdf7ec"),
                                  corDaBorda: UIColor(hex: "#f7e7d0"))
        case "Academia":
            return BadgeViewModel(text: text,
                                  textColor: UIColor(hex: "#0a9115"),
                                  corDeFundo: UIColor(hex: "#bff2ec"),
                                  corDaBorda: UIColor(hex: "#86e38e"))
        default:
            return BadgeViewModel(text: text,
                                  textColor: .darkGray,
                                  corDeFundo: .systemGray6,
                                  corDaBorda: .systemGray4)
        }
    }
    
    //MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.93, alpha: 1.0)
        
        setupView()
    }
}
    //MARK: - Dlegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.homeCollectionView {
            switch section {
            case 0:
                return 0
            case 1:
                return visitadoRecentemente.count
            case 2:
                return popularHoteis.count
            default:
                return 0
            }
        } else {
            return filtro.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.homeCollectionView {
            switch indexPath.section {
                case 1:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinoRecenteCell", for: indexPath) as! DestinoRecenteCell
                    let destino = visitadoRecentemente[indexPath.row]
                cell.configure(with: destino)
                
                return cell
                
            case 2: // Hotéis populares
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularHotelCell", for: indexPath) as! PopularHotelCollectionViewCell
                let hotel = popularHoteis[indexPath.row]
                
                // Logicas dos badge
                var badgesParaExibir: [BadgeViewModel] = []
                let todosOsBadges = hotel.badges
                
                if todosOsBadges.count > 2 {
                    // Pega os dois primeiros textos
                    let primeirosDois = todosOsBadges.prefix(2)
                    
                    // Transforma os dois primeiros em BadgeViewModels
                    for texto in primeirosDois {
                        badgesParaExibir.append(PegarBadgeViewModel(for: texto)) // Usando sua função
                    }
                    
                    // Calcula o restante e cria o último badge
                    let restante = todosOsBadges.count - 2
                    let badgeRestante = BadgeViewModel(text: "+\(restante)",
                                                       textColor: .darkGray,
                                                       corDeFundo: .systemGray6,
                                                       corDaBorda: .systemGray4)
                    badgesParaExibir.append(badgeRestante)
                
                } else {
                    // Se tiver 2 ou menos, simplesmente transforma todos
                    for texto in todosOsBadges {
                        badgesParaExibir.append(PegarBadgeViewModel(for: texto)) // Usando sua função
                    }
                }
                cell.configure(with: hotel, with: badgesParaExibir)
                
                return cell
            default:
                return UICollectionViewCell()
            }
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
            let tituloFiltro = filtro[indexPath.item]
            print("--- ViewController: Pedindo célula para o item \(indexPath.item), Título: '\(tituloFiltro)'")

            cell.configure(with: tituloFiltro)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "globalHeader" {
            let headerGlobal = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderGeneralHomeView",
                for: indexPath
            ) as! HeaderGeneralHomeView
            
            return headerGlobal
            
        }  else if kind == "filtersHeader" {
            let headerFilter = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FiltersHeaderView.reuseIdentifier,
                for: indexPath
            ) as! FiltersHeaderView
            
            headerFilter.configure(with: self.filtro)
            
            return headerFilter
            
        } else if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as! SectionHeaderView
            
            if indexPath.section == 1 {
                header.titleLabel.text = "Visto recentemente"
            } else if indexPath.section == 2 {
                header.titleLabel.text = "Hotéis populares"
            }
            return header
        }
        
        return UICollectionReusableView()
    }
}

// MARK: - CodeView
extension HomeViewController: CodeView {
    func setupCosntraints() {
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 70),
            
            homeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: customTabBar.topAnchor)
        ])
    }
    
    func setupAddView() {
        view.addSubview(homeCollectionView)
        view.addSubview(customTabBar)
    }
}

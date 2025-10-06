import UIKit

class HomeLayoutFactory {
    static func createLayout() -> UICollectionViewLayout {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        configuration.interSectionSpacing = 4
        
        
        let bemVindoHeaderHeight: CGFloat = 200

        let globalHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(bemVindoHeaderHeight)
        )
        let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: globalHeaderSize,
            elementKind: "globalHeader",
            alignment: .top
        )
        
        configuration.boundarySupplementaryItems = [globalHeader]
        
        let layout = UICollectionViewCompositionalLayout (sectionProvider: { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0:
                return self.createFiltersSection()
            case 1:
                return self.createRecentlyExploredSection()
            case 2:
                return self.createPopularHotelsSection()
            default:
                // Retorna uma seção vazia por segurança
                return NSCollectionLayoutSection(group: .horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(1)), subitems: []))
            }
        }, configuration: configuration)
        
        return layout
    }
        static func createFiltersSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
            
            let filtersHeaderSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(40)
            )
            let filtersHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: filtersHeaderSize,
                elementKind: "filtersHeader",
                alignment: .top
            )

            
            section.boundarySupplementaryItems = [filtersHeader]
            
            return section
        }
    
    static func createRecentlyExploredSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.65),
            heightDimension: .absolute(180)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(20)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem (layoutSize: headerSize, elementKind: "Header", alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 35, leading: 0, bottom: 4, trailing: 0)
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    static func createPopularHotelsSection() -> NSCollectionLayoutSection {
 
        let itemSize = NSCollectionLayoutSize(
            widthDimension:.fractionalWidth(1.0),
            heightDimension:.estimated(300)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension:.fractionalWidth(0.8),
            heightDimension:.estimated(300) 
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem (layoutSize: headerSize, elementKind: "Header", alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

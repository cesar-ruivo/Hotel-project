import Foundation
import UIKit

struct cardPopularHoteis {
    let Image: String
    let titulo: String
    let pontuacao: Double
    let quantidadeRevies: Int
    let local: String
    let badges: [String]
}

struct destinoRecente {
    let image: String
    let estado: String
    let data: String
    let badge: String
}

struct BadgeViewModel {
    let text: String
    let textColor: UIColor
    let corDeFundo: UIColor
    let corDaBorda: UIColor
}

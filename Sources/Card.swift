// TP2 - Card Game System
// Card Model

import Foundation

// 1. ENUMS (1 point)
// Code fourni - Décommenter et compléter

enum Suit: String, CaseIterable {
    case hearts = "♥️"
    case diamonds = "♦️"
    case clubs = "♣️"
    case spades = "♠️"
}

enum Rank: Int, CaseIterable, Comparable {
    case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace

    var name: String {
        switch self {
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ten: return "10"
        case .jack: return "Jack"
        case .queen: return "Queen"
        case .king: return "King"
        case .ace: return "Ace"
        }
    }

    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// 2. STRUCT CARD (2 points)
// TODO: Implémenter la structure Card
struct Card: Comparable, CustomStringConvertible {
//     // TODO: Ajouter les propriétés rank et suit
    var rank: Rank
    var suit: Suit
    
//     // TODO: Computed property description qui retourne "Ace of ♠️"
    var description: String {
        return "\(rank.name) of \(suit.rawValue)"
    }

    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
}

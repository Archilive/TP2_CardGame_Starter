// TP2 - Card Game System
// Card Game Manager with Singleton Pattern

import Foundation

// Game Manager avec singleton pattern
final class CardGameManager {
    static let shared = CardGameManager()

    private init() {}

    // TODO: 3-7. Implémenter les autres composants
    // - Class Deck (3 pts)


    class Deck {
        var cards: [Card] = []
        
        init() {
            reset()
        }
        
        func shuffle() {
            cards.shuffle()
        }
        
        func draw() -> Card? {
            return cards.popLast()
        }
        
        func reset() {
            cards.removeAll()
            for suit in Suit.allCases {
                for rank in Rank.allCases {
                    cards.append(Card(rank: rank, suit: suit))
                }
            }
            shuffle()
        }
    }


    // - Protocol Player (2 pts)

    protocol Player: AnyObject {
        var name: String { get }
        var hand: [Card] { get set }
        var score: Int { get set }
        func playCard() -> Card?
        func receiveCard(_ card: Card)
    }

    // 5. Classes HumanPlayer/AIPlayer (2 pts)
    final class HumanPlayer: Player {
        var name: String
        var hand: [Card] = []
        var score: Int = 0
        
        init(name: String) {
            self.name = name
        }
        
        func playCard() -> Card? {
            guard let card = hand.popLast() else { return nil }
            return card
        }
        
        func receiveCard(_ card: Card) {
            hand.append(card)
        }
    }

    final class AIPlayer: Player {
        var name: String
        var hand: [Card] = []
        var score: Int = 0
        
        init(name: String) {
            self.name = name
        }
        
        func playCard() -> Card? {
            guard let card = hand.popLast() else { return nil }
            return card
        }
        
        func receiveCard(_ card: Card) {
            hand.append(card)
        }
    }

    // 6. Class Game (7 pts)
    class Game {
        var player1: Player
        var player2: Player
        var deck: Deck

        init(player1: Player, player2: Player) {
            self.player1 = player1
            self.player2 = player2
            self.deck = Deck()
        }

        func dealCards() {
            print("Dealing cards...")
            deck.shuffle()
            while let card1 = deck.draw(), let card2 = deck.draw() {
                player1.receiveCard(card1)
                player2.receiveCard(card2)
            }
            print("\(player1.name) received \(player1.hand.count) cards")
            print("\(player2.name) received \(player2.hand.count) cards")
        }
        
        func play() {
            dealCards()
            
            var round = 1
            while !player1.hand.isEmpty && !player2.hand.isEmpty {
                print("\n--- Round \(round) ---")
                playRound()
                round += 1
            }
            
            print("\n=== GAME OVER ===")
            if player1.score > player2.score {
                print("Winner: \(player1.name) with \(player1.score) points!")
            } else if player2.score > player1.score {
                print("Winner: \(player2.name) with \(player2.score) points!")
            } else {
                print("It's a Tie!")
            }
            print("Final score: \(player1.name) \(player1.score) - \(player2.name) \(player2.score)")
        }

        func playRound() {
            guard let card1 = player1.playCard(), let card2 = player2.playCard() else { return }
            
            print("\(player1.name) plays: \(card1)")
            print("\(player2.name) plays: \(card2)")
            
            if card1 > card2 {
                player1.score += 1
                print("\(player1.name) wins this round!")
            } else if card2 > card1 {
                player2.score += 1
                print("\(player2.name) wins this round!")
            } else {
                print("War! Each player plays 3 cards...")
                resolveWar(card1: card1, card2: card2)
            }
            print("Score: \(player1.name) \(player1.score) - \(player2.name) \(player2.score)")
        }
        
        private func resolveWar(card1: Card, card2: Card) {
            if player1.hand.count < 4 || player2.hand.count < 4 {
                if player1.hand.count < 4 && player2.hand.count < 4 {
                     print("Both players don't have enough cards for War. Tie.")
                } else if player1.hand.count < 4 {
                    print("\(player1.name) doesn't have enough cards for War. \(player2.name) wins automatically.")
                    player1.hand.removeAll()
                    player2.score += 100
                } else {
                    print("\(player2.name) doesn't have enough cards for War. \(player1.name) wins automatically.")
                    player1.score += 100
                    player2.hand.removeAll()
                }
                return
            }
            
            for _ in 0..<3 {
                _ = player1.playCard()
                _ = player2.playCard()
            }
            
            guard let warCard1 = player1.playCard(), let warCard2 = player2.playCard() else { return }
            
            print("\(player1.name) plays: \(warCard1)")
            print("\(player2.name) plays: \(warCard2)")
            
            if warCard1 > warCard2 {
                player1.score += 1
                print("\(player1.name) wins the war!")
            } else if warCard2 > warCard1 {
                player2.score += 1
                print("\(player2.name) wins the war!")
            } else {
                print("War! Each player plays 3 cards...")
                resolveWar(card1: warCard1, card2: warCard2)
            }
        }
    }
    
    extension Array where Element == Card {
        func highest() -> Card? {
            return self.max()
        }

        var description: String {
            return self.map { $0.description }.joined(separator: ", ")
        }
    }


    func run() {
        print("Card Game: War")
        print("=================\n")

        let player1 = HumanPlayer(name: "Victor")
        let player2 = AIPlayer(name: "Florian")

        let game = Game(player1: player1, player2: player2)
        game.play()
    }

    
}

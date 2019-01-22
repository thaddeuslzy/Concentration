//
//  Project_1_Model.swift
//  Project_1
//
//  Created by Thaddeus Lim on 23/12/18.
//  Copyright © 2018 Thaddeus Lim. All rights reserved.
//

import Foundation

class Concentration {
    // Classes have a default 0-argument initialiser, but it is good to create an initialiser for this as you want to create a Concentration game with starting conditions eg. numCards etc.
    
    // Call constructor with no inits(arguments)
    //var cards = Array<Card>() OR
    private(set)var cards = [Card]()
    
    // Optional because it only takes a value when there is a card that is face up
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly   // use of closure and extensionsc
            
 //           return faceUpCards.count == 1 ? faceUpCards.first : nil   // extension made this obsolete
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {  // if there currently isnt a single face up card
//                        foundIndex = index
//                    } else {
//                        return nil  // return nil because this is the second card
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue) // evaluates true only if index of card is the one that is chosen as only face up card
                
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Chosen index does not exist in card deck")
        
        // For cards that are not matched
        if !cards[index].isMatched {
            
            // If there is a card that is already face up, let matchIndex be that value.
            // Also check if the index of the chosen card is not the same one that is already up
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true // Indicate that the selected card is face up
                /* Obsolete cos of computed variables */
                // indexOfOnlyFaceUpCard = nil // Now 2 cards are face up, this becomes nil
                
            // either 2, or no cards are face up
            } else {
                /* Obsolete cos of computed variables */
                /* for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                */
                indexOfOnlyFaceUpCard = index
            }
        }
        // Initial action to flip cards when clicked
        /*
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
        */
    }
    
    // Initialise a Concentration class with specified number of matching pairs contained in an array
    init(numPairs: Int) {
        // let card = Card() does not work... because the Card is a struct, and its vars need to initialised, unlike the 'cards' variable in this class, which is automatically initialised
        assert(numPairs > 0 , "You must have at least 1 pair of cards")
        
        for _ in 1...numPairs {
        let card = Card()
        // let match = Card(identity: i)
        // let match = card
            // Putting things into and taking things out of arrays actually copies them, so we do not need the above, simply append into the array and another copy of 'card' is made and placed in 'cards'
            
        cards.append(card) // original card
        cards.append(card) // matching card
            
        // alternative method, adding an array to existing array
        // cards += [card, card]
        }
    }
    
    func shuffleCards() {
        // TODO:
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

//
//  ViewController.swift
//  Project_1
//
//  Created by Thaddeus Lim on 21/12/18.
//  Copyright © 2018 Thaddeus Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Not good as we need to initialise starting conditions for Concentration
    private lazy var game =  Concentration(numPairs: numPairs)
    
    var numPairs: Int {
        return (buttonArray.count + 1) / 2
    }
    
    // IMPORTANT PROPERTY, OBSERVER PROPERTY, when a change is detected in flipCount, the actions under didSet are executed
    private(set) var flipCount = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var buttonArray: [UIButton]!
    
    private func updateFlipCountLabel() {
        let attributes : [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        // assuming all optional is in a set state eg.use ! to unwrap value
        /* use 'let' when something is a constant
        let cardIndex = cardArray.index(of: sender)!
        print("Card selected as index \(cardIndex)")
        */
        
        // if optional is in a set state
        if let cardIndex = buttonArray.firstIndex(of: sender){
            
            // flipCard(withEmoji: emojiArray[cardIndex], on: sender)
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
            
        } else {
            print("Chosen card is not valid")
        }
    }
    
    private func updateViewFromModel() {
        // iterating through the array of buttons though .indices, update their UI based on status
        for index in buttonArray.indices {
            let button = buttonArray[index] // button
            let card = game.cards[index] // card
            // Reflect changes in UI when card is face up
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0, blue: 0.08979126066, alpha: 0): #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            }
        }
    }
    
    private var emojiArray = ["🎄","🌟","☃️","❄️","🎉", "🔔", "🚀","🍿"]
    
    
    // var emoji: Dictionary<Int,String>()  is the Dictionary initialisation
    // We have changed the card to Hashable, therefore it can be put in dictionary
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        
        // Check if card has emoji, if not assign it one from dictionary
        if emoji[card] == nil, emojiArray.count > 0 {
                emoji[card] = emojiArray.remove(at: emojiArray.count.random)
        }
        /*
        // returns an optional because a value may not exist in dictionary
        if emoji[card.identity] != nil {
            return emoji[card.identity]!
        } else {
        return "?"
        }
        */
        // Replaces the above chunk of logic "if nil, return the value inside"
        return emoji[card] ?? "?"
    }
    
    /*@IBAction func touchStar(_ sender: UIButton) {
        flipCard(withEmoji: "🌟", on: sender)
        flipCount += 1
    }
    */
}

extension Int {
    var random: Int {
        
        // Account for all cases, good semantics
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


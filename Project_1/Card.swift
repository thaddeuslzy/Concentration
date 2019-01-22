//
//  Card.swift
//  Project_1
//
//  Created by Thaddeus Lim on 23/12/18.
//  Copyright © 2018 Thaddeus Lim. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int {
        return identity
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool{
        return lhs.identity == rhs.identity
    }
    
    private static var identityGenerator = 0
    
    var isFaceUp = false
    var isMatched = false
    private var identity: Int // Changed to private because now we compare though hash method, no longer using it explicitly
    // Does not contain emoji, cos emoji is a UI concept, Model does not concern itself with this
    
    init() {
     self.identity = Card.getIdentity()
    }
    
    private static func getIdentity() -> Int {
        identityGenerator += 1
        return identityGenerator
    }
}

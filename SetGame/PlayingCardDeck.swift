//
//  PlayingCardDeck.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    private(set) var deck = [PlayingCard]()
    
    init() {
        for number in PlayingCard.Number.all {
            for color in PlayingCard.Color.all {
                for shape in PlayingCard.Shape.all {
                    for shading in PlayingCard.Shading.all {
                        deck.append(PlayingCard(number: number, color: color, shape: shape, shading: shading, isSelected: false, isMatched: false))
                    }
                }
            }
        }
        // randomize
    }
    
    mutating func dealOneMore() -> PlayingCard? {
        if deck.count > 0 {
            return deck.remove(at: deck.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


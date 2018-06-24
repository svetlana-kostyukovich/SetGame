//
//  SetGame.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import Foundation

struct Set {
    private var deck = PlayingCardDeck()
    //deck = [PlayingCard]
    var dealedCards = [PlayingCard]()
    var potentialSetIndex = [Int]()
    var deckIsEmpty = false
    
    // init??
    //potentialSetIndex.reserveCapacity(3)
    
    private func checkSet() -> Bool {
        if checkShape(), checkNumber(), checkShading(), checkColor() {
            return true
        }
        return false
    }
    
    mutating func setToDefault() {
        deck = PlayingCardDeck()
        potentialSetIndex.removeAll()
        dealedCards.removeAll()
        deckIsEmpty = false
    }
    
    mutating func chooseCard(at index: Int) {
        if potentialSetIndex.count < 3 {
            potentialSetIndex.append(index)
            dealedCards[index].isSelected = true
        } else {
            if checkSet() {
                for indeces in potentialSetIndex {
                    dealedCards[indeces].isSelected = false
                    dealedCards[indeces].isMatched = true
                }
            } else {
                for indeces in potentialSetIndex {
                    dealedCards[indeces].isSelected = false
                    dealedCards[indeces].isMatched = false
                }
            }
            potentialSetIndex.removeAll(keepingCapacity: true)
        }
    }
    
    mutating func shuffleCards() {
        let middle: Int = dealedCards.count/2
        for _ in 0..<middle {
            let i = middle.arc4random
            dealedCards.swapAt(i, dealedCards.count-i)
        }
    }
    
    mutating func dealOneMore() {
        if let card = deck.dealOneMore() {
            dealedCards.append(card)
            print("\(card)")
        } else{
            deckIsEmpty = true
        }
    }

    
    private func checkShape() -> Bool {
        if dealedCards[potentialSetIndex[0]].shape == dealedCards[potentialSetIndex[1]].shape
            && dealedCards[potentialSetIndex[0]].shape == dealedCards[potentialSetIndex[2]].shape
            || dealedCards[potentialSetIndex[0]].shape != dealedCards[potentialSetIndex[1]].shape
            && dealedCards[potentialSetIndex[0]].shape != dealedCards[potentialSetIndex[2]].shape
            && dealedCards[potentialSetIndex[1]].shape != dealedCards[potentialSetIndex[2]].shape {
            return true }
        return false
        
    }
    
    private func checkNumber() -> Bool {
        if dealedCards[potentialSetIndex[0]].number == dealedCards[potentialSetIndex[1]].number
            && dealedCards[potentialSetIndex[0]].number == dealedCards[potentialSetIndex[2]].number
            || dealedCards[potentialSetIndex[0]].number != dealedCards[potentialSetIndex[1]].number
            && dealedCards[potentialSetIndex[0]].number != dealedCards[potentialSetIndex[2]].number
            && dealedCards[potentialSetIndex[1]].number != dealedCards[potentialSetIndex[2]].number {
            return true}
        return false
    }
    
    private func checkShading() -> Bool {
        if dealedCards[potentialSetIndex[0]].shading == dealedCards[potentialSetIndex[1]].shading
            && dealedCards[potentialSetIndex[0]].shading == dealedCards[potentialSetIndex[2]].shading
            || dealedCards[potentialSetIndex[0]].shading != dealedCards[potentialSetIndex[1]].shading
            && dealedCards[potentialSetIndex[0]].shading != dealedCards[potentialSetIndex[2]].shading
            && dealedCards[potentialSetIndex[1]].shading != dealedCards[potentialSetIndex[2]].shading {
            return true}
        return false
    }
    
    private func checkColor() -> Bool{
        if dealedCards[potentialSetIndex[0]].color == dealedCards[potentialSetIndex[1]].color
            && dealedCards[potentialSetIndex[0]].color == dealedCards[potentialSetIndex[2]].color
            || dealedCards[potentialSetIndex[0]].color != dealedCards[potentialSetIndex[1]].color
            && dealedCards[potentialSetIndex[0]].color != dealedCards[potentialSetIndex[2]].color
            && dealedCards[potentialSetIndex[1]].color != dealedCards[potentialSetIndex[2]].color {
            return true
        }
        return false
    }
}

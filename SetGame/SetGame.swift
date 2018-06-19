//
//  SetGame.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import Foundation

struct Set {
    var deck = PlayingCardDeck()
    //deck = [PlayingCard]
    var drawn = [PlayingCard]()
    var potentialSetIndex = [Int]()
    
    // init??
    //potentialSetIndex.reserveCapacity(3)
    
    private func checkSet() -> Bool {
        if checkShape(), checkNumber(), checkShading(), checkColor() {
            return true
        }
        return false
    }
    
    mutating func chooseCard(at index: Int) {
        if potentialSetIndex.count < 3 {
            potentialSetIndex.append(index)
        } else {
            if checkSet() {
                for indeces in potentialSetIndex {
                    drawn[indeces].isSelected = false
                    drawn[indeces].isMatched = true
                }
            } else {
                for indeces in potentialSetIndex {
                    drawn[indeces].isSelected = false
                    drawn[indeces].isMatched = false
                }
            }
            potentialSetIndex.removeAll(keepingCapacity: true)
        }
    }
    
    mutating func draw() {
        if let card = deck.select() {
            drawn.append(card)
        }
    }
    
    private func checkShape() -> Bool {
        if drawn[potentialSetIndex[0]].shape == drawn[potentialSetIndex[1]].shape
            && drawn[potentialSetIndex[0]].shape == drawn[potentialSetIndex[2]].shape
            || drawn[potentialSetIndex[0]].shape != drawn[potentialSetIndex[1]].shape
            && drawn[potentialSetIndex[0]].shape != drawn[potentialSetIndex[2]].shape
            && drawn[potentialSetIndex[1]].shape != drawn[potentialSetIndex[2]].shape {
            return true }
        return false
        
    }
    
    private func checkNumber() -> Bool {
        if drawn[potentialSetIndex[0]].number == drawn[potentialSetIndex[1]].number
            && drawn[potentialSetIndex[0]].number == drawn[potentialSetIndex[2]].number
            || drawn[potentialSetIndex[0]].number != drawn[potentialSetIndex[1]].number
            && drawn[potentialSetIndex[0]].number != drawn[potentialSetIndex[2]].number
            && drawn[potentialSetIndex[1]].number != drawn[potentialSetIndex[2]].number {
            return true}
        return false
    }
    
    private func checkShading() -> Bool {
        if drawn[potentialSetIndex[0]].shading == drawn[potentialSetIndex[1]].shading
            && drawn[potentialSetIndex[0]].shading == drawn[potentialSetIndex[2]].shading
            || drawn[potentialSetIndex[0]].shading != drawn[potentialSetIndex[1]].shading
            && drawn[potentialSetIndex[0]].shading != drawn[potentialSetIndex[2]].shading
            && drawn[potentialSetIndex[1]].shading != drawn[potentialSetIndex[2]].shading {
            return true}
        return false
    }
    
    private func checkColor() -> Bool{
        if drawn[potentialSetIndex[0]].color == drawn[potentialSetIndex[1]].color
            && drawn[potentialSetIndex[0]].color == drawn[potentialSetIndex[2]].color
            || drawn[potentialSetIndex[0]].color != drawn[potentialSetIndex[1]].color
            && drawn[potentialSetIndex[0]].color != drawn[potentialSetIndex[2]].color
            && drawn[potentialSetIndex[1]].color != drawn[potentialSetIndex[2]].color {
            return true
        }
        return false
    }
}



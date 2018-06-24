//
//  SetGameView.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import UIKit

class SetGameView: UIView {

    
    var drawnCards = [PlayingCardView](){
        willSet {
            removeAll()
        }
        didSet {
            print("drawn cards count \(drawnCards.count)")
            addDrawnCards()
            setNeedsLayout()
        }
    }
    
    private func removeAll() {
        for card in drawnCards {
            card.removeFromSuperview()
        }
    }

    private func addDrawnCards() {
        for card in drawnCards {
            addSubview(card)
        }
    }
    
    override func layoutSubviews() {
        var grid = Grid(layout: .aspectRatio(0.62), frame: bounds)
        print("\(drawnCards.count)")
        grid.cellCount = drawnCards.count
        for index in 0..<grid.cellCount {
            if let frame = grid[index] {
                let gap = frame.width*0.05
                drawnCards[index].frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width - gap, height: frame.height - gap))
            }
        }
    }
}

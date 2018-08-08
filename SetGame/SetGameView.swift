//
//  SetGameView.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import UIKit

class SetGameView: UIView {
    
    var rowsGrid :Int {return grid?.dimensions.rowCount ?? 0}
    private var grid: Grid?
    
    var drawnCards = [PlayingCardView](){
        willSet {
            removeAll()
        }
        didSet {
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
        super.layoutSubviews()
        grid = Grid(layout: .aspectRatio(0.62), frame: bounds)
        grid!.cellCount = drawnCards.count
                for index in 0..<grid!.cellCount {
                    if let frame = grid![index] {
                        let gap = frame.width*0.05
                       drawnCards[index].frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width - gap, height: frame.height - gap))
                    }
                }
        /*let columnsGrid = grid!.dimensions.columnCount
        for row in 0..<rowsGrid {
            for column in 0..<columnsGrid {
                if drawnCards.count > (row * columnsGrid + column) {
                    UIViewPropertyAnimator.runningPropertyAnimator(
                        withDuration: 0.3,
                        delay:TimeInterval(row) * 0.1,
                        options: [.curveEaseInOut], animations: {
                            if let frame = self.grid![row * columnsGrid + column] {
                                let gap = frame.width*0.05
                                self.drawnCards[row * columnsGrid + column].frame =
                                    CGRect(origin: frame.origin, size: CGSize(width: frame.width - gap, height: frame.height - gap))
                            }
                            
                    }
                    )
                }
            }
            
        }*/
    }
}

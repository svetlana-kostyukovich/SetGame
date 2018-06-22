//
//  SetGameView.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import UIKit

class SetGameView: UIView {

    private let columns = 3
    private let rows = 2
    
    private lazy var grid = Grid(layout: .dimensions(rowCount: rows, columnCount: columns))
    var drawnCards = [PlayingCardView]()
    
    override func draw(_ rect: CGRect) {
        
        
        
        
        // Drawing code
        
        //grid
        //[subView]:PlayingCardView
        
    }
    
    func createDrawnCards() {
        for row in 0..<rows {
            for column in 0..<columns {
                drawnCards[row, column] = newCard
            }
        }
    }
}

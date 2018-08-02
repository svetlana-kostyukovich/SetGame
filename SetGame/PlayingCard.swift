//
//  PlayingCard.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import Foundation

struct PlayingCard {
    var number: Number
    var color: Color
    var shape: Shape
    var shading: Shading
    var isSelected = false
    var isMatched = false
    
    enum Number: Int {
        case one = 1, two, three
        
        static var all = [Number.one, .two, .three]
    }
    
    enum Shape: String {
        case oval
        //case squiggle
        //case diamond
        
        //static var all = [Shape.oval, .squiggle, .diamond]
        static var all = [Shape.oval]
    }
    
    enum Color: String  {
        case red
        case green
        case purple
        
        static var all = [Color.red, .green, .purple]
    }
    
    enum Shading: String {
        case outlined
        case striped
        case solid
        
        static var all = [Shading.outlined, .striped, .solid]
    }
}

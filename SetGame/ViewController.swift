//
//  ViewController.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var setGame = Set()

    @IBOutlet weak var dealMoreButton: UIButton!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var setGameView: SetGameView! {
        didSet{
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(shuffleCards))
        swipe.direction = [.up,.down]
        setGameView.addGestureRecognizer(swipe)
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        setGame.setToDefault()
        for _ in 1...12 {
            setGame.dealOneMore()
            updateViewFromModel()
        }
    }
    
    
    @IBAction func dealThreeMore(_ sender: UIButton) {
        for _ in 1...3 {  // drawnCards + 3
            if !setGame.deckIsEmpty {
                setGame.dealOneMore()
                updateViewFromModel()
            } else {
                dealMoreButton.isEnabled = false
            }
            //setGameView.drawnCards.append(PlayingCardView())
            //setGameView.subviews.last
            //setGameView.shape =
            //setGameView.shape =
        }
    }
    
    func updateViewFromModel() {
        for dealedCard in setGame.dealedCards {
            let playingCardView = PlayingCardView()
            playingCardView.color = UIColor(named: dealedCard.color.rawValue)!
            playingCardView.number = dealedCard.number.rawValue
            playingCardView.shape = dealedCard.shape.rawValue
            playingCardView.shading = dealedCard.shading.rawValue
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(chooseCard))
            tap.numberOfTapsRequired = 1
            playingCardView.addGestureRecognizer(tap)
            
            if dealedCard.isMatched {
                playingCardView.layer.borderColor = UIColor.green.cgColor
            } else if dealedCard.isSelected {
                    playingCardView.layer.borderColor = UIColor.blue.cgColor
            } else {
                playingCardView.layer.borderColor = UIColor.white.cgColor
            }
            
            setGameView.drawnCards.append(playingCardView)
        }
    }
    
    @objc func shuffleCards() {
        setGame.shuffleCards()
        updateViewFromModel()
        //TODO: shuffle drawn cards
    }
    
    @objc func chooseCard(_ sender: UITapGestureRecognizer) {
        if let cardView = sender.view as? PlayingCardView, let index = setGameView.drawnCards.index(of: cardView), sender.state == .ended {
            setGame.chooseCard(at: index)
            updateViewFromModel()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...12 {
            setGame.dealOneMore()
            updateViewFromModel()
        }
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


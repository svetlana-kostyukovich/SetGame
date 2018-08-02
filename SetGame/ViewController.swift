//
//  ViewController.swift
//  SetGame
//
//  Created by Светлана Лобан on 6/19/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //     MARK: Dynamic Animator
    lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var cardBehavior = CardBehavior(in: animator)
    
    //     MARK: Calculated Vars
    
    private var deckCenter: CGPoint {
        return view.convert(dealMoreButton.center, to: setGameView)
    }
    
    private var discardPileCenter: CGPoint {
        return
            dealMoreButton.convert(dealMoreButton.center, to: setGameView)
        
    }
    
    
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
    
    var newCards: [PlayingCardView] {
        var cards = [PlayingCardView]()
        for i in setGameView.drawnCards.count - 3 ..< setGameView.drawnCards.count {
            cards.append(setGameView.drawnCards[i])
        }
        return cards
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        setGame.setToDefault()
        setGameView.drawnCards.removeAll()
        for _ in 1...12 {
            setGame.dealOneMore()
            updateViewFromModel()
        }
        dealMoreButton.isHidden = false
        dealMoreButton.isEnabled = true
    }
    
    
    @IBAction func dealThreeMore(_ sender: UIButton) {
        setGame.score -= 1
        for _ in 1...3 {  // drawnCards + 3
            setGame.dealOneMore()
            if setGame.deckIsEmpty {
                dealMoreButton.isEnabled = false
                dealMoreButton.isHidden = true
            } else {
                dealMoreButton.isHidden = false
                dealMoreButton.isEnabled = true
            }
            updateViewFromModel()
            
            //setGameView.drawnCards.append(PlayingCardView())
            //setGameView.subviews.last
            //setGameView.shape =
            //setGameView.shape =
        }
    }
    
    func updateViewFromModel() {
        setGameView.drawnCards.removeAll()
        setGame.removeMatched()
        for dealedCard in setGame.dealedCards {
            
            let playingCardView = PlayingCardView()
            playingCardView.color = dealedCard.colorForView
            playingCardView.number = dealedCard.number.rawValue
            playingCardView.shape = dealedCard.shape.rawValue
            playingCardView.shading = dealedCard.shading.rawValue
            
            playingCardView.isSelected = dealedCard.isSelected
            playingCardView.isMatched = dealedCard.isMatched
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(chooseCard))
            tap.numberOfTapsRequired = 1
            playingCardView.addGestureRecognizer(tap)
            
            //           if dealedCard.isMatched {
            //               playingCardView.layer.borderColor = UIColor.green.cgColor
            //           } else if dealedCard.isSelected {
            //               playingCardView.layer.borderColor = UIColor.green.cgColor
            //           } else {
            //               playingCardView.layer.borderColor = UIColor.green.cgColor
            //           }
            //           playingCardView.setLayer()
            
            setGameView.drawnCards.append(playingCardView)
            dealAnimation()
        }
        updateScore()
    }
    
    private func updateScore() {
        scoreLabel.text = String("Score: \(setGame.score)")
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
        dealMoreButton.isEnabled = false
        //for _ in 1...12 {
        //    setGame.dealOneMore()
        //    updateViewFromModel()
        // }
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //     MARK:  Animations
    private func dealAnimation () {
        
        var currentDealCard = 0
        
        let timeInterval =  0.15  * Double(setGameView.rowsGrid + 1)
        Timer.scheduledTimer(withTimeInterval: timeInterval,
                             repeats: false) { (timer) in
                                for  cardView in self.newCards{
                                    cardView.animateDeal(from: self.deckCenter,
                                                         delay: TimeInterval(currentDealCard) * 0.25)
                                    currentDealCard += 1
                                }
        }
    }
    
    
    
}

extension PlayingCard {
    var colorForView: UIColor {
        switch self.color.rawValue {
        case "red": return UIColor.red
        case "purple": return UIColor.purple
        case "green": return UIColor.green
        default: return UIColor.brown
        }
    }
}


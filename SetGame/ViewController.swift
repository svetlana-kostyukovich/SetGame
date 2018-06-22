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
        swipe.direction = [.left,.right]
        setGameView.addGestureRecognizer(swipe)
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
    }
    
    
    @IBAction func dealThreeMore(_ sender: UIButton) {
        for _ in 1...3 {
            setGame.dealOneMore()
            setGameView.drawCards(setGame.dealedCards)
            //setGameView.subviews.last
            //setGameView.shape =
            //setGameView.shape =
        }
    }
    
    @objc func shuffleCards() {
        //TODO: shuffle drawn cards
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


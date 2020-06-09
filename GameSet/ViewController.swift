//
//  ViewController.swift
//  GameSet
//
//  Created by Ivanych Puy on 17.05.2020.
//  Copyright © 2020 xubuntus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberOfSetsLable: UILabel!
    
    @IBOutlet weak var addCardsButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    //    private var openedButtons: [Int] {
//        return game.cards.compactMap{$0.placeID}
//    }

   // private lazy var game = GameSet(numberOfCards: numberOfCards)

    
//    @IBAction func addCards(_ sender: UIButton) {
//        if openedButtons.count < 24 {
//            pinCardsToButtons(inQuatity: 3)
//            updateViewFromModel()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // corners
//        for i in 0..<numberOfCards {
//            cardButtons[i].layer.cornerRadius = 8
//            cardButtons[i].clipsToBounds = true
//        }
//        pinCardsToButtons(inQuatity: 12)
//        updateViewFromModel()
        
        numberOfSetsLable.layer.cornerRadius = 8
        numberOfSetsLable.layer.masksToBounds = true
        addCardsButton.layer.cornerRadius = 8
        mainView.layer.cornerRadius = 8
    }
    
//    func pinCardsToButtons(inQuatity qty: Int) {
//        var neededButtons: [Int] = []
//        if game.checkCards() {
//            for choosedCard in game.choosedCards {
//                neededButtons.append(game.cards[choosedCard].placeID!)
//                game.cards[choosedCard].placeID = nil
//                game.cards[choosedCard].isChoosed = false
//            }
//        } else {
//            neededButtons = Array(Set(0..<24).subtracting(openedButtons).shuffled().prefix(qty))
//        }
//        var factQty = qty
//        game.passCards(inQuatity: &factQty)
//        for index in neededButtons[..<factQty] {
//            game.cards[game.cards.firstIndex(where: {$0.placeID == nil && $0.isPassed && $0.setID == nil})!].placeID = index
//        }
//    }
  
    let figures = ["☘︎", "⚑", "☻"]
    
//    private func fillings(of type: Int) -> (Int) -> [NSAttributedString.Key: Any] {
//        switch type {
//        case 1:
//            return {[.strokeWidth: 3,.strokeColor: self.colors[$0 - 1]]}
//        case 2:
//            return {[.foregroundColor: self.colors[$0 - 1]]}
//        default:
//            return {[.strokeWidth: -3,.strokeColor: self.colors[$0 - 1], .foregroundColor: self.colors[$0 - 1].withAlphaComponent(0.35)]}
//        }
//    }
    
    
    
//    func updateViewFromModel() {
//        numberOfSetsLable.text = "Number of sets: \(game.score)"
//        for (key, button) in cardButtons.enumerated() where !openedButtons.contains(key) {
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            button.layer.borderWidth = 0
//            button.setAttributedTitle(nil, for: UIControl.State.normal)
//        }
//        for (key, button) in  cardButtons.enumerated() where openedButtons.contains(key) {
//            button.layer.borderWidth = 0
//            button.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//            let buttonCard = game.cards.first(where: {$0.placeID == key})!
//            let attributedString = NSAttributedString(string: String(repeating: figures[buttonCard.figure - 1], count: buttonCard.qty), attributes: fillings(of: buttonCard.filling)(buttonCard.color))
//            button.setAttributedTitle(attributedString, for: UIControl.State.normal)
//        }
//        let borderColor = (game.choosedCards.count < 3) ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : game.checkCards() ? #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
//        for card in game.choosedCards {
//            cardButtons[game.cards[card].placeID!].layer.borderColor = borderColor.cgColor
//            cardButtons[game.cards[card].placeID!].layer.borderWidth = 2
//        }
//    }
    
    struct GameSettings {
        let colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)]
    }
}

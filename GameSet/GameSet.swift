//
//  GameSet.swift
//  GameSet
//
//  Created by Ivanych Puy on 17.05.2020.
//  Copyright © 2020 xubuntus. All rights reserved.
//

import Foundation

class GameSet {
    var cards = [Card]()
    var score = 0
    
    var choosedCards: [Int] {
        return cards.enumerated().filter{$0.element.isChoosed}.map{$0.offset}
    }
    
    var passedCards: [Int] {
        return cards.enumerated().filter{$0.element.isPassed}.map{$0.offset}
    }
    
    // индексы от 1, в контроллере на это поправка. сделано, чтоб проще было сравнивать карты
    init(numberOfCards: Int) {
        for figure in 1...3 {
            for color in 1...3 {
                for qty in 1...3 {
                    for filling in 1...3 {
                        cards.append(Card(figure: figure, color: color, qty: qty, filling: filling))
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    func chooseCard(at placeID: Int) {
        if let index = cards.firstIndex(where: {$0.placeID == placeID}) {
            if choosedCards.count < 3 {
                if cards[index].isChoosed {
                    cards[index].isChoosed = false
                } else {
                    cards[index].isChoosed = true
                    if choosedCards.count == 3, checkCards() {
                        score += 1
                        for choosedCard in choosedCards {
                            cards[choosedCard].setID = score
                        }
                    }
                }
            } else {
                if checkCards() {
                        for choosedCard in choosedCards {
                            cards[choosedCard].isChoosed = false
                            cards[choosedCard].placeID = nil
                        }
                } else {
                    for choosedCard in choosedCards {
                        cards[choosedCard].isChoosed = false
                    }
                }
                cards[index].isChoosed = cards[index].setID == nil
            }
        }
    }
    
    func checkCards() -> Bool{
        if choosedCards.count == 3,
            Set(arrayLiteral: cards[choosedCards[0]].figure, cards[choosedCards[1]].figure, cards[choosedCards[2]].figure).count != 2
            && Set(arrayLiteral: cards[choosedCards[0]].color, cards[choosedCards[1]].color, cards[choosedCards[2]].color).count != 2
            && Set(arrayLiteral: cards[choosedCards[0]].qty, cards[choosedCards[1]].qty, cards[choosedCards[2]].qty).count != 2
            && Set(arrayLiteral: cards[choosedCards[0]].filling, cards[choosedCards[1]].filling, cards[choosedCards[2]].filling).count != 2 {
            return true
        } else {
            return false
        }
    }
    
    func passCards(inQuatity qty: inout Int) {
        qty = min(qty, Array(Set(0..<81).subtracting(Set(passedCards)).shuffled().prefix(qty)).count)
        let newPassedCards: [Int] = Array(Set(0..<81).subtracting(Set(passedCards)).shuffled().prefix(qty))
        for newCard in newPassedCards {
            cards[newCard].isPassed = true
        }
    }
}

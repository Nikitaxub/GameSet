//
//  Card.swift
//  GameSet
//
//  Created by Ivanych Puy on 17.05.2020.
//  Copyright © 2020 xubuntus. All rights reserved.
//

import Foundation

struct Card: Hashable
{
//    static func == (lhs: Card, rhs: Card) -> Bool {
//        return lhs.identifier == rhs.identifier
//    }
//
    func hash(into hasher: inout Hasher) {
        hasher.combine(figure)
        hasher.combine(color)
        hasher.combine(qty)
        hasher.combine(filling)
    }
    
    var isPassed = false
    var isChoosed = false
    var setID: Int?
    var placeID: Int?
    
    let figure: Int
    let color: Int
    let qty: Int
    let filling: Int
//    private var identifier: Int
//
//    private static var identifierFactory = 0
//
//    private static func getUniqueIdentifier() -> Int {
//        identifierFactory += 1
//        return identifierFactory
//    }
//
//    init() {
//        self.identifier = Card.getUniqueIdentifier()
//    }
}

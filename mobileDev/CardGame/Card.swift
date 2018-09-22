//
//  Card.swift
//  CardGame
//
//  Created by Leo, Daniel Christopher on 9/17/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import Foundation

class Card:CustomStringConvertible{
    var value: Int  //Int value and string suit properties
    var suit: String
    
    var description: String{
        return "\(nameForValue(value)) of \(suit) "
        
    }
    
    init(value:Int, suit:String){  //initializer accepting a value and suit and assigns them to properties
        self.value = value
        self.suit = suit
        
    }
    func nameForValue(_ value:Int)->String{  //nameForValue method that take a card value and returns representation of that value
        if value <= 10 {
            return String(value)
        }else if value == 11{
            return "Jack"
        }else if value == 12{
            return "Queen"
        }else if value == 13{
            return "King"
        }else{
            return "Ace"
        }
    }
    
   
}

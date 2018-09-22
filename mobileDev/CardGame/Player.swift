//
//  Player.swift
//  CardGame
//
//  Created by Leo, Daniel Christopher on 9/17/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import Foundation

class Player{
    //array of cards property named "hand"
    var hand = [Card]()
    //initializer without parameters that instaniates hand
    init(){
        hand = [Card]()
        
    }
    //addCard: adds card parameter to the end of hand
    func addCard(_ card:Card){
        hand.append(card)
    }
    //addCards: adds array of cards parameter to the end of hand
    func addCards(_ newCards : [Card] ){
        hand += newCards
    }
    //hasCards: return true if cards remain in the hand
    func hasCards()->Bool{
        return !hand.isEmpty
        
    }
    //numCards: return number of cards in hand
    func numCards()->Int{
        return hand.count
       
    }
    //getNextCard: return and removes the first card in the hand if it exists
    func getNextCard()->Card?{
        if hasCards(){
            return hand.remove(at: 0)
        }
        return nil
    }
}

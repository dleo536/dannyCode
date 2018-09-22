//
//  Deck.swift
//  CardGame
//
//  Created by Leo, Daniel Christopher on 9/17/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import Foundation

class Deck{
    //array of Cards property
    var cards = [Card]()
    
    //initializer that has no parameters, instantiates the array of cards, create all 52 cards , insert them into the deck, shuffle the cards
    init(){
        cards = [Card]()
        for i in 2...14{
            cards.append(Card(value:i, suit:"Clubs"))
            cards.append(Card(value:i, suit:"Diamonds"))
            cards.append(Card(value:i, suit:"Spades"))
            cards.append(Card(value:i, suit:"Hearts"))
            
        }
        shuffleCards()
        
    }
    //hasCards: return a Bool indicating whether or not cards remain in the deck
    func hasCards()->Bool{
//        if(cards.count > 0){
//            return true
//        }else{
//            return false
//        }
        return !cards.isEmpty
    }
    //dealCards: remove and return the first card in the deck if it exists
    func dealCard() ->Card?{
        if hasCards(){
            return cards.remove(at: 0)
        }
        return nil
    }
    //shuffleCards: randomly choose two cards in the deck, swap them, repeat this 1000 times
    func shuffleCards(){
        let numCards:UInt32 = UInt32(cards.count)
        var firstIndex:Int
        var secondIndex:Int
        var card:Card
        for _ in 1...1000{
            firstIndex = Int(arc4random_uniform(numCards))
            secondIndex = Int(arc4random_uniform(numCards))
            card = cards[Int(firstIndex)]
            cards[firstIndex] = cards[secondIndex]
            cards[secondIndex] = card
        }
        
    }
}

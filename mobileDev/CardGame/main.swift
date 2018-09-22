//
//  main.swift
//  CardGame
//
//  Created by Leo, Daniel Christopher on 9/17/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import Foundation

//create players + deck
var player = Player()
var computer = Player()
var deck = Deck()
var i :Int = 0
while deck.hasCards(){//deal cards from the deck to players
    player.addCard(deck.dealCard()!)
    computer.addCard(deck.dealCard()!)
    
}


//while the game is not over
while (player.hasCards() && computer.hasCards()){
//    if(player.numCards() == 0){
//        print("Computer Wins")
//    }
//    if(computer.numCards() == 0){
//        print("Player Wins")
//    }
    print("You have \(player.numCards())")
    print("Computer has \(computer.numCards())")
    var playerCard = player.getNextCard() //player plays card
    var computerCard = computer.getNextCard() //computer plays card
    var playerWarDeck = [Card]() //player war deck
    var computerWarDeck = [Card]() //computer's war deck
    
    print("You played a \(playerCard!.nameForValue(playerCard!.value)) of \(playerCard!.suit)")
    print("Computer played a \(computerCard!.nameForValue(computerCard!.value)) of \(computerCard!.suit)")
    
    
    if (playerCard!.value > computerCard!.value){   //if player card is greatest, then add both cards to player hand
        player.addCard(playerCard!)
        player.addCard(computerCard!)
        print("You win this round.")
        print(" ")
    }else if (playerCard!.value < computerCard!.value){ //else if computer card is greatest, then add both cards to player hand
        computer.addCard(playerCard!)
        computer.addCard(computerCard!)
        //        print("You have \(player.numCards())")
        //        print("Computer has \(computer.numCards())")
        //        print("You played a \(playerCard!.nameForValue(playerCard!.value)) of \(playerCard!.suit)")
        //        print("Computer played a \(computerCard!.nameForValue(computerCard!.value)) of \(computerCard!.suit)")
        print("Computer wins this round.")
        print(" ")
    }else if(playerCard!.value == computerCard!.value){//if cards are the same enter war
        print("")
        print("---WAR!!!---")
        var inWar:Bool = true
        while(inWar){//stay at war until playerCards aren't the same
            var i = 0
            while((inWar) && (i <= 3)){
                i += 1

                if(player.numCards() == 0){
//                    print("Computer Wins")
                    inWar = false
                }else if(computer.numCards() == 0){
//                    print("Player Wins")
                    inWar = false
                }else{
                    var playerWarCard:Card = player.getNextCard()!
                    var computerWarCard:Card = computer.getNextCard()!
                    playerWarDeck.append(playerWarCard)//war cards
                    print("You are discarding...")
                    computerWarDeck.append(computerWarCard) //war cards
                    print("The computer is discarding...")
//                    print("\(playerWarDeck.count)")
                    
                }
            }//players top 4 cards separated
                if ((inWar)&&(playerWarDeck[playerWarDeck.count-1].value > computerWarDeck[computerWarDeck.count-1].value)){//if players fourth card is greater than the computer's
                    print("You played a \(playerWarDeck[playerWarDeck.count-1].nameForValue(playerWarDeck[playerWarDeck.count-1].value)) of \(playerWarDeck[playerWarDeck.count-1].suit)")
                    print("Computer played a \(computerWarDeck[computerWarDeck.count-1].nameForValue(computerWarDeck[computerWarDeck.count-1].value)) of \(computerWarDeck[computerWarDeck.count-1].suit)")
                    print("This is the player at card count \(playerWarDeck[playerWarDeck.count-1].nameForValue(playerWarDeck[playerWarDeck.count-1].value))")
                    print("This is the player card at 3 \(playerWarDeck[playerWarDeck.count-1].nameForValue(playerWarDeck[playerWarDeck.count-1].value))")
                    print("You won the war!")
                    print(" ")
                    player.addCards(playerWarDeck)
                    player.addCard(playerCard!)
                    player.addCards(computerWarDeck)
                    player.addCard(computerCard!)
                    //                playerCard = playerWarDeck[3] //set the playerCard and computerCard equal to the warDeck cards to break from the while
                    //                computerCard = computerWarDeck[3]
                    inWar = false
                }else if ((inWar) && (playerWarDeck[playerWarDeck.count-1].value < computerWarDeck[playerWarDeck.count-1].value)){//if computers fourth card is greater than the player's then add it
                    print("You played a \(playerWarDeck[playerWarDeck.count-1].nameForValue(playerWarDeck[playerWarDeck.count-1].value)) of \(playerWarDeck[playerWarDeck.count-1].suit)")
                    print("Computer played a \(computerWarDeck[computerWarDeck.count-1].nameForValue(computerWarDeck[computerWarDeck.count-1].value)) of \(computerWarDeck[computerWarDeck.count-1].suit)")
                    print("Computer won the war")
                    print(" ")
                    computer.addCards(playerWarDeck)
                    computer.addCard(playerCard!)
                    computer.addCards(computerWarDeck)
                    computer.addCard(computerCard!)
                    //                playerCard = playerWarDeck[3] //set the playerCard and computerCard equal to the warDeck cards to break from the while
                    //                computerCard = computerWarDeck[3]
                    inWar = false
                }else {
//                    print("You played a \(playerWarDeck[playerWarDeck.count-1].nameForValue(playerWarDeck[playerWarDeck.count-1].value)) of \(playerWarDeck[playerWarDeck.count-1].suit)")
//                    print("Computer played a \(computerWarDeck[computerWarDeck.count-1].nameForValue(computerWarDeck[computerWarDeck.count-1].value)) of \(computerWarDeck[computerWarDeck.count-1].suit)")
            
            }
        }
   
//        if(player.numCards() == 0){
//            print("Computer Wins")
//            inWar = false
//        }
//        if(computer.numCards() == 0){
//            print("Player Wins")
//            inWar = false
//        }
    
    }
    

}

if(player.numCards() == 0){
    print("Computer Wins")
    
}
if(computer.numCards() == 0){
    print("Player Wins")
    
}


//display winner

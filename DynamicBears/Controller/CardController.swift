//
//  CardsController.swift
//  DynamicBears
//
//  Created by Arthur Lazzaretti on 10/12/2017.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
public class CardController {
    
    /// function to get a NEW card from data (never used)
    ///returns random card from card Data, or nil if there is no data
    static func getNewCards(_ numCards : Int) -> [Card]? {
//        WHAT TO DO WHEN NO MORE CARDS???????????????????
        
        return SessionController.playCards(numCards)
        
    }
    /// function to get a card from data (already shown used)
    ///returns random card from card Data, or nil if there is no data
    static func getPlayedCards(_ numCards : Int) -> [Card]? {
            return SessionController.useCards(numCards)
        
    }
    
    
    static func getCardsNotOnThisLevel() -> [Card] {
        return SessionController.useCardsNotOnThisLevel(SessionController.cardsPerLevel)
    }
    
    
    static func getCardsNewLevel() -> [Card]? {
        let newCards = getNewCards(SessionController.cardsPerLevel)
        if (newCards == nil) {return nil}
        return newCards

//        return SessionController.cardsBeingPlayed
        
    }
    
    
    
    
    
    
    
    
}

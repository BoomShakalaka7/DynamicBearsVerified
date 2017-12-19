//
//  SessionController.swift
//  DynamicBears
//
//  Created by Marco Davide Fioretto on 11/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
public class SessionController {
    
    
    public static var cardsPerLevel = 4
    public static var round = 1
    public static var hasCardsForNextLevel : Bool {
        get {
            return cardsNotUsed.count >= cardsPerLevel
        }
    }
    
    
    public static var packetType = PacketType.Mentors

    
    

    
    public static var score = 0
    
    static var userName : String?  {
        get {
            return FileConnection.userName
        }
        set {
            if (newValue != nil) {
                FileConnection.saveUserName(user: newValue!)
            }
            
        }
    }
    
    static var lives = 3
    static var level = 1
    
    
    
    static private var cardsNotUsed : [Card] = CardData.getGameCards()
    
    internal static var cardsBeingPlayed : [Card] = []
    static var cardsNotPlayedThisLevel : [Card] = []
    
    
    static func playCards(_ numCards : Int)  -> [Card]? {
        
        if (numCards > cardsNotUsed.count) { return nil;}
        var indexes = RandomHelper.getRandoms(upperLimit: UInt32(cardsNotUsed.count), numberOfRandoms: UInt32(numCards))
        indexes = indexes.sorted(by: { $0 > $1 })
        var returnCards : [Card] = []
        cardsBeingPlayed = cardsBeingPlayed.shuffle
        for index in indexes {
            let card = cardsNotUsed.remove(at: index)
            cardsBeingPlayed.append(card)
            returnCards.append(card)
        }
        cardsNotPlayedThisLevel = cardsBeingPlayed.shuffle
        return returnCards.shuffle
    }
    
    static func useCards(_ numCards : Int) -> [Card]? {
        if (numCards > cardsBeingPlayed.count) { return nil;}
        var indexes = RandomHelper.getRandoms(upperLimit: UInt32(cardsBeingPlayed.count), numberOfRandoms: UInt32(numCards))
        indexes = indexes.sorted(by: { $0 > $1 })
        var returnCards : [Card] = []
        for index in indexes {
            returnCards.append(cardsBeingPlayed[index])
        }
        
        return returnCards.shuffle
    }
    
    static func useCardsNotOnThisLevel(_ numCards: Int) -> [Card] {
        var indexes = RandomHelper.getRandoms(upperLimit: UInt32(cardsNotPlayedThisLevel.count), numberOfRandoms: UInt32(numCards))
        indexes = indexes.sorted(by: { $0 > $1 })
        var returnCards : [Card] = []
        for index in indexes {
            returnCards.append(cardsNotPlayedThisLevel.remove(at: index))
        }
        
        return returnCards.shuffle
    }
    
    static var anyCardsLeft : Bool {
        get {
            return !cardsNotUsed.isEmpty
        }
    }
    
    static var anyCardsPlayed : Bool {
        get {
            return !cardsBeingPlayed.isEmpty
        }
    }
    
    
    public static func newGame() {
        
        
        cardsNotUsed = CardData.getGameCards()
        cardsBeingPlayed = []
    }
    
    public enum PacketType {
        case Students
        case Mentors
        case StudentsAndMentors
    }
    
    
    
    
    
    
    
    
}

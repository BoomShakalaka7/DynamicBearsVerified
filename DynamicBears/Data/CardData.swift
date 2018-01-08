//
//  CardData.swift
//  DynamicBears
//
//  Created by Arthur Lazzaretti on 07/12/2017.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
import UIKit
public class CardData {
    
    private static var studentData : [Card] = makeCards("Students.bundle")
    
    
    //[Card(#imageLiteral(resourceName: "marco_fioretto"), "Marco", "Fioretto", "I like to smile"), Card(#imageLiteral(resourceName: "Jason Davis headshot"), "Jason", "Headshot", "Boh")];
    private static var mentorData : [Card] = makeCards("Mentors.bundle")
    
    //[Card(#imageLiteral(resourceName: "profile-Zeyad"), "Gianni", "Celeste", "So na vela stracciata"), Card(#imageLiteral(resourceName: "Unknown"), "Carlo", "Capponi", "Sciao beli")];
    private static var cardData : [Card] = studentData + mentorData;
    
    
    ///getCards, returns all cards in cardData
    public static func getGameCards(_ packetType : SessionController.PacketType) -> [Card] {
        var retData : [Card] = []
        if (packetType == SessionController.PacketType.Mentors) {
            retData = mentorData
        }
        else if (packetType == SessionController.PacketType.Students) {
            retData = studentData
        }
        else {
            retData = cardData
        }
        return retData
    }
    
    
    public static func getAllCards() -> [Card] {
        return cardData
    }
    
    public static func getMentorCards() -> [Card] {
        return mentorData
    }
    
    public static func getStudentCards() -> [Card] {
        return studentData
    }
    private static func makeCards(_ bundle: String) -> [Card] {
        var cards : [Card] = []
        var photoArr : [UIImage] = []
        var stringArr : [String] = []
        (photoArr, stringArr) = FileConnection.loadImages(bundleName: bundle)
//        let fileManager = FileManager.default;
//        let imagePath = Bundle.main.resourcePath! + "/images/" + folder;
//        let imageNames = try? fileManager.contentsOfDirectory(atPath: imagePath);
//        if (imageNames == nil) {return cards;}
        for i in 0...photoArr.count - 1 {
            let cardComponents = stringArr[i].components(separatedBy: "_")
            let description = cardComponents[2].components(separatedBy: ".")[0]
            let photo = photoArr[i]
            cards.append(Card(photo, cardComponents[0], cardComponents[1], description))
        }
        
        return cards
    }
    
    
    func setUpCard(card : Card, view : UIView) {
    }
    
    
    
    
    
    
    
    
}

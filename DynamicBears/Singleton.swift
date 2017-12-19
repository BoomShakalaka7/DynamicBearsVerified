//
//  Singleton.swift
//  DynamicBears
//
//  Created by Davide Maimone on 06/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

 class Singleton {
    static let shared = Singleton()

    var mentorsList : [Card] = []
    var studentsList : [Card] = []
    var cardsList: [Card] = []
    
//    timer 
    var seconds = 30
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false

//    var mentorCardListCompressed: [Card] = []
//    var studentCardListCompressed: [Card] = []
//    var cardListCompressed: [Card] = []
    
    func initialize() {

        mentorsList = makeCards("Mentors.bundle")
        studentsList = makeCards("Students.bundle")
        cardsList = mentorsList + studentsList
        
//        loadResizedArray()
    }
    
    func makeCards(_ bundle: String) -> [Card] {
        var cards : [Card] = []
        var photoArr : [UIImage] = []
        var stringArr : [String] = []
        (photoArr, stringArr) = FileConnection.loadImages(bundleName: bundle)
        //        let fileManager = FileManager.default;
        //        let imagePath = Bundle.main.resourcePath! + "/images/" + folder;
        //        let imageNames = try? fileManager.contentsOfDirectory(atPath: imagePath);
        //        if (imageNames == nil) {return cards;}
        for i in 0..<photoArr.count {
            let cardComponents = stringArr[i].components(separatedBy: "_")
            let description = cardComponents[2].components(separatedBy: ".")[0]
            let photo = photoArr[i]
            cards.append(Card(photo, cardComponents[0], cardComponents[1], description))
        }
        return cards
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
//        QuizViewController.updateTimerino(&seconds)
    }
    
    
//    func loadResizedArray() {
//        for i in 0..<studentsList.count {
//            studentCardListCompressed.append(cardsList[i])
//            studentCardListCompressed[i].photo = UIImage(data: studentsList[i].photo.jpeg(quality: .medium)!)!
//        }
//        for i in 0..<mentorsList.count {
//            mentorCardListCompressed.append(cardsList[i])
//            mentorCardListCompressed[i].photo = UIImage(data: mentorsList[i].photo.jpeg(quality: .medium)!)!
//        }
//        cardListCompressed = studentCardListCompressed + mentorCardListCompressed
//    }
}

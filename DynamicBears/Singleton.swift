//
//  Singleton.swift
//  DynamicBears
//
//  Created by Davide Maimone on 06/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

protocol TimerDelegate {
    func timerElapsed()
    func reset()
}

 class Singleton {
    static let shared = Singleton()

    var mentorsList : [Card] = []
    var studentsList : [Card] = []
    var cardsList: [Card] = []
    var delegate: TimerDelegate?
    
//    timer
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var isStarted = false
    public var seconds: Int = 30
    
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
}

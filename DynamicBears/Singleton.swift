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
        
        if isStarted == false {
            isStarted = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            isStarted = false
        }
        
    }
    
    @objc func updateTimer() {
        seconds -= 1
        if seconds == 0 {
            resetButtonTapped()
            delegate?.reset()
        } else {
            delegate?.timerElapsed();
        }
        
    }
    
    func resetButtonTapped() {
        timer.invalidate()
        seconds = 30
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

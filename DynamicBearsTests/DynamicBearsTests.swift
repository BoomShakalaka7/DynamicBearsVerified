//
//  DynamicBearsTests.swift
//  DynamicBearsTests
//
//  Created by Davide Maimone on 04/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import XCTest
@testable import DynamicBears

class DynamicBearsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPostExample() {
        
        XCTAssert(ServerConnection.post(
            script: ServerConnection.scriptPostScore(
                score: Score(userName: "ciro", score: 0, scoreType: 0))))
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testGetExample() {
        
        let scores : [Score] = ServerConnection.get( script:
            ServerConnection.scriptGet5HighScores)
        var i = 1
        for score in scores {
            print("\(i): \(score.score)")
            i += 1
        }
        XCTAssert(i > 0)
    }
    func testDecoding() {
        let json = """
[{"userName":"me","score":"55","scoreType":"0"},{"userName":"me","score":"55","scoreType":"0"},{"userName":"davide","score":"5","scoreType":"0"},{"userName":"davide123","score":"2","scoreType":"1"},{"userName":"davide3123","score":"2","scoreType":"1"}]
"""
        do {
            let scores = try JSONDecoder().decode([Score].self, from: json.data(using: .utf8)!)
            print(scores.count)
            
            XCTAssert(scores.count > 0)
        }
        
        catch {}
        
    }
    
    func testRandom(){
        
//        let x = CardController.getNewCard()
//        XCTAssert(x != nil)
//        let upperBound = 50
//        for _ in 1...10 {
//            let randNum = arc4random_uniform(UInt32(upperBound));
////            print(randNum);
//            XCTAssert(randNum < 50);
//        }
    }
    
    func testGetImageNames() {
        
        var URLS = ImagesHelper.getImageNames()
        
        XCTAssert(URLS != nil)
        
        
    }
    
    
    func testReadingWritingfile(){
//        FileConnection.saveUserName(user: "heya")
        
        print(FileConnection.loadUserName())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

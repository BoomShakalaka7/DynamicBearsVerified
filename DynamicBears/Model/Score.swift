//
//  Score.swift
//  DynamicBears
//
//  Created by Arthur Lazzaretti on 07/12/2017.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
public class Score : Decodable {

    
    var userName : String;
    var score : Int;
    var scoreType : Int;
    
    
    init(userName : String, score : Int, scoreType : Int) {
    self.userName = userName;
    self.score = score;
    self.scoreType = scoreType;
    }
    
    //init used to convert json to object
    public convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
        
        let userName: String = try container.decode(String.self, forKey: .userName) // extracting the data
        let score: Int = try Int(container.decode(String.self, forKey: .score))! // extracting the data
        let scoreType: Int = try Int(container.decode(String.self, forKey: .scoreType))!
        
        self.init(userName: userName, score: score, scoreType: scoreType) // initializing class
    }
    //this enum is also required to convert json to object, just because swift is stupid
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case userName = "userName"
        case score = "score"
        case scoreType = "scoreType"
    }
}



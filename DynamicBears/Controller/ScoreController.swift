//
//  ScoreController.swift
//  DynamicBears
//
//  Created by Arthur Lazzaretti on 10/12/2017.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
public class ScoreController {
    
    /// function to get top 5 game highscores
    /// returns an array with all 5 or less scores (depends on how many found)
    static func getTop5Scores() -> [Score] {
        return ServerConnection.get(script:
            ServerConnection.scriptGet5HighScores)
    }
    
    
    /// function to get a user's top 5 game highscores
    /// returns an array with all 5 or less scores (depends on how many found)
    static func getMyTop5Scores(userName : String) -> [Score] {

        return ServerConnection.get(script:
            ServerConnection.scriptGetMy5HighScores(user: userName))
    }
    
    
    public static func postScore(score : Score) -> Bool {
        
        return ServerConnection.post(script:
            ServerConnection.scriptPostScore(score: score))
        
        
    }
    
    static func isUserNameAvailable(userName: String) -> Bool {
        let myScores = getMyTop5Scores(userName: userName)
        return myScores.isEmpty
    }
    
}

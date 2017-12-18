//
//  ServerConnection.swift
//  DynamicBears
//
//  Created by Arthur Lazzaretti on 07/12/2017.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
public class ServerConnection {
    
    
    //TO DO: Change this to https????????
    static var serverURL : String = "https://dynamicbears6.altervista.org/";
    
    static var postFile : String = "post.php";
    static var getFile : String = "get.php";
    static var scriptGet5HighScores : String = "SELECT userName, score, scoreType FROM highScores ORDER BY score DESC LIMIT 5;";
    static func scriptGetMy5HighScores(user : String) -> (String) {
        return "SELECT (userName, score, scoreType) FROM highScores WHERE userName = '\(user)' ORDER BY score DESC LIMIT 5;";
    }
    static func scriptPostScore(score : Score) -> String {
        return """
        INSERT INTO highScores(userName, score, scoreType) VALUES('\(score.userName)', '\(score.score)', '\(score.scoreType)');
        """;
    }
    
    
    
    
    //SEE IF WE REALLY NEED JSON IF WE ARE ONLY SENDING ONE OBJECT TYPE TO THE SERVER..
    //MAYBE OBJECTS ONLY NEED TO BE DECODABLE NOT ENCODABLE / CODABLE
    
    
    /// function to post to server
    ///     takes in script used to post
    /// returns whether task was succesful or not
    static func post(script : String) -> Bool {
        var successful = false;
        let group = DispatchGroup(); // group used for debug in post, so that i can actually see post response, remove later
        group.enter();
        //put here select
        let request = NSMutableURLRequest(url: NSURL(string: serverURL + postFile)! as URL);
        request.httpMethod = "POST";
        let postString = "script=\(script)";
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))");
                group.leave();
                return;
            }
            print("response = \(String(describing: response))");
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue);
            print("responseString = \(String(describing: responseString))");
            successful = true;
            group.leave();
        }
        task.resume();
        group.wait();
        //for debug
        return successful;
    }
    
    
    
    /// function to get from server
    ///     takes in script used to get
    /// returns an array of scores for now, maybe later we change it to [Any] if we decide getting other stuff as well
    static func get(script : String) -> [Score] {
        let params = ["script" : script];
        
        let urlComp = NSURLComponents(string: serverURL + getFile)!;
        
        var items = [URLQueryItem]();
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value));
        }
        
        items = items.filter{!$0.name.isEmpty};
        
        if !items.isEmpty {
            urlComp.queryItems = items;
        }
        
        var urlRequest = URLRequest(url: urlComp.url!);
        urlRequest.httpMethod = "GET";
        let config = URLSessionConfiguration.default;
        let session = URLSession(configuration: config);
        
        
        var highScores : [Score] = [];
        let group = DispatchGroup(); //group again, but this one is necessary evne in release, we need to wait for get result to show scores
        group.enter();

        let task = session.dataTask(with: urlRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))");
            }
            else {
                print("response = \(String(describing: response))");
                
                
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!;
                
                let newString = responseString.substring(from: 5); ///5 because php returns 5 \n before json, its what i am getting for now, but i dont know why...
                print("responseString = \(String(describing: responseString))");
                do {
                    print("newString:\n" + newString);
                    // Decode data to object
                    
                    let jsonDecoder = JSONDecoder();
                    highScores = try jsonDecoder.decode([Score].self, from: newString.data(using: .utf8)!);
                    
                }
                catch {
                }
            }
            group.leave();

        }
        task.resume();
        group.wait();
        return highScores;
    }
    
    
}

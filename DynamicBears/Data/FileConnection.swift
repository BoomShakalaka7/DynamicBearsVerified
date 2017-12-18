//
//  FileConnection.swift
//  DynamicBears
//
//  Created by Marco Davide Fioretto on 11/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
import FileProvider
import UIKit

public class FileConnection {
    
    var imagesDirectoryPath: String!
    var images: [UIImage]!
    var titles: [String]!
    
    static let fileName = "file.txt" //this is the file. we will write to and read from it

    static var userName : String? = loadUserName()
    
    public static func loadUserName() -> String? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            //reading
            do {
                let user = try String(contentsOf: fileURL, encoding: .utf8)
                return user
            }
            catch {/* error handling here */}
        }
        return nil
    }
    
    
    public static func findPictureNames() -> [String]? {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            //reading
            do {
                let user = try String(contentsOf: fileURL, encoding: .utf8)
                return [user]
            }
            catch {/* error handling here */}
        }
        return nil
        
        
        
    }
    
    public static func saveUserName(user : String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            //writing
            do {
                try user.write(to: fileURL, atomically: false, encoding: .utf8)
                userName = user
            }
            catch {/* error handling here */}
        }
    }
    
    public static func loadImages(bundleName: String) -> ([UIImage], [String]){
        var images = [UIImage]()
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent(bundleName)
        let contents = try! fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
        var stringArr : [String] = []
        for item in contents
        {
            if let image = UIImage(named: item.lastPathComponent, in: Bundle(url: assetURL) , compatibleWith: nil) {
                images.append(image)
                stringArr.append(item.lastPathComponent)
            }
    
            print(item.lastPathComponent)
        }
        return (images, stringArr)
    }
}

func arrayForSearch () {
    
}

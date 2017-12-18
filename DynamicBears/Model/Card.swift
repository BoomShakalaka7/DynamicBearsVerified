//
//  Card.swift
//  DynamicBears
//
//  Created by Arthur Lazzaretti on 07/12/2017.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
import UIKit
public class Card {
    var photo : UIImage
    var name : String;
    var surname : String;
    var description : String;
    
    
    public init (_ photo : UIImage, _ name : String, _ surname : String, _ description : String) {
        self.photo = photo;
        self.name = name;
        self.surname = surname;
        self.description = description;
        
    }
    
    
    public func compare(_ cardName: String) -> Bool {
        let thisFullName = (self.name + " " + self.surname).lowercased()
        let otherFullName = cardName.lowercased()
        if (thisFullName.elementsEqual(otherFullName)) {
            return true
        }
        return false
    }
}


//
//  RandomHelper.swift
//  DynamicBears
//
//  Created by Arthur Lazzaretti on 11/12/2017.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

        import Foundation
        public class RandomHelper {
            
            
            ///returns numberOfRandoms different random numbers on range [0,upperLimit)
            public static func getRandoms(upperLimit: UInt32, numberOfRandoms: UInt32) -> [Int] {
                var uniqueNumbers = Set<Int>()
                while uniqueNumbers.count < numberOfRandoms {
                    uniqueNumbers.insert(Int(arc4random_uniform(upperLimit)))
                }
                return Array(uniqueNumbers)
            }
        }

        public extension Array {
            var shuffle:[Element] {
                var elements = self
                for index in 0..<elements.count {
                    let anotherIndex = Int(arc4random_uniform(UInt32(elements.count-index)))+index
                    if anotherIndex != index {
                        elements.swapAt(index, anotherIndex)
                    }
                }
                return elements
            }
        }

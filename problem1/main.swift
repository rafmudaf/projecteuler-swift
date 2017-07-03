//
//  main.swift
//  problem1
//
//  Created by Rafael M Mudafort on 7/3/17.
//  Copyright © 2017 RiffRaff. All rights reserved.
//

//If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
//Find the sum of all the multiples of 3 or 5 below 1000.

import Foundation

var sum = 0
for i in 1..<1000 {
    if euler.dividesEvenly(3, into: i) || euler.dividesEvenly(5, into: i) {
        sum += i
    }
}

print("The sum of all the multiple of 3 or 5 below 1000 is \(sum)")

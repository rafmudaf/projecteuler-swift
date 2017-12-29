//
//  main.swift
//  problem5
//
//  Created by Rafael M Mudafort on 12/29/17.
//  Copyright © 2017 RiffRaff. All rights reserved.
//

//  2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
//  What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

import Foundation

func isDivisibleByRange(i: Int, from: Int, to: Int) -> Bool {
    for j in from...to {
        if !euler.dividesEvenly(j, into: i) {
            return false
        }
    }
    return true
}

var i = 20
while true {
    if (isDivisibleByRange(i: i, from: 11, to: 20) ) {
        print("\(i)\n")
        break
    }
    i += 1
}


//
//  main.swift
//  problem6
//
//  Created by Rafael M Mudafort on 12/29/17.
//  Copyright © 2017 RiffRaff. All rights reserved.
//

/*
 The sum of the squares of the first ten natural numbers is,
 
 1^2 + 2^2 + ... + 10^2 = 385
 The square of the sum of the first ten natural numbers is,
 
 (1 + 2 + ... + 10)^2 = 55^2 = 3025
 Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
 
 Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
 */

import Foundation

var nmax: UInt64 = 100
var sumsquares: UInt64 = 0
var sum: UInt64 = 0

for i in 0...nmax {
    sumsquares += UInt64(Int(pow(Double(i),2)))
    sum += i
}

print("sum of squares - \(sumsquares)")
print("square of sums - \(pow(Double(sum),2))")
print("sum square diff - \(pow(Double(sum),2) - Double(sumsquares))")

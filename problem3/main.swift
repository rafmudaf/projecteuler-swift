//
//  main.swift
//  problem3
//
//  Created by Rafael M Mudafort on 7/3/17.
//  Copyright © 2017 RiffRaff. All rights reserved.
//

//The prime factors of 13195 are 5, 7, 13 and 29.
//What is the largest prime factor of the number 600851475143 ?

import Foundation

var startingval = 600851475143
var currentval = startingval
var divisor = 2

// after sqrt(n), the factors are redundant. use this as a starting point...
var maxDivisor = Int(sqrt(Double(startingval)))

while divisor <= maxDivisor {
    // if the divisor reaches the max, this is a prime number
    if divisor == maxDivisor && !euler.dividesEvenly(divisor, into: currentval) {
        divisor = startingval
        break
    }
    
    // find the smallest prime number that is a factor of the current value
    while !euler.dividesEvenly(divisor, into: currentval) || !euler.isa(prime: divisor) {
        divisor += 1
    }
    
    // calculate the division of the current value and its smallest factor
    var result = currentval/divisor
    
    print("\(currentval) / \(divisor) = \(result)")
    currentval = result
    
    if result == 1 {
        break
    }
}

print("the largest prime factor of \(startingval) is \(divisor)")

//
//  main.swift
//  problem4
//
//  Created by Rafael M Mudafort on 7/5/17.
//  Copyright © 2017 RiffRaff. All rights reserved.
//

//A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
//Find the largest palindrome made from the product of two 3-digit numbers.

import Foundation

var highestPalindrome = 0
var highestI = 0
var highestJ = 0
let imax = 999
let imin = 0
let jmax = 999
var jmin = 0
    
// loop over all i's
iloop: for i in stride(from: imax, to: imin, by: -1) {
    
    // when i becomes less than the minimum j, any future calculations are redundant
    if i < jmin {
        break iloop
    }
    
    // loop to the j that gave the previous palindrome
    jloop: for j in stride(from: jmax, to: jmin, by: -1) {
        if euler.isa(palindrome: i*j) && i*j > highestPalindrome {
            // store in memory the palindrome, i, and j
            highestPalindrome = i*j
            highestI = i
            highestJ = j
            
            // theres no need to calculate numbers lower than this j
            // since the resulting palindrome will definitely be less
            jmin = j
            break jloop
        }
    }
}

print("the highest palindrome results from \(highestI) x  \(highestJ) = \(highestPalindrome)")

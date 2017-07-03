//
//  euler.swift
//  projecteuler_swift
//
//  Created by Rafael M Mudafort on 7/3/17.
//  Copyright © 2017 RiffRaff. All rights reserved.
//

import Foundation

class euler {
    class func dividesEvenly(_ a: Int, into b: Int) -> Bool {
        return b % a == 0
    }
    
    class func isa(prime n: Int) -> Bool {
        //References:
        //https://en.wikipedia.org/wiki/Primality_test
        //https://www.mathsisfun.com/numbers/prime-factorization-tool.html
        
        if n <= 1 {
            return false
        } else if n <= 3 {
            return true
        } else if dividesEvenly(2, into: n) || dividesEvenly(3, into: n) {
            return false
        }
        
        var i = 1
        var testvalue = 0
        let root = Int(sqrt(Double(n)))
        while testvalue < root {
            testvalue = 6*i-1
            if n == testvalue {
                return true
            } else if dividesEvenly(testvalue, into: n) {
                return false
            }
            
            testvalue = 6*i+1
            if n == testvalue {
                return true
            } else if dividesEvenly(testvalue, into: n) {
                return false
            }
            
            i += 1
        }
        
        return true
    }
}

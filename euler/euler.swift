//
//  euler.swift
//  projecteuler_swift
//
//  Created by Rafael M Mudafort on 7/3/17.
//  Copyright © 2017 RiffRaff. All rights reserved.
//

import Foundation

class Euler {
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
    
    class func isa(palindrome n: Int) -> Bool {
        let palString = String(n)
        let palLength = palString.count
        let halfLength = palLength/2
        
        var index = palString.index(palString.startIndex, offsetBy: halfLength)
        let front = String(palString[..<index])
        index = palString.index(palString.endIndex, offsetBy: -1*halfLength)
        let back = String(palString[..<index])
        
        for i in 0..<halfLength {
            if front[i] != back[halfLength-1-i] {
                return false
            }
        }
        return true
    }
}

extension String {
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(from: Int) -> String {
        return self[min(from, count) ..< count]
    }
    
    func substring(to: Int) -> String {
        return self[0 ..< max(0, to)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

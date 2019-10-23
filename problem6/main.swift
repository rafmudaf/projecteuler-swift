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
import MetalKit
    
// problem configuration
var nmax: UInt32 = 100
var sumsquares: UInt32 = 0
var sum: UInt32 = 0
var inputarray: [UInt32] = []
for i in 1...nmax {
    inputarray.append(UInt32(i))
}
var resultarray = [UInt32](repeating: UInt32(0.0), count: inputarray.count)

let metalInstance = try MetalInstance(kernelName: "squareValueShader")

metalInstance.bindToBuffer(inputArray: inputarray, outputArray: resultarray)
metalInstance.configurePipeline(threadGroupCountWidth: 10, threadGroupCountHeight: 1, threadGroupCountDepth: 1, threadGroupsWidth: 10, threadGroupsHeight: 1, threadGroupsDepth: 1)
metalInstance.execute()

// put the result data into a Swift array
var data = NSData(bytesNoCopy: metalInstance.outputVectorBuffer!.contents(), length: inputarray.count * MemoryLayout.size(ofValue: inputarray[0]), freeWhenDone: false)
data.getBytes(&resultarray, length: inputarray.count * MemoryLayout.size(ofValue: inputarray[0]))

// compute the sum
sum = inputarray.reduce(0, { x, y in
    x + y
})

// compute the sum of squares
sumsquares = resultarray.reduce(0, { x, y in
    x + y
})

// This is the cpu implementation:
//var nmax: UInt64 = 100
//var sumsquares: UInt64 = 0
//var sum: UInt64 = 0
//sum = 0
//sumsquares = 0
//for i in 0...nmax {
//    sumsquares += UInt32(Int(pow(Double(i),2)))
//    sum += i
//}

// print results
print("sum of squares - \(sumsquares)")
print("square of sums - \(pow(Double(sum),2))")
print("sum square diff - \(pow(Double(sum),2) - Double(sumsquares))")


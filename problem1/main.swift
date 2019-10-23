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

var inputArray = Array(repeating: UInt32(0), count: 1000)
var resultArray = Array(repeating: UInt32(0), count: inputArray.count)

// The resulting array is length 1000 and the threads are 100 x 10 because
// they are 0-based. Since the question asks for less than 1000, we stop at
// 999. However, the CPU implementation starts at 1 since we know that 0 is
// not a multiple of 3 or 5 and if it was it would not contribute to the sum.

let metalInstance = try MetalInstance(kernelName: "naturalMultiples")
metalInstance.bindToBuffer(inputArray: inputArray, outputArray: resultArray)
metalInstance.configurePipeline(
    threadGroupCountWidth: 100,
    threadGroupCountHeight: 1,
    threadGroupCountDepth: 1,
    threadGroupsWidth: 10,
    threadGroupsHeight: 1,
    threadGroupsDepth: 1
)
metalInstance.execute()

// put the result data into a Swift array
var data = NSData(bytesNoCopy: metalInstance.outputVectorBuffer!.contents(), length: inputArray.count * MemoryLayout.size(ofValue: inputArray[0]), freeWhenDone: false)
data.getBytes(&resultArray, length: inputArray.count * MemoryLayout.size(ofValue: inputArray[0]))

// compute the sum
let sum = resultArray.reduce(UInt32(0), { x, y in
    x + y
})

print("The sum of all the multiple of 3 or 5 below 1000 is \(sum)")

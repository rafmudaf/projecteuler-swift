//
//  MetalInstance.swift
//  projecteuler_swift
//
//  Created by Mudafort, Rafael on 10/20/19.
//  Copyright © 2019 RiffRaff. All rights reserved.
//

import MetalKit

enum MetalInstanceError: Error {
    case deviceError
    case defaultLibraryError
    case kernelFunctionError
    case pipelineStateError
    case commandQueueError
    case commandBufferError
    case commandEncoderError
}

class MetalInstance {
    
    var device: MTLDevice
    var pipelineState: MTLComputePipelineState
    var commandBuffer: MTLCommandBuffer
    var commandEncoder: MTLComputeCommandEncoder
    var inputArray: [UInt32]
    var outputArray: [UInt32]
    var outputVectorBuffer: MTLBuffer?

    init(kernelName: String, inputArray: [UInt32], outputArray: [UInt32]) throws {
        // Configure the Metal GPU device
        guard let device = MTLCreateSystemDefaultDevice() else {
            throw MetalInstanceError.deviceError
        }
        self.device = device

        guard let defaultLibrary = device.makeDefaultLibrary() else {
            throw MetalInstanceError.defaultLibraryError
        }

        guard let kernelFunction = defaultLibrary.makeFunction(name: kernelName) else {
            throw MetalInstanceError.kernelFunctionError
        }

        guard let pipelineState = try? device.makeComputePipelineState(function: kernelFunction) else {
            throw MetalInstanceError.pipelineStateError
        }
        self.pipelineState = pipelineState

        guard let commandQueue = device.makeCommandQueue() else {
            throw MetalInstanceError.commandQueueError
        }

        guard let commandBuffer = commandQueue.makeCommandBuffer() else {
            throw MetalInstanceError.commandBufferError
        }
        self.commandBuffer = commandBuffer

        guard let commandEncoder = commandBuffer.makeComputeCommandEncoder() else {
            throw MetalInstanceError.commandEncoderError
        }
        self.commandEncoder = commandEncoder
        
        // Add the input array to the Metal buffer
        self.inputArray = inputArray
        let valueByteLength = self.inputArray.count * MemoryLayout.size(ofValue: self.inputArray[0])
        let inputVectorBuffer = self.device.makeBuffer(
            bytes: inputArray,
            length: valueByteLength,
            options: .storageModeShared
        )
        self.commandEncoder.setBuffer(inputVectorBuffer, offset: 0, index: 0)
        
        // Add the output array to the Metal buffer
        self.outputArray = outputArray
        self.outputVectorBuffer = self.device.makeBuffer(
            bytes: outputArray,
            length: valueByteLength,
            options: .storageModeShared
        )
        self.commandEncoder.setBuffer(self.outputVectorBuffer, offset: 0, index: 1)
    }
        
    func configurePipeline(threadGroupCountWidth: Int,
                           threadGroupCountHeight: Int,
                           threadGroupCountDepth: Int,
                           threadGroupsWidth: Int,
                           threadGroupsHeight: Int,
                           threadGroupsDepth: Int) {
        // configure the compute pipeline
        self.commandEncoder.setComputePipelineState(self.pipelineState)
        let threadGroupCount = MTLSizeMake(
            threadGroupCountWidth,
            threadGroupCountHeight,
            threadGroupCountDepth
        )
        let threadGroups = MTLSizeMake(
            threadGroupsWidth,
            threadGroupsHeight,
            threadGroupsDepth
        )

        // commit the commands
        self.commandEncoder.dispatchThreadgroups(
            threadGroups,
            threadsPerThreadgroup: threadGroupCount)
        self.commandEncoder.endEncoding()
    }

    func execute() {
        self.commandBuffer.commit()
        self.commandBuffer.waitUntilCompleted()
    }

    func dataAsArray() -> NSData? {
        
        guard let outputVectorBuffer = self.outputVectorBuffer else {
            return nil
        }

        return NSData(
            bytesNoCopy: outputVectorBuffer.contents(),
            length: self.inputArray.count * MemoryLayout.size(ofValue: self.inputArray[0]),
            freeWhenDone: false
        )
    }
}

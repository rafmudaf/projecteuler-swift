//
//  shaders.metal
//  problem6
//
//  Created by Rafael M Mudafort on 12/29/17.
//  Copyright © 2017 RiffRaff. All rights reserved.
//


#include <metal_stdlib>

using namespace metal;

kernel void squareValueShader(const device uint *inputValues [[ buffer(0) ]],
                                   device uint *outputValues [[ buffer(1) ]],
                                   uint id [[thread_position_in_grid]])
{
    outputValues[id] = inputValues[id] * inputValues[id];
}

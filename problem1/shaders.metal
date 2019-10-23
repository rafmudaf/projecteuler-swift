//
//  shaders.metal
//  problem1
//
//  Created by Mudafort, Rafael on 10/22/19.
//  Copyright © 2019 RiffRaff. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void naturalMultiples(const device uint *inputValues [[ buffer(0) ]],
                                   device uint *outputValues [[ buffer(1) ]],
                                   uint id [[thread_position_in_grid]])
{
    if (id % 3 == 0 || id % 5 == 0) {
        outputValues[id] = id;
    }
}

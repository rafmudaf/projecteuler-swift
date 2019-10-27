#  Project Euler Problem 1

The original problem can be found [here](https://projecteuler.net/problem=1).

### Problem Statement

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

### Solution

Its immediately clear that this is a fizz-buzz style problem which can be solved by a simple
divisibility test. I initially wrote a function to determine whether a number is a multiple of
another and then use it in a simple logic gate to fill an array. Finally, the array of values that are
multiple of 3 or 5 is summed.

```
// In class Euler
class func dividesEvenly(_ a: Int, into b: Int) -> Bool {
    return b % a == 0
}

func sumNaturalMultiples() -> Int {
    var sum = 0
    for i in 1..<1000 {
        if Euler.dividesEvenly(3, into: i) || Euler.dividesEvenly(5, into: i) {
            sum += i
        }
    }
    return sum
}

// compute the sum
let sum = resultArray.reduce(UInt32(0), { x, y in
    x + y
})

```

Following the straightforward CPU implementation, I moved this to the GPU with this shader
kernel:

```
kernel void naturalMultiples(const device uint *inputValues [[ buffer(0) ]],
                                   device uint *outputValues [[ buffer(1) ]],
                                   uint id [[thread_position_in_grid]])
{
    if (id % 3 == 0 || id % 5 == 0) {
        outputValues[id] = id;
    }
}
```

### Conclusion

This problem was not super challenging, but it served as a great reminder on how to navigate
Swift and work through a problem. Further, it helped me establish some tooling for running on
the GPU with Metal.

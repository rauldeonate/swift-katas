// Given an array of ones and zeroes, convert the equivalent binary value to an integer.
// Eg: [0, 0, 0, 1] is treated as 0001 which is the binary representation of 1.

import XCTest

func convertValue(fromBinaryArray binaryArray: [Int]) -> Int {
    return binaryArray
        .reversed()
        .enumerated()
        .filter { $1 == 1 }
        .reduce(0, { total, binaryElement in
            let position = binaryElement.offset
            let power = powerInt(base: 2, exp: UInt(position))
            return total + power
        })
}

// Power function own implementation
func powerInt(base: Int, exp: UInt) -> Int {
    guard exp != 0 else { return 1 }
    guard exp != 1 else { return base }
    var value = base
    var remainingExp = exp
    while remainingExp >= 2 {
        value = value * base
        remainingExp -= 1
    }
    return value
}

XCTAssertEqual(powerInt(base: 2, exp: 2), 4)
XCTAssertEqual(powerInt(base: 6, exp: 8), 1679616)
XCTAssertEqual(powerInt(base: -6, exp: 3), -216)

XCTAssertEqual(convertValue(fromBinaryArray: [1, 1, 1, 1]), 15)
XCTAssertEqual(convertValue(fromBinaryArray: [1, 0, 1, 1, 1, 1]), 47)

//Given an array of ones and zeroes, convert the equivalent binary value to an integer.
//Eg: [0, 0, 0, 1] is treated as 0001 which is the binary representation of 1.

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

// Own implementation for the power function
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

convertValue(fromBinaryArray: [1, 1, 1, 1])
convertValue(fromBinaryArray: [1, 0, 1, 1, 1, 1])

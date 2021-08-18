/*
 Given a non-empty array of decimal digits representing a non-negative integer, increment one to the integer.

 The digits are stored such that the most significant digit is at the head of the list, and each element in the array contains a single digit.

 You may assume the integer does not contain any leading zero, except the number 0 itself.

 Example 1:
 Input: digits = [1,2,3]
 Output: [1,2,4]
 Explanation: The array represents the integer 123.

 Example 2:
 Input: digits = [4,3,2,1]
 Output: [4,3,2,2]
 Explanation: The array represents the integer 4321.

 Example 3:
 Input: digits = [0]
 Output: [1]
 */

import XCTest

func plusOne(_ digits: [Int]) -> [Int] {
    guard digits.count > 0 else { return digits }
    guard digits[0] != 0 else { return [1] }

    var mutableDigits = digits
    var index = digits.count - 1
    while mutableDigits[index] == 9 && index >= 0 {
        mutableDigits[index] = 0
        if index > 0 {
            index -= 1
        }
    }
    if index == 0 && mutableDigits[index] == 0 {
        mutableDigits.insert(1, at: 0)
    } else {
        mutableDigits[index] += 1
    }
    return mutableDigits
}

class TestCase: XCTestCase {
    func testMinorDigitLessThanNine() {
        XCTAssertEqual(plusOne([1, 2, 3]), [1, 2, 4])
    }

    func testMinorDigitEqualsNine() {
        XCTAssertEqual(plusOne([1, 2, 9]), [1, 3, 0])
    }

    func testAllDigitsEqualsNine() {
        XCTAssertEqual(plusOne([9, 9, 9]), [1, 0, 0, 0])
    }

    func testEmptyInput() {
        XCTAssertEqual(plusOne([]), [])
    }

    func testZero() {
        XCTAssertEqual(
            plusOne([0]), [1])
    }

    func testOne() {
        XCTAssertEqual(
            plusOne([1]), [2])
    }
}

TestCase.defaultTestSuite.run()

import XCTest

/*
We define a harmonious array as an array where the difference between its maximum value and its minimum value is exactly 1.

Given an integer array nums, return the length of its longest harmonious subsequence among all its possible subsequences.

A subsequence of array is a sequence that can be derived from the array by deleting some or no elements without changing the order of the remaining elements.

 Input: nums = [1,3,2,2,5,2,3,7]
 Output: 5
 Explanation: The longest harmonious subsequence is [3,2,2,2,3].

 Input: nums = [1,2,3,4]
 Output: 2

 Input: nums = [1,1,1,1]
 Output: 0
 */

func findLHS(_ nums: [Int]) -> Int {
    var dictionary = [Int: Int]()
    var result = 0

    for num in nums {
        if let _ = dictionary[num] {
            dictionary[num] = dictionary[num]! + 1
        } else {
            dictionary[num] = 1
        }

        if dictionary[num-1] != nil {
            if dictionary[num]! + dictionary[num-1]! > result {
                result = dictionary[num]! + dictionary[num-1]!
            }
        }
        if dictionary[num+1] != nil {
            if dictionary[num]! + dictionary[num+1]! > result {
                result = dictionary[num]! + dictionary[num+1]!
            }
        }
    }

    return result
}

class TestCase: XCTestCase {

    func testSuccessShort() {
        XCTAssertEqual(findLHS([1,2,3,4]), 2)
    }

    func testSuccessLong() {
        XCTAssertEqual(findLHS([1,3,2,2,5,2,3,7]), 5)
    }

    func testSuccessNegativeNumbers() {
        XCTAssertEqual(findLHS([-1, -2, 3]), 2)
    }

    func testNoSequenceSameNumber() {
        XCTAssertEqual(findLHS([1,1,1,1]), 0)
    }

    func testNoSequenceEmpty() {
        XCTAssertEqual(findLHS([]), 0)
    }

    func testNoSequenceOneNumber() {
        XCTAssertEqual(findLHS([1]), 0)
    }
}

TestCase.defaultTestSuite.run()

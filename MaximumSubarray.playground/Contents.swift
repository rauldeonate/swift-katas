/*
 Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

A subarray is a contiguous part of an array.

 Example 1:
 Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.

 Example 2:
 Input: nums = [1]
 Output: 1

 Example 3:
 Input: nums = [5,4,-1,7,8]
 Output: 23

 Constraints:
     1 <= nums.length <= 3 * 104
     -105 <= nums[i] <= 105

 Follow up: If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.

 */

import XCTest

func maxSubArray(_ nums: [Int]) -> Int {
    if nums.isEmpty {
        return 0
    }

    var sum = nums[0]
    var result = nums[0]

    for i in 1..<nums.count {
        sum += nums[i]
        if nums[i] > sum {
            sum = nums[i]
        }
        if sum > result {
            result = sum
        }
    }
    return result
}

class TestCase: XCTestCase {
    func testSubarray() {
        XCTAssertEqual(
            maxSubArray([-2,1,-3,4,-1,2,1,-5,4]), 6)
    }

    func testWholeArray() {
        XCTAssertEqual(
            maxSubArray([5,4,-1,7,8]), 23)
    }

    func testSubarrayAtEnd() {
        XCTAssertEqual(
            maxSubArray([1,-5,1,1]), 2)
    }

    func testOneElement() {
        XCTAssertEqual(
            maxSubArray([1]), 1)
    }

    func testEmpty() {
        XCTAssertEqual(
            maxSubArray([]), 0)
    }

    func testAllNegative() {
        XCTAssertEqual(
            maxSubArray([-3, -4, -2]), -2)
    }
}

TestCase.defaultTestSuite.run()

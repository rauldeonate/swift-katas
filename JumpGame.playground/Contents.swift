/*
 You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.

 Return true if you can reach the last index, or false otherwise.

 Example 1:
 Input: nums = [2,3,1,1,4]
 Output: true
 Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.

 Example 2:

 Input: nums = [3,2,1,0,4]
 Output: false
 Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.

 Constraints:
     1 <= nums.length <= 104
     0 <= nums[i] <= 105
 */

import XCTest

func canJump(_ nums: [Int]) -> Bool {
    if nums.count == 0 { return false }
    if nums.count == 1 { return true }
    if nums.first == 0 {
        return false
    }
    var jumpValue = 0
    for i in stride(from: 0, through: nums.count - 2, by: 1) {
        jumpValue -= 1
        if nums[i] > jumpValue {
            jumpValue = nums[i]
        }
        if jumpValue <= 0 {
            return false
        }
    }
    return jumpValue >= 0
}

class TestCase: XCTestCase {
    func testReachableNoExtra() {
        XCTAssertEqual(canJump([2,3,1,1,4]), true)
    }

    func testReachableExtra() {
        XCTAssertEqual(canJump([2,4,3,1,4]), true)
    }

    func testUnreachable() {
        XCTAssertEqual(canJump([3,2,1,0,4]), false)
    }

    func testUnreachableFromStart() {
        XCTAssertEqual(canJump([0,2,3]), false)
    }

    func testNoJumpValueMiddle() {
        XCTAssertEqual(canJump([1,0,1,0]), false)
    }

    func testEmpty() {
        XCTAssertEqual(canJump([]), false)
    }

    func testZero() {
        XCTAssertEqual(canJump([0]), true)
    }

    func testOne() {
        XCTAssertEqual(canJump([1]), true)
    }
}

TestCase.defaultTestSuite.run()

/*
 There is an integer array nums sorted in ascending order (with distinct values).

 Prior to being passed to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].

 Given the array nums after the rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.

 You must write an algorithm with O(log n) runtime complexity.

 Example 1:
 Input: nums = [4,5,6,7,0,1,2], target = 0
 Output: 4

 Example 2:
 Input: nums = [4,5,6,7,0,1,2], target = 3
 Output: -1

 Example 3:
 Input: nums = [1], target = 0
 Output: -1

 Constraints:
     1 <= nums.length <= 5000
     -104 <= nums[i] <= 104
     All values of nums are unique.
     nums is guaranteed to be rotated at some pivot.
     -104 <= target <= 104
 */

import XCTest

func search(_ nums: [Int], _ target: Int) -> Int {
    var hi = nums.count - 1
    var lo = 0

    while lo <= hi {
        let mid = (hi + lo) / 2

        if nums[mid] == target {
            return mid
        }

        if nums[mid] >= nums[lo] {
            if target >= nums[lo] && target < nums[mid] {
                hi = mid - 1
            } else {
                lo = mid + 1
            }
        } else {
            if target > nums[mid] && target <= nums[hi] {
                lo = mid + 1
            } else {
                hi = mid - 1
            }
        }
    }

    return -1
}

class TestCase: XCTestCase {
    func testPivotHigherMid() {
        XCTAssertEqual(
            search([4,5,6,7,0,1,2], 0),
            4
        )
    }

    func testPivotLowerMid() {
        XCTAssertEqual(
            search([6,7,1,2,3,4], 1),
            2
        )
    }

    func testUnexistingPivot() {
        XCTAssertEqual(
            search([6,7,1,2,3,4], 5),
            -1
        )
    }


    func testEmpty() {
        XCTAssertEqual(
            search([], 0),
            -1
        )
    }
}

TestCase.defaultTestSuite.run()

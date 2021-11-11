/*
 Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

 You must write an algorithm with O(log n) runtime complexity.

 Example 1:

 Input: nums = [1,3,5,6], target = 5
 Output: 2

 Example 2:

 Input: nums = [1,3,5,6], target = 2
 Output: 1

 Example 3:

 Input: nums = [1,3,5,6], target = 7
 Output: 4

 Example 4:

 Input: nums = [1,3,5,6], target = 0
 Output: 0

 Example 5:

 Input: nums = [1], target = 0
 Output: 0

 Constraints:

     1 <= nums.length <= 104
     -104 <= nums[i] <= 104
     nums contains distinct values sorted in ascending order.
     -104 <= target <= 104
 */

import XCTest

class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var end = nums.count - 1
        while left <= end {
            let mid = left + (end - left) / 2
            if nums[mid] < target {
                left = mid + 1
            } else {
                end = mid - 1
            }
        }
        return left
    }
}

class RecursiveSolution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        return binarySearch(nums, target, 0..<nums.count)
    }

    func binarySearch(_ nums: [Int], _ target: Int, _ range: Range<Int>) -> Int{
        let lowerBound = Int(range.lowerBound)
        let upperBound = Int(range.upperBound)

        guard lowerBound != upperBound else{
            return lowerBound
        }

        let mid = (upperBound + lowerBound) / 2

        if nums[mid] == target {
            return mid
        } else if nums[mid] < target{
            return binarySearch(nums, target, mid+1..<nums.count)
        } else{
            return binarySearch(nums, target, lowerBound..<mid)
        }
    }
}

class TestCase: XCTestCase {

    private let sol = Solution()
    private let recursiveSol = RecursiveSolution()

    func testEqualsElement() {
        XCTAssertEqual(sol.searchInsert([1,3,5,6], 5), 2)
    }

    func testMiddleInsert() {
        XCTAssertEqual(sol.searchInsert([1,3,5,6], 2), 1)
    }

    func testEndInsert() {
        XCTAssertEqual(sol.searchInsert([1,3,5,6], 7), 4)
    }

    func testStartInsert() {
        XCTAssertEqual(sol.searchInsert([1,3,5,6], 0), 0)
    }

    func testOneElementInput() {
        XCTAssertEqual(sol.searchInsert([1], 0), 0)
    }

    func testEqualsElementRecursiveSolution() {
        XCTAssertEqual(recursiveSol.searchInsert([1,3,5,6], 5), 2)
    }

    func testMiddleInsertRecursiveSolution() {
        XCTAssertEqual(recursiveSol.searchInsert([1,3,5,6], 2), 1)
    }

    func testEndInsertRecursiveSolution() {
        XCTAssertEqual(recursiveSol.searchInsert([1,3,5,6], 7), 4)
    }

    func testStartInsertRecursiveSolution() {
        XCTAssertEqual(recursiveSol.searchInsert([1,3,5,6], 0), 0)
    }

    func testOneElementInputRecursiveSolution() {
        XCTAssertEqual(recursiveSol.searchInsert([1], 0), 0)
    }
}

TestCase.defaultTestSuite.run()

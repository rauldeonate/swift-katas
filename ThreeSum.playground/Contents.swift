/*
 Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

 Notice that the solution set must not contain duplicate triplets.

 Example 1:
 Input: nums = [-1,0,1,2,-1,-4]
 Output: [[-1,-1,2],[-1,0,1]]

 Example 2:
 Input: nums = []
 Output: []

 Example 3:
 Input: nums = [0]
 Output: []

 Constraints:

     0 <= nums.length <= 3000
     -105 <= nums[i] <= 105
 */

import XCTest

func threeSum(_ nums: [Int]) -> [[Int]] {
    guard nums.count >= 3 else { return [[Int]]() }
    let sortedNums = nums.sorted()
    var result = [[Int]]()
    for i in 0..<sortedNums.count {
        // Don't allow `i` to point to same element
        if i != 0, sortedNums[i] == sortedNums[i-1] { continue }
        var j = i + 1
        var k = sortedNums.count - 1
        while j < k {
            let sum = sortedNums[i] + sortedNums[j] + sortedNums[k]
            if sum == 0 {
                result.append([sortedNums[i], sortedNums[j], sortedNums[k]])
                j += 1
                // Don't allow `j` to point to same element
                while j < k, sortedNums[j] == sortedNums[j-1] {
                    j += 1
                }
            } else if sum < 0 {
                j += 1
            } else {
                k -= 1
            }
        }
    }
    return result
}

class TestCase: XCTestCase {
    func testWideToEnd() {
        XCTAssertEqual(threeSum([-1,0,1,2,-1,-4]), [[-1,-1,2],[-1,0,1]])
    }

    func testZeros() {
        XCTAssertEqual(threeSum([0, 0, 0]), [[0, 0, 0]])
    }
}

TestCase.defaultTestSuite.run()

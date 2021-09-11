/*
 Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

 Example 1:
 Input: nums = [1,2,3]
 Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

 Example 2:
 Input: nums = [0,1]
 Output: [[0,1],[1,0]]

 Example 3:
 Input: nums = [1]
 Output: [[1]]

 Constraints:
     1 <= nums.length <= 6
     -10 <= nums[i] <= 10
     All the integers of nums are unique.
 */

import XCTest

func permute(_ nums: [Int]) -> [[Int]] {
    guard nums.count > 0 else { return [[]] }
    var result: [[Int]] = []
    result.append([nums[0]])

    for num in 1..<nums.count {
        var newElements: [[Int]] = []
        for element in result {
            var i = 0
            while i <= element.count {
                var newElement = element
                newElement.insert(nums[num], at: i)
                newElements.append(newElement)
                i += 1
            }
        }
        result = newElements
    }

    return result
}

class TestCase: XCTestCase {
    func testThree() {
        let result = permute([1,2,3])
        let expectedResult = [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
        XCTAssertEqual(
            Set(result), Set(expectedResult)
        )
    }

    func testOne() {
        let result = permute([1])
        let expectedResult = [[1]]
        XCTAssertEqual(
            Set(result), Set(expectedResult)
        )
    }

    func testZero() {
        XCTAssertEqual(
            permute([]), [[]]
        )
    }
}

TestCase.defaultTestSuite.run()

 /*
  Given an integer array nums of unique elements, return all possible subsets (the power set).

  The solution set must not contain duplicate subsets. Return the solution in any order.

  Example 1:
  Input: nums = [1,2,3]
  Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]

  Example 2:
  Input: nums = [0]
  Output: [[],[0]]

  Constraints:
      1 <= nums.length <= 10
      -10 <= nums[i] <= 10
      All the numbers of nums are unique.
  */

import XCTest

func subsets(_ nums: [Int]) -> [[Int]] {
    var subsets: [[Int]] = [[]]

    for num in nums {
        for subset in subsets {
            var newSubset = subset
            newSubset.append(num)
            subsets.append(newSubset)
        }
    }

    return subsets
}

class TestCase: XCTestCase {
    func testDefault() {
        XCTAssertEqual(subsets([1,2,3]), [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]])
    }

    func testZero() {
        XCTAssertEqual(subsets([0]), [[],[0]])
    }

    func testEmpty() {
        XCTAssertEqual(subsets([]), [[]])
    }
}

TestCase.defaultTestSuite.run()

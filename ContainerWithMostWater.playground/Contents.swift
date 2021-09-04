/*
 Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of the line i is at (i, ai) and (i, 0). Find two lines, which, together with the x-axis forms a container, such that the container contains the most water.

 Notice that you may not slant the container.

 Example 1:
 Input: height = [1,8,6,2,5,4,8,3,7]
 Output: 49
 Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.

 Example 2:
 Input: height = [1,1]
 Output: 1

 Example 3:
 Input: height = [4,3,2,1,4]
 Output: 16

 Example 4:
 Input: height = [1,2,1]
 Output: 2

 Constraints:
     n == height.length
     2 <= n <= 105
     0 <= height[i] <= 104
 */

import XCTest

func maxArea(_ height: [Int]) -> Int {
    guard height.count > 1 else { return 0 }
    guard height.count > 2 else { return min(height[0], height[1]) }

    var maxArea = 0
    var i = 0
    var j = height.count - 1
    while i < j {
        let newArea = min(height[i],height[j]) * (j - i)
        maxArea = max(maxArea, newArea)
        if height[i] < height[j] {
            i += 1
        } else {
            j -= 1
        }
    }
    return maxArea
}

class TestCase: XCTestCase {
    func testWideToEnd() {
        XCTAssertEqual(maxArea([1,8,6,2,5,4,8,3,7]), 49)
    }

    func testStartToEnd() {
        XCTAssertEqual(maxArea([4,3,2,1,4]), 16)
    }

    func testOneOne() {
        XCTAssertEqual(maxArea([1,1]), 1)
    }

    func testOneTwoOne() {
        XCTAssertEqual(maxArea([1,2,1]), 2)
    }

    func testOneTwoFourTree() {
        XCTAssertEqual(maxArea([1,2,4,3]), 4)
    }
}

TestCase.defaultTestSuite.run()

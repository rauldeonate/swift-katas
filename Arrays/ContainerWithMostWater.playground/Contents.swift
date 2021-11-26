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

final class Solution {
    func maxArea(_ height: [Int]) -> Int {
        /*
         The intuition behind this approach is that the area formed between the lines will always be limited by the height of the shorter line. Further, the farther the lines, the more will be the area obtained.

         We take two pointers, one at the beginning and one at the end of the array constituting the length of the lines. Futher, we maintain a variable maxarea to store the maximum area obtained till now. At every step, we find out the area formed between them, update maxarea and move the pointer pointing to the shorter line towards the other end by one step.
         */

        guard height.count > 1 else { return 0 }
        guard height.count > 2 else { return min(height[0], height[1]) }

        var maxArea = 0
        var i = 0
        var j = height.count - 1
        while i < j {
            let newArea = min(height[i], height[j]) * (j - i)
            maxArea = max(maxArea, newArea)
            if height[i] < height[j] {
                i += 1
            } else {
                j -= 1
            }
        }
        return maxArea
    }
}

final class TestCase: XCTestCase {

    private let sol = Solution()

    func testWideToEnd() {
        XCTAssertEqual(sol.maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]), 49)
    }

    func testStartToEnd() {
        XCTAssertEqual(sol.maxArea([4, 3, 2, 1, 4]), 16)
    }

    func testOneOne() {
        XCTAssertEqual(sol.maxArea([1, 1]), 1)
    }

    func testOneTwoOne() {
        XCTAssertEqual(sol.maxArea([1, 2, 1]), 2)
    }

    func testOneTwoFourTree() {
        XCTAssertEqual(sol.maxArea([1, 2, 4, 3]), 4)
    }
}

TestCase.defaultTestSuite.run()

/*
 You are climbing a staircase. It takes n steps to reach the top.

 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

 Example 1:
 Input: n = 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps

 Example 2:
 Input: n = 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step

 Constraints:
 1 <= n <= 45
 */

import XCTest

class Solution {
    func climbStairs(_ n: Int) -> Int {
        /*
         The key intuition to solve the problem is that given a number of stairs n, if we know the number ways to get to the points [n-1] and [n-2] respectively, denoted as n1 and n2, then the total ways to get to the point [n] is n1 + n2. Because from the [n-1] point, we can take one single step to reach [n]. And from the [n-2] point, we could take two steps to get there.
         This solution is a simplification from memoization all the steps keeping an array memo of length n
         The solutions calculated by the above approach are complete and non-redundant.
         */
        if n <= 0 { return 0 }
        if n == 1 { return 1 }
        if n == 2 { return 2 }

        var rePrevious = 1
        var previous = 2
        var current = previous
        for _ in 3...n {
            current = rePrevious + previous
            rePrevious = previous
            previous = current
        }

        return current
    }
}

class TestCase: XCTestCase {
    let sol = Solution()
    func testInputOne() {
        XCTAssertEqual(sol.climbStairs(1), 1)
    }

    func testInputTwo() {
        XCTAssertEqual(sol.climbStairs(2), 2)
    }

    func testInputThree() {
        XCTAssertEqual(sol.climbStairs(3), 3)
    }

    func testInputFour() {
        XCTAssertEqual(sol.climbStairs(4), 5)
    }

    func testInputFive() {
        XCTAssertEqual(sol.climbStairs(5), 8)
    }

    func testInputSix() {
        XCTAssertEqual(sol.climbStairs(6), 13)
    }
}

TestCase.defaultTestSuite.run()


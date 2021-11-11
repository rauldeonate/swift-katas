/*
 Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

 Example 1:
 Input: n = 3
 Output: ["((()))","(()())","(())()","()(())","()()()"]

 Example 2:
 Input: n = 1
 Output: ["()"]

 Constraints:
     1 <= n <= 8
 */

import XCTest

class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        backtracking(&result, "", 0, 0, n)
        return result
    }

    func backtracking(_ result: inout [String], _ string: String, _ open: Int, _ close: Int, _ total: Int) {
        if string.count == total * 2 {
            result.append(string)
            return
        }

        if open < total {
            backtracking(&result, string + "(", open + 1, close, total)
        }
        if close < open {
            backtracking(&result, string + ")", open, close + 1, total)
        }
    }
}

class TopDownSolution {
    func generateParenthesis(_ n: Int) -> [String] {
        var dp = [Int: [String]]()
        dp[0] = [""]
        return helper(n, &dp)
    }

    func helper(_ n: Int, _ dp: inout [Int: [String]]) -> [String] {
        if let generated = dp[n] { return generated }

        var combos = [String]()

        for i in 0..<n {
            let inside = helper(i, &dp)
            let tail = helper(n - i - 1, &dp)
            for i in inside {
                for t in tail {
                    combos.append("(" + i + ")" + t)
                }
            }
        }

        dp[n] = combos
        return combos
    }
}

class BotttomUpSolution {
    func generateParenthesis(_ n: Int) -> [String] {
        var dp = [Int: [String]]()
        dp[0] = [""]

        for i in 1...n {
            var combos = [String]()
            for j in 0..<i {
                let insides = dp[j]!
                let tails = dp[i - j - 1]!
                for inside in insides {
                    for tail in tails {
                        combos.append("(" + inside + ")" + tail)
                    }
                }
            }
            dp[i] = combos
        }

        return dp[n] ?? []
    }
}

class TestCase: XCTestCase {
    let backtrackingSolution = Solution()
    let topDownSolution = TopDownSolution()
    let bottomUpSolution = BotttomUpSolution()

    func testThreeBacktracking() {
        XCTAssertEqual(
            backtrackingSolution.generateParenthesis(3).sorted(),
            ["((()))","(()())","(())()","()(())","()()()"].sorted()
        )
    }

    func testOneBacktracking() {
        XCTAssertEqual(
            backtrackingSolution.generateParenthesis(1),
               ["()"]
        )
    }

    func testThreeTopDown() {
        XCTAssertEqual(
            topDownSolution.generateParenthesis(3).sorted(),
            ["((()))","(()())","(())()","()(())","()()()"].sorted()
        )
    }

    func testOneTopDown() {
        XCTAssertEqual(
            topDownSolution.generateParenthesis(1),
               ["()"]
        )
    }

    func testThreeBottomUp() {
        XCTAssertEqual(
            bottomUpSolution.generateParenthesis(3).sorted(),
            ["((()))","(()())","(())()","()(())","()()()"].sorted()
        )
    }

    func testOneBottomUp() {
        XCTAssertEqual(
            bottomUpSolution.generateParenthesis(1),
            ["()"]
        )
    }
}

TestCase.defaultTestSuite.run()

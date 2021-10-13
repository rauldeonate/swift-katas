/*
 Given a string s, partition s such that every substring of the partition is a palindrome. Return all possible palindrome partitioning of s.

 A palindrome string is a string that reads the same backward as forward.

 Example 1:
 Input: s = "aab"
 Output: [["a","a","b"],["aa","b"]]

 Example 2:
 Input: s = "a"
 Output: [["a"]]

 Constraints:
     1 <= s.length <= 16
     s contains only lowercase English letters.
 */

import XCTest

func partition(_ s: String) -> [[String]] {
    var result = [[String]]()
    var candidate = [String]()

    backtracking(&result, &candidate, Array(s), 0)

    return result
}

private func backtracking(_ result: inout [[String]], _ candidate: inout [String], _ characters: [Character], _ start: Int) {
    if start == characters.count {
        result.append(candidate)
    } else {
        for i in start..<characters.count {
            if isPalindrome(characters, start, i) {
                let character = String(characters[start...i])
                candidate.append(character)
                backtracking(&result, &candidate, characters, i + 1)
                candidate.removeLast()
            }
        }
    }
}

private func isPalindrome(_ characters: [Character], _ low: Int, _ high: Int) -> Bool {
    var low = low
    var high = high

    while low < high {
        if characters[low] != characters[high] {
            return false
        }
        low += 1
        high -= 1
    }

    return true
}

class TestCase: XCTestCase {
    func testReachableNoExtra() {
        XCTAssertEqual(partition("aab"), [["a","a","b"],["aa","b"]])
    }
}

TestCase.defaultTestSuite.run()

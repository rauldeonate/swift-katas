/*
 Given a string s, return the longest palindromic substring in s.

 Example 1:
 Input: s = "babad"
 Output: "bab"
 Note: "aba" is also a valid answer.

 Example 2:
 Input: s = "cbbd"
 Output: "bb"

 Example 3:
 Input: s = "a"
 Output: "a"

 Example 4:
 Input: s = "ac"
 Output: "a"

 Constraints:
     1 <= s.length <= 1000
     s consist of only digits and English letters.
 */

import XCTest

func longestPalindrome(_ s: String) -> String {
    if s.count < 2 {
        return s
    }

    var low = 0
    var maxLength = 0
    let chars = Array(s)
    for i in 0..<chars.count - 1 {
        checkSubString(i: i, j: i, chars: chars, low: &low, maxLength: &maxLength)
        checkSubString(i: i, j: i+1, chars: chars, low: &low, maxLength: &maxLength)
    }
    return String(chars[low..<low + maxLength])
}

func checkSubString(i: Int, j: Int, chars: [Character], low: inout Int, maxLength: inout Int) {
    var x = i
    var y = j
    while (x >= 0 && y < chars.count && chars[x] == chars[y]) {
        x -= 1
        y += 1
    }

    if (maxLength < y - x - 1) {
        low = x + 1
        maxLength = y - x - 1
    }
}

class TestCase: XCTestCase {
    func testPalindromeAtStart() {
        XCTAssert(longestPalindrome("babad").isEqual("bab") || longestPalindrome("babad").isEqual("aba"))
    }

    func testPalindromeMiddle() {
        XCTAssertEqual(longestPalindrome("cbbd"), "bb")
    }

    func testPalindromeSameLettersAtEnd() {
        XCTAssertEqual(longestPalindrome("abb"), "bb")
    }

    func testPalindromeOneInputOneOutput() {
        XCTAssertEqual(longestPalindrome("a"), "a")
    }

    func testPalindromeTwoInputOneOutput() {
        XCTAssertEqual(longestPalindrome("ac"), "a")
    }

    func testPalindromeSameLetters() {
        XCTAssertEqual(longestPalindrome("bb"), "bb")
    }

    func testPalindromeEmpty() {
        XCTAssertEqual(longestPalindrome(""), "")
    }
}

TestCase.defaultTestSuite.run()

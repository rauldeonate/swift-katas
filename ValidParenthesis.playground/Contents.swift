import XCTest

/*
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:

     Open brackets must be closed by the same type of brackets.
     Open brackets must be closed in the correct order.

 Constraints:

     1 <= s.length <= 104
     s consists of parentheses only '()[]{}'
 */

class Solution {
    func isValid(_ s: String) -> Bool {
        var cachedOpeningBrackets: [Character] = []
        var cachedClosingBrackets: [Character] = []
        for char in s {
            if isOpeningBracket(char: char) {
                cachedOpeningBrackets.append(char)
            } else if isClosingBracket(char: char) {
                if let lastOpeningBracket = cachedOpeningBrackets.last,
                bracketCanClose(closingBracket: char, openingBracket: lastOpeningBracket) {
                    cachedOpeningBrackets.removeLast()
                    cachedClosingBrackets.append(char)
                } else {
                    return false
                }
            }
        }

        return cachedOpeningBrackets.isEmpty
    }

    func isOpeningBracket(char: Character) -> Bool {
        return ((char == "(") || (char == "{") || (char == "["))
    }

    func isClosingBracket(char: Character) -> Bool {
        return ((char == ")") || (char == "}") || (char == "]"))
    }

    func bracketCanClose(closingBracket: Character, openingBracket: Character) -> Bool {
        if (closingBracket == ")") {
            return openingBracket == "("
        } else if (closingBracket == "}") {
            return openingBracket == "{"
        } else if (closingBracket == "]") {
            return openingBracket == "["
        }
        return false
    }
}

class TestCase: XCTestCase {

    func testSuccessShort() {
        XCTAssertEqual(Solution().isValid("()"), true)
    }

    func testSuccessLong() {
        XCTAssertEqual(Solution().isValid("()[]{}"), true)
    }

    func testFailureShort() {
        XCTAssertEqual(Solution().isValid("(]"), false)
    }

    func testFailureLong() {
        XCTAssertEqual(Solution().isValid("([)]"), false)
    }

    func testSuccessInBetween() {
        XCTAssertEqual(Solution().isValid("{[]}"), true)
    }
}

TestCase.defaultTestSuite.run()

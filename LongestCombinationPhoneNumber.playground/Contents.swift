/*
 Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.

 A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

 Example 1:
 Input: digits = "23"
 Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]

 Example 2:
 Input: digits = ""
 Output: []

 Example 3:
 Input: digits = "2"
 Output: ["a","b","c"]

 Constraints:
     0 <= digits.length <= 4
     digits[i] is a digit in the range ['2', '9']
 */

import XCTest

func letterCombinations(_ digits: String) -> [String] {
    guard digits.count > 0 else { return [] }
    let map: [Character: [String]] = [
        "2": ["a", "b", "c"],
        "3": ["d", "e", "f"],
        "4": ["g", "h", "i"],
        "5": ["j", "k", "l"],
        "6": ["m", "n", "o"],
        "7": ["p", "q", "r", "s"],
        "8": ["t", "u", "v"],
        "9": ["w", "x", "y", "z"]
    ]

    var result: [String] = []
    for num in digits {
        guard let letters = map[num] else { continue }
        if result.isEmpty {
            for letter in letters {
                result.append(letter)
            }
        } else {
            for combination in result {
                result.removeFirst()
                for letter in letters {
                    result.append(combination + letter)
                }
            }
        }

        print(result)
    }

    return result
}

class TestCase: XCTestCase {
    func testTwoDigitsWith3Letters() {
        XCTAssertEqual(letterCombinations("23"), ["ad","ae","af","bd","be","bf","cd","ce","cf"])
    }

    func testEmpty() {
        XCTAssertEqual(letterCombinations(""), [])
    }

    func testThreeDigitsWithDifferentLetters() {
        XCTAssertEqual(letterCombinations("925"), ["waj", "wak", "wal", "wbj", "wbk", "wbl", "wcj", "wck", "wcl", "xaj", "xak", "xal", "xbj", "xbk", "xbl", "xcj", "xck", "xcl", "yaj", "yak", "yal", "ybj", "ybk", "ybl", "ycj", "yck", "ycl", "zaj", "zak", "zal", "zbj", "zbk", "zbl", "zcj", "zck", "zcl"])
    }
}

TestCase.defaultTestSuite.run()

/*
 Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

 Symbol       Value
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000

 For example, 2 is written as II in Roman numeral, just two one's added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

 Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

     I can be placed before V (5) and X (10) to make 4 and 9.
     X can be placed before L (50) and C (100) to make 40 and 90.
     C can be placed before D (500) and M (1000) to make 400 and 900.

 Given a roman numeral, convert it to an integer.

 */

import XCTest

class Solution {
    func romanToInt(_ s: String) -> Int {
        enum Roman: String {
            case I
            case V
            case X
            case L
            case C
            case D
            case M

            var majorThan: Roman? {
                switch self {
                    case .I: return nil
                    case .V: return .I
                    case .X: return .I
                    case .L: return .X
                    case .C: return .X
                    case .D: return .C
                    case .M: return .C
                }
            }

            var value: Int {
                switch self {
                    case .I: return 1
                    case .V: return 5
                    case .X: return 10
                    case .L: return 50
                    case .C: return 100
                    case .D: return 500
                    case .M: return 1000
                }
            }
        }

        let romans = s.map { String($0) }.compactMap { Roman(rawValue: $0) }
        var sum = 0
        var i = 0
        while i < romans.count {
            if i+1 < romans.count && romans[i+1].majorThan == romans[i] {
                sum += romans[i+1].value - romans[i].value
                i += 2
            } else {
                sum += romans[i].value
                i += 1
            }
        }

        return sum
    }
}

class TestCase: XCTestCase {
    func testSuccessShort() {
        XCTAssertEqual(Solution().romanToInt("III"), 3)
    }

    func testSuccessLong() {
        XCTAssertEqual(Solution().romanToInt("IV"), 4)
    }

    func testFailureShort() {
        XCTAssertEqual(Solution().romanToInt("IX"), 9)
    }

    func testFailureLong() {
        XCTAssertEqual(Solution().romanToInt("LVIII"), 58)
    }

    func testSuccessInBetween() {
        XCTAssertEqual(Solution().romanToInt("MCMXCIV"), 1994)
    }
}

TestCase.defaultTestSuite.run()


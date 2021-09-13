/*
 Given an array of strings strs, group the anagrams together. You can return the answer in any order.

 An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

 Example 1:
 Input: strs = ["eat","tea","tan","ate","nat","bat"]
 Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

 Example 2:
 Input: strs = [""]
 Output: [[""]]

 Example 3:
 Input: strs = ["a"]
 Output: [["a"]]

 Constraints:
     1 <= strs.length <= 104
     0 <= strs[i].length <= 100
     strs[i] consists of lowercase English letters.
 */

import XCTest

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var hashMap: [String: [String]] = [:]

    for string in strs {
        let stringSorted = String(string.sorted())
        if hashMap[stringSorted] == nil {
            hashMap[stringSorted] = [string]
        } else {
            hashMap[stringSorted]?.append(string)
        }
    }

    return Array(hashMap.values)
}

class TestCase: XCTestCase {
    func testArrayAnagramsDifferentCount() {
        let result = groupAnagrams(["eat","tea","tan","ate","nat","bat"])
            .map { $0.sorted() }
            .sorted { array1, array2 in
                array1.first!.lowercased() < array2.first!.lowercased()
            }
        let expectedResult = [["bat"],["nat","tan"],["ate","eat","tea"].sorted()].sorted { array1, array2 in array1.first!.lowercased() < array2.first!.lowercased()
        }
        XCTAssertEqual(result, expectedResult)
    }

    func testEmpty() {
        let result = groupAnagrams([""])
            .map { $0.sorted() }
            .sorted { array1, array2 in
                array1.first!.lowercased() < array2.first!.lowercased()
            }
        let expectedResult = [[""].sorted()].sorted { array1, array2 in array1.first!.lowercased() < array2.first!.lowercased()
        }
        XCTAssertEqual(result, expectedResult)
    }

    func testOneElement() {
        let result = groupAnagrams(["a"])
            .map { $0.sorted() }
            .sorted { array1, array2 in
                array1.first!.lowercased() < array2.first!.lowercased()
            }
        let expectedResult = [["a"].sorted()].sorted { array1, array2 in array1.first!.lowercased() < array2.first!.lowercased()
        }
        XCTAssertEqual(result, expectedResult)
    }
}

TestCase.defaultTestSuite.run()

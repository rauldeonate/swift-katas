/*
 Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

 Note that the same word in the dictionary may be reused multiple times in the segmentation.
 */

import XCTest

func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    // Dynamic programming
    // Time: O(m * n), Space: O(m) where m is the count of string "s" and n is the count of "wordDict"
    guard s.count>0, wordDict.count>0 else { return false }
    var isMatch = Array(repeating: false, count: s.count)

    for i in 0..<s.count {
        let substring = String(s.prefix(i+1))

        for word in wordDict where substring.hasSuffix(word){
            let preIndex = i-word.count

            if preIndex<0 || preIndex>=0 && isMatch[preIndex] {
                isMatch[i] = true
                break
            }
        }
    }
    return isMatch[s.count-1]
}

class TestCase: XCTestCase {
    func testTwoWordsDict() {
        XCTAssertEqual(wordBreak("leetcode", ["leet","code"]), true)
    }

    func testTwoWordsDictRepeatingWord() {
        XCTAssertEqual(wordBreak("applepenapple", ["apple","pen"]), true)
    }

    func testThreeWordsUnmatch() {
        XCTAssertEqual(wordBreak("catsandog", ["cats","dog","sand","and","cat"]), false)
    }
}

TestCase.defaultTestSuite.run()

class MemoizationSolution {
    func wordBreakMemoization(_ s: String, _ wordDict: [String]) -> Bool {
        var cache: [String: Bool] = [:]
        return wordBreakHelper(s, wordDict, &cache)
    }

    func wordBreakHelper(_ s: String, _ wordDict: [String], _ cache: inout [String: Bool]) -> Bool {
        if let cached = cache[s] {
            return cached
        }

        for word in wordDict where s.hasPrefix(word){
            let string = stringWithoutPrefix(word, s)

            if string.isEmpty {
                return true
            } else {
                let isBreakable = wordBreakHelper(string, wordDict, &cache)
                cache[string] = isBreakable

                if isBreakable {
                    return true
                }
            }
        }

        return false
    }

    private func stringWithoutPrefix(_ prefix: String, _ s: String) -> String {
        let newString = Array(s)
        return String(newString[prefix.count...])
    }
}

class TrieSolution {
    class TrieNode {
        var chars: [Character : TrieNode]
        var isWord: Bool

        init(_ chars: [Character : TrieNode] = [Character : TrieNode](), _ isWord: Bool = false) {
            self.chars = chars
            self.isWord = isWord
        }
    }

    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let root = TrieNode()
        var currentNode = root
        // Build the Trie
        for word in wordDict {
            for char in word {
                if currentNode.chars[char] == nil {
                    currentNode.chars[char] = TrieNode()
                }
                currentNode = currentNode.chars[char]!
            }
            currentNode.isWord = true
            currentNode = root
        }

        let sCount = s.count
        let sArray = Array(s)
        var isWords = Array(repeating: false, count: sCount + 1)
        isWords[sCount] = true

        for i in stride(from: sCount - 1, through: 0, by: -1) {
            for j in i..<sCount {
                if let nextNode = currentNode.chars[sArray[j]] {
                    currentNode = nextNode
                    if isWords[j + 1] && currentNode.isWord {
                        isWords[i] = true
                        break
                    }
                } else { // Cannot find this character in Trie
                    break
                }
            }
            currentNode = root // move back to root
        }

        return isWords[0]
    }
}

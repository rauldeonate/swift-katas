/*
 A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings. There are various applications of this data structure, such as autocomplete and spellchecker.

 Implement the Trie class:

     Trie() Initializes the trie object.
     void insert(String word) Inserts the string word into the trie.
     boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
     boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.

 Example 1:

 Input
 ["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
 [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
 Output
 [null, null, true, false, true, null, true]

 Explanation
 Trie trie = new Trie();
 trie.insert("apple");
 trie.search("apple");   // return True
 trie.search("app");     // return False
 trie.startsWith("app"); // return True
 trie.insert("app");
 trie.search("app");     // return True

 Constraints:

     1 <= word.length, prefix.length <= 2000
     word and prefix consist only of lowercase English letters.
     At most 3 * 104 calls in total will be made to insert, search, and startsWith.
 */

import XCTest

class TrieNode {
    var word = ""
    var children = [Character : TrieNode]()
}

class Trie {
    var root = TrieNode()

    func insert(_ word: String) {
        var currentNode = root

        for char in word {
            if let node = currentNode.children[char] {
                currentNode = node
            } else {
                let newNode = TrieNode()
                currentNode.children[char] = newNode
                currentNode = newNode
            }
        }
        currentNode.word = word
    }

    func search(_ word: String) -> Bool {
        var currentNode = root

        for char in word {
            if let node = currentNode.children[char] {
                currentNode = node
            } else {
                return false
            }
        }

        return currentNode.word.isEmpty ? false : true
    }

    func startsWith(_ prefix: String) -> Bool {
        var currentNode = root

        for char in prefix {
            if let node = currentNode.children[char] {
                currentNode = node
            } else {
                return false
            }
        }
        return currentNode.children.isEmpty && currentNode.word.isEmpty ? false : true
    }
}

class TestCase: XCTestCase {
    func testDefault() {
        let trie = Trie()
        trie.insert("apple");
        XCTAssertEqual(trie.search("apple"), true)
        XCTAssertEqual(trie.search("app"), false)
        XCTAssertEqual(trie.startsWith("app"), true)
        trie.insert("app")
        XCTAssertEqual(trie.search("app"), true)
    }
}

TestCase.defaultTestSuite.run()

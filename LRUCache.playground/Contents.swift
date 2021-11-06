/*
 Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

 Implement the LRUCache class:

     LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
     int get(int key) Return the value of the key if the key exists, otherwise return -1.
     void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.

 The functions get and put must each run in O(1) average time complexity.

 Example 1:

 Input
 ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
 Output
 [null, null, null, 1, null, -1, null, -1, 3, 4]

 Explanation
 LRUCache lRUCache = new LRUCache(2);
 lRUCache.put(1, 1); // cache is {1=1}
 lRUCache.put(2, 2); // cache is {1=1, 2=2}
 lRUCache.get(1);    // return 1
 lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
 lRUCache.get(2);    // returns -1 (not found)
 lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
 lRUCache.get(1);    // return -1 (not found)
 lRUCache.get(3);    // return 3
 lRUCache.get(4);    // return 4

 Constraints:

     1 <= capacity <= 3000
     0 <= key <= 104
     0 <= value <= 105
     At most 2 * 105 calls will be made to get and put.
 */

import XCTest

class Node {
    weak var prev: Node?
    var next: Node?
    var value: Int = -1
    var key: Int = -1
}

class LRUCache {
    let head = Node()
    let tail = Node()
    var cache = [Int: Node]()
    var count = 0
    var capacity = 0

    init(_ capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.prev = head
    }

    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            visit(node)
            return node.value
        }
        return -1
    }

    func put(_ key: Int, _ value: Int) {
        var node: Node! = cache[key]

        if node == nil {
            if count == capacity {
                node = dequeue()
            } else {
                node = Node()
                count += 1
            }
        }

        cache[key]   = node
        node.key   = key
        node.value = value

        visit(node)
    }

    private func visit(_ node: Node) {
        node.prev?.next = node.next
        node.next?.prev = node.prev

        head.next!.prev = node
        node.next = head.next
        node.prev = head
        head.next = node
    }

    private func dequeue() -> Node {
        let lastNode: Node! = tail.prev

        cache.removeValue(forKey: lastNode.key)

        lastNode.prev!.next = tail
        tail.prev = lastNode.prev

        lastNode.prev = nil
        lastNode.next = nil

        return lastNode
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */

class TestCase: XCTestCase {
    func testDefault() {
        let lruCache = LRUCache(2)

        lruCache.put(1, 1)
        lruCache.put(2, 2)
        XCTAssertEqual(lruCache.get(1), 1)
        lruCache.put(3, 3)
        XCTAssertEqual(lruCache.get(2), -1)
        lruCache.put(4, 4)
        XCTAssertEqual(lruCache.get(1), -1)
        XCTAssertEqual(lruCache.get(3), 3)
        XCTAssertEqual(lruCache.get(4), 4)
    }
}

TestCase.defaultTestSuite.run()

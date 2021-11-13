/*
 You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:

 struct Node {
   int val;
   Node *left;
   Node *right;
   Node *next;
 }

 Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

 Initially, all next pointers are set to NULL.

 Example 1:
 Input: root = [1,2,3,4,5,6,7]
 Output: [1,#,2,3,#,4,5,6,7,#]
 Explanation: Given the above perfect binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B. The serialized output is in level order as connected by the next pointers, with '#' signifying the end of each level.

 Example 2:
 Input: root = []
 Output: []

 Constraints:
     The number of nodes in the tree is in the range [0, 212 - 1].
     -1000 <= Node.val <= 1000

 Follow-up:
     You may only use constant extra space.
     The recursive approach is fine. You may assume implicit stack space does not count as extra space for this problem.
 */

import XCTest

public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
}

class Solution {
    // DFS. Constant space. Implicit stack space
    func connect(_ root: Node?) -> Node? {
        dfs(root)
        return root
    }

    func dfs(_ root: Node?) {
        guard let root = root else {
            return
        }

        if let left = root.left {
            left.next = root.right
            dfs(left)
        }

        if let right = root.right {
            right.next = root.next?.left
            dfs(right)
        }
    }
}

class BFSSolution {
    // BFS - O(N) Space
    func connect(_ root: Node?) -> Node? {
        guard let root = root else {
            return nil
        }
        var queue = [Node]()
        let rootReference = root
        queue.append(root)

        while !queue.isEmpty {
            let queueSize = queue.count
            for i in 0..<queueSize {
                let node = queue.removeFirst()

                if i != queueSize - 1, let next = queue.first {
                    print("current: \(node.val), next: \(next.val)")
                    node.next = next
                }

                if let left = node.left {
                    queue.append(left)
                }

                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        return rootReference
    }
}

class TestCase: XCTestCase {

    let sol = Solution()
    let bfsSol = BFSSolution()

    func testTwoPerLevel() {
        let node1 = Node(1)
        let node2 = Node(2)
        let node3 = Node(3)
        let node4 = Node(4)
        let node5 = Node(5)
        let node6 = Node(6)
        let node7 = Node(7)
        node1.left = node2
        node1.right = node3
        node2.left = node4
        node2.right = node5
        node3.left = node6
        node3.right = node7

        let expectedNode1 = Node(1)
        let expectedNode2 = Node(2)
        let expectedNode3 = Node(3)
        let expectedNode4 = Node(4)
        let expectedNode5 = Node(5)
        let expectedNode6 = Node(6)
        let expectedNode7 = Node(7)
        expectedNode1.left = node2
        expectedNode1.right = node3
        expectedNode2.left = node4
        expectedNode2.right = node5
        expectedNode2.next = expectedNode3
        expectedNode3.left = node6
        expectedNode3.right = node7
        expectedNode4.next = expectedNode5
        expectedNode5.next = expectedNode6
        expectedNode6.next = expectedNode7

        XCTAssertEqual(
            sol.connect(node1),
            expectedNode1
        )

        XCTAssertEqual(
            bfsSol.connect(node1),
            expectedNode1
        )
    }
}

TestCase.defaultTestSuite.run()

extension Node: Equatable {
    public static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.left == rhs.left && lhs.right == rhs.right && lhs.next == rhs.next && lhs.val == rhs.val
    }
}

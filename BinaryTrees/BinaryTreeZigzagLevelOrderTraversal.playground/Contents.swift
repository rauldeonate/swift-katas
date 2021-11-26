/*
 Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[20,9],[15,7]]

 Example 2:
 Input: root = [1]
 Output: [[1]]

 Example 3:
 Input: root = []
 Output: []

 Constraints:
     The number of nodes in the tree is in the range [0, 2000].
     -100 <= Node.val <= 100
 */

import XCTest

final class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
    public init?(_ array: [Int?]) {
        var values = array
        guard !values.isEmpty, let head = values.removeFirst() else { return nil }
        val = head; left = nil; right = nil
        var queue = [self]
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if !values.isEmpty, let val = values.removeFirst() {
                node.left = TreeNode(val)
                queue.append(node.left!)
            }
            if !values.isEmpty, let val = values.removeFirst() {
                node.right = TreeNode(val)
                queue.append(node.right!)
            }
        }
    }
}

final class DFSSolution {
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var result = [[Int]]()

        dfs(root, &result, 0)

        return result
    }

    func dfs(_ node: TreeNode?, _ result: inout [[Int]], _ level: Int) {
        guard let node = node else {
            return
        }

        if result.count <= level {
            result.append([Int]())
        }

        var levelNodes = result[level]
        if level % 2 == 0 {
            levelNodes.append(node.val)
        } else {
            levelNodes.insert(node.val, at: 0)
        }
        result[level] = levelNodes

        dfs(node.left, &result, level + 1)
        dfs(node.right, &result, level + 1)
    }
}

final class BFSSolution {
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var result = [[Int]]()
        var order = true
        var queue = [TreeNode]()

        queue.append(root)
        while !queue.isEmpty {
            var levelNodes = [Int]()
            let count = queue.count
            for _ in 0..<count {
                let node = queue.removeFirst()
                if order {
                    levelNodes.append(node.val)
                } else {
                    levelNodes.insert(node.val, at: 0)
                }
                if let leftNode = node.left {
                    queue.append(leftNode)
                }
                if let rightNode = node.right {
                    queue.append(rightNode)
                }
            }
            result.append(levelNodes)
            order = !order
        }

        return result
    }
}

final class TestCase: XCTestCase {
    let dfsSol = DFSSolution()
    let bfsSol = BFSSolution()

    func testRightSubtreeLastLevelDFS() {
        let result = dfsSol.zigzagLevelOrder(.init([3, 9, 20, nil, nil, 15, 7]))
        XCTAssertEqual(result, [[3], [20, 9], [15, 7]])
    }

    func testIrregularNodesLastLevelDFS() {
        let result = dfsSol.zigzagLevelOrder(.init([3, 9, 20, 21, nil, 15, 7]))
        XCTAssertEqual(result, [[3],[20, 9], [21, 15, 7]])
    }

    func testOneElementInputDFS() {
        let result = dfsSol.zigzagLevelOrder(.init([1]))
        XCTAssertEqual(result, [[1]])
    }

    func testRightSubtreeLastLevelBFS() {
        let result = bfsSol.zigzagLevelOrder(.init([3, 9, 20, nil, nil, 15, 7]))
        XCTAssertEqual(result, [[3],[20,9],[15,7]])
    }

    func testIrregularNodesLastLevelBFS() {
        let result = bfsSol.zigzagLevelOrder(.init([3, 9, 20, 21, nil, 15, 7]))
        XCTAssertEqual(result, [[3],[20,9],[21,15,7]])
    }

    func testOneElementInputBFS() {
        let result = bfsSol.zigzagLevelOrder(.init([1]))
        XCTAssertEqual(result, [[1]])
    }
}

TestCase.defaultTestSuite.run()

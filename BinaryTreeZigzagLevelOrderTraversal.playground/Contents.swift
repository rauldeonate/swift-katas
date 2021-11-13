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

class TreeNode {
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
}

class Solution {
    // DFS
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

class BFSSolution {
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

class TestCase: XCTestCase {
    let sol = Solution()
    let bfsSol = BFSSolution()

    func testRightSubtreeLastLevel() {
        XCTAssertEqual(
            sol.zigzagLevelOrder(
                TreeNode(3,
                         TreeNode(9),
                         TreeNode(20,
                                  TreeNode(15),
                                  TreeNode(7))
                         )
            ),
            [[3],[20,9],[15,7]]
        )
    }

    func testIrregularNodesLastLevel() {
        XCTAssertEqual(
            sol.zigzagLevelOrder(
                TreeNode(3,
                         TreeNode(9,
                                  TreeNode(21),
                                  nil),
                         TreeNode(20,
                                  TreeNode(15),
                                  TreeNode(7))
                )
                ),
            [[3],[20,9],[21,15,7]])
    }

    func testOneElementInput() {
        XCTAssertEqual(
            sol.zigzagLevelOrder(TreeNode(1)),
            [[1]]
        )
    }

    func testRightSubtreeLastLevelBFS() {
        XCTAssertEqual(
            bfsSol.zigzagLevelOrder(
                TreeNode(3,
                         TreeNode(9),
                         TreeNode(20,
                                  TreeNode(15),
                                  TreeNode(7))
                         )
            ),
            [[3],[20,9],[15,7]]
        )
    }

    func testIrregularNodesLastLevelBFS() {
        XCTAssertEqual(
            bfsSol.zigzagLevelOrder(
                TreeNode(3,
                         TreeNode(9,
                                  TreeNode(21),
                                  nil),
                         TreeNode(20,
                                  TreeNode(15),
                                  TreeNode(7))
                )
                ),
            [[3],[20,9],[21,15,7]])
    }

    func testOneElementInputBFS() {
        XCTAssertEqual(
            bfsSol.zigzagLevelOrder(TreeNode(1)),
            [[1]]
        )
    }
}

TestCase.defaultTestSuite.run()

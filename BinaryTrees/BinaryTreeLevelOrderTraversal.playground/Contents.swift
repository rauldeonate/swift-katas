/*
 Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[9,20],[15,7]]

 Example 2:
 Input: root = [1]
 Output: [[1]]

 Example 3:
 Input: root = []
 Output: []

 Constraints:
     The number of nodes in the tree is in the range [0, 2000].
     -1000 <= Node.val <= 1000
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

final class IterativeSolution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var queue = [TreeNode]()
        var result = [[Int]]()

        queue.append(root)
        while !queue.isEmpty {
            let levelCount = queue.count
            var levelNodes = [Int]()
            for _ in 0..<levelCount {
                let node = queue.removeFirst()
                if let leftNode = node.left {
                    queue.append(leftNode)
                }
                if let rightNode = node.right {
                    queue.append(rightNode)
                }
                levelNodes.append(node.val)
            }
            result.append(levelNodes)
        }

        return result
    }
}

final class RecursiveDFSSolution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var result = [[Int]]()
        helper(&result, root, 0)
        return result
    }

    func helper(_ result: inout [[Int]], _ root: TreeNode?, _ height: Int) {
        guard let root = root else {
            return
        }

        if height >= result.count {
            result.append([Int]())
        }
        result[height].append(root.val)
        helper(&result, root.left, height + 1)
        helper(&result, root.right, height + 1)
    }
}

final class IterativeSolutionWithSwiftCustomMappers {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var wrapList: [[Int]] = []
        var queue = [root] // First level

        while !queue.isEmpty {
            // All values of nodes on the current level:
            wrapList.append(queue.map { $0.val })
            // Replace queue by list of all nodes on the next level:
            queue = queue.flatMap { [$0.left, $0.right ] }.compactMap { $0 }
        }

        return wrapList
    }
}


class TestCase: XCTestCase {

    let iterativeSol = IterativeSolution()
    let recursiveSol = RecursiveDFSSolution()
    let iterativeCustomSol = IterativeSolutionWithSwiftCustomMappers()

    func testTwoPerLevelIterativeSol() {
        let result = iterativeSol.levelOrder(.init([3, 9, 20, 15, 7]))
        XCTAssertEqual(result, [[3], [9, 20], [15, 7]])
    }

    func testIrregularNodesPerLevelIterativeSol() {
        let result = iterativeSol.levelOrder(.init([3, 9, 20, 21, nil, 15, 7]))
        XCTAssertEqual(result, [[3], [9, 20], [21, 15, 7]])
    }

    func testTwoPerLevelRecursiveSol() {
        let result = recursiveSol.levelOrder(.init([3, 9, 20, 15, 7]))
        XCTAssertEqual(result, [[3], [9, 20], [15, 7]])
    }

    func testIrregularNodesPerLevelRecursiveSol() {
        let result = recursiveSol.levelOrder(.init([3, 9, 20, 21, nil, 15, 7]))
        XCTAssertEqual(result, [[3], [9, 20], [21, 15, 7]])
    }

    func testTwoPerLevelIterativeCustomSol() {
        let result = recursiveSol.levelOrder(.init([3, 9, 20, 15, 7]))
        XCTAssertEqual(result, [[3], [9, 20], [15, 7]])
    }

    func testIrregularNodesPerLevelIterativeCustomSol() {
        let result = recursiveSol.levelOrder(.init([3, 9, 20, 21, nil, 15, 7]))
        XCTAssertEqual(result, [[3], [9, 20], [21, 15, 7]])
    }
}

TestCase.defaultTestSuite.run()

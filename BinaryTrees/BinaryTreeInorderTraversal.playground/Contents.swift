/*
 Given the root of a binary tree, return the inorder traversal of its nodes' values.

 Example 1:
 Input: root = [1,null,2,3]
 Output: [1,3,2]

 Example 2:
 Input: root = []
 Output: []

 Example 3:
 Input: root = [1]
 Output: [1]

 Example 4:
 Input: root = [1,2]
 Output: [2,1]

 Constraints:
     The number of nodes in the tree is in the range [0, 100].
     -100 <= Node.val <= 100


 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
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

class RecursiveSolution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var inorder: [Int] = []

        if root?.left != nil {
            inorder.append(contentsOf: inorderTraversal(root?.left))
        }
        if let val = root?.val {
            inorder.append(val)
        }
        if root?.right != nil {
            inorder.append(contentsOf: inorderTraversal(root?.right))
        }

        return inorder
    }
}

class IterativeSolution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result = [Int]()
        var stack = [TreeNode]()
        var current = root

        while current != nil || !stack.isEmpty {
            if current != nil {
                stack.append(current!)
                current = current?.left
            } else {
                current = stack.removeLast()
                result.append(current!.val)
                current = current?.right
            }
        }

        return result
    }
}

class TestCase: XCTestCase {
    let recursiveSol = RecursiveSolution()
    let iterativeSol = IterativeSolution()

    func testInputGenericRecursiveSolution() {
        let result = recursiveSol.inorderTraversal(.init([1, nil, 2, 3]))
        XCTAssertEqual(result, [1,3,2])
    }

    func testInputSimpleLeftRootRecursiveSolution() {
        let result = recursiveSol.inorderTraversal(.init([1, 2]))
        XCTAssertEqual(result, [2,1])
    }

    func testInputSimpleRootRightRecursiveSolution() {
        let result = recursiveSol.inorderTraversal(.init([1, nil, 2]))
        XCTAssertEqual(result, [1, 2])
    }

    func testInputEmptyRecursiveSolution() {
        let result = recursiveSol.inorderTraversal(.init([]))
        XCTAssertEqual(result, [])
    }

    func testInputGenericIterativeSolution() {
        let result = iterativeSol.inorderTraversal(.init([1, nil, 2, 3]))
        XCTAssertEqual(result, [1,3,2])
    }

    func testInputSimpleLeftRootIterativeSolution() {
        let result = iterativeSol.inorderTraversal(.init([1, 2]))
        XCTAssertEqual(result, [2,1])
    }

    func testInputSimpleRootRightIterativeSolution() {
        let result = iterativeSol.inorderTraversal(.init([1, nil, 2]))
        XCTAssertEqual(result, [1, 2])
    }

    func testInputEmptyIterativeSolution() {
        let result = iterativeSol.inorderTraversal(.init([]))
        XCTAssertEqual(result, [])
    }
}

TestCase.defaultTestSuite.run()

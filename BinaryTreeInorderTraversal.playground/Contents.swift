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
}

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

class TestCase: XCTestCase {
    func testInputGeneric() {
        XCTAssertEqual(
            inorderTraversal(
                TreeNode(1,
                         nil,
                         TreeNode(2,
                                  TreeNode(3,
                                           nil,
                                           nil),
                                  nil)
                )
            ), [1,3,2])
    }

    func testInputSimpleLeftRoot() {
        XCTAssertEqual(
            inorderTraversal(
                TreeNode(1,
                         TreeNode(2,
                                  nil,
                                  nil),
                         nil
                )
            ), [2,1])
    }

    func testInputSimpleRootRight() {
        XCTAssertEqual(
            inorderTraversal(
                TreeNode(1,
                         nil,
                         TreeNode(2,
                                  nil,
                                  nil)
                )
            ), [1,2])
    }

    func testInputEmpty() {
        XCTAssertEqual(inorderTraversal(nil), [])
    }
}

TestCase.defaultTestSuite.run()

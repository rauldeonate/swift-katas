/*
 Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).

 Example 1:
 Input: root = [1,2,2,3,4,4,3]
 Output: true

 Example 2:
 Input: root = [1,2,2,null,3,null,3]
 Output: false

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

func isSymmetric(_ root: TreeNode?) -> Bool {
    return checkSubtree(left: root?.left, right: root?.right)
}

func checkSubtree(left: TreeNode?, right: TreeNode?) -> Bool {
    if left == nil && right == nil {
        return true
    }
    if left == nil || right == nil {
        return false
    }
    return left?.val == right?.val &&
        checkSubtree(left: left?.left, right: right?.right) &&
        checkSubtree(left: left?.right, right: right?.left)
}

class TestCase: XCTestCase {
    func testSimpleSymmetric() {
        XCTAssertEqual(
            isSymmetric(
                TreeNode(1,
                         TreeNode(2,
                                  TreeNode(3,
                                           nil,
                                           nil),
                                  TreeNode(4,
                                           nil,
                                           nil)),
                         TreeNode(2,
                                  TreeNode(4,
                                           nil,
                                           nil),
                                  TreeNode(3,
                                           nil,
                                           nil))
                )
            ), true)
    }

    func testFailSameLeftRight() {
        XCTAssertEqual(
            isSymmetric(
                TreeNode(1,
                         TreeNode(2,
                                  nil,
                                  TreeNode(3,
                                           nil,
                                           nil)),
                         TreeNode(2,
                                  nil,
                                  TreeNode(3,
                                           nil,
                                           nil))
                )
            ), false)
    }

    func testFailNullSide() {
        XCTAssertEqual(
            isSymmetric(
                TreeNode(1,
                         TreeNode(2,
                                  nil,
                                  TreeNode(3,
                                           nil,
                                           nil)),
                         TreeNode(2,
                                  nil,
                                  nil)
                )
            ), false)
    }

    func testFailNoLeftNoRight() {
        XCTAssertEqual(
            isSymmetric(
                TreeNode(1,
                         TreeNode(0,
                                  nil,
                                  nil),
                         nil
                )
            ), false)
    }

    func testFailOneDifferentSubtree() {
        XCTAssertEqual(
            isSymmetric(
                TreeNode(1,
                         TreeNode(2,
                                  nil,
                                  nil),
                         TreeNode(3,
                                  nil,
                                  nil)
                )
            ), false)
    }

    func testFailLongInnerNodeDiff() {
        XCTAssertEqual(
            isSymmetric(
                TreeNode(7,
                         TreeNode(-64,
                                  TreeNode(-6,
                                           TreeNode(88,
                                                    nil,
                                                    nil),
                                           TreeNode(-44,
                                                    nil,
                                                    nil)),
                                  TreeNode(-90,
                                           TreeNode(68,
                                                    nil,
                                                    nil),
                                           TreeNode(-65,
                                                    nil,
                                                    nil))),
                         TreeNode(-64,
                                  TreeNode(-90,
                                           TreeNode(-76,
                                                    nil,
                                                    nil),
                                           TreeNode(68,
                                                    nil,
                                                    nil)),
                                  TreeNode(-6,
                                           TreeNode(-44,
                                                    nil,
                                                    nil),
                                           TreeNode(88,
                                                    nil,
                                                    nil)))
                )
            ), false)
    }
}

TestCase.defaultTestSuite.run()

/*
 Given the root of a binary search tree, and an integer k, return the kth smallest value (1-indexed) of all the values of the nodes in the tree.

 Example 1:

 Input: root = [3,1,4,null,2], k = 1
 Output: 1

 Example 2:

 Input: root = [5,3,6,2,4,null,null,1], k = 3
 Output: 3

 Constraints:
     The number of nodes in the tree is n.
     1 <= k <= n <= 104
     0 <= Node.val <= 104


 Follow up: If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?
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

func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
    // Recursive Inorder Traversal
    var data: [Int] = []
    dfsHelper(root, data: &data)
    if data.count == 0{
        return -1
    }
    let result = data[k - 1]
    return result
}

private func dfsHelper(_ node: TreeNode?, data: inout [Int]){
    guard let node = node else { return }
    dfsHelper(node.left, data: &data)
    data.append(node.val)
    dfsHelper(node.right, data: &data)
}

func kthSmallestStack(_ root: TreeNode?, _ k: Int) -> Int {
    // Iterative Inorder Traversal with stack
    var stack = [TreeNode]()
    var count = k
    var root = root

    while root != nil {
        stack.append(root!)
        root = root?.left
    }

    while count != 0 {
        let node = stack.removeLast()
        count -= 1
        if count == 0 {
            return node.val
        }
        var rightNode = node.right
        while rightNode != nil {
            stack.append(rightNode!)
            rightNode = rightNode?.left
        }
    }

    return -1
}


/*
 Follow up:
 Hence without any optimisation insert/delete + search of kth element has O(2H+k) complexity
 Use here the same logic as for LRU cache design, and combine an indexing structure (we could keep BST here) with a double linked list.

 Such a structure would provide:
     O(H) time for the insert and delete.
     O(k) for the search of kth smallest.

 Complexity Analysis
     Time complexity for insert/delete + search of kth smallest:
 O(H+k), where H is a tree height.
 O(log⁡N+k) in the average case,
 O(N+k) in the worst case.
     Space complexity : O(N) to keep the linked list.
 */

class TestCase: XCTestCase {
    func testSomehowBalanced() {
        XCTAssertEqual(
            kthSmallest(
                TreeNode(3,
                         TreeNode(1,
                                  nil,
                                  TreeNode(2,
                                           nil,
                                           nil)),
                         TreeNode(4,
                                  nil,
                                  nil)
                ), 1
            ), 1)
    }

    func testLeftBalanced() {
        XCTAssertEqual(
            kthSmallest(
                TreeNode(5,
                         TreeNode(3,
                                  TreeNode(2,
                                           TreeNode(1,
                                                    nil,
                                                    nil),
                                           nil),
                                  TreeNode(4,
                                           nil,
                                           nil)),
                         TreeNode(6,
                                  nil,
                                  nil)
                ), 3
            ), 3)
    }

    func testOneElement() {
        XCTAssertEqual(
            kthSmallest(
                TreeNode(5,
                         nil,
                         nil
                ), 1
            ), 5)
    }

    func testStackSomehowBalanced() {
        XCTAssertEqual(
            kthSmallestStack(
                TreeNode(3,
                         TreeNode(1,
                                  nil,
                                  TreeNode(2,
                                           nil,
                                           nil)),
                         TreeNode(4,
                                  nil,
                                  nil)
                ), 1
            ), 1)
    }

    func testStackLeftBalanced() {
        XCTAssertEqual(
            kthSmallestStack(
                TreeNode(5,
                         TreeNode(3,
                                  TreeNode(2,
                                           TreeNode(1,
                                                    nil,
                                                    nil),
                                           nil),
                                  TreeNode(4,
                                           nil,
                                           nil)),
                         TreeNode(6,
                                  nil,
                                  nil)
                ), 3
            ), 3)
    }

    func testStackOneElement() {
        XCTAssertEqual(
            kthSmallestStack(
                TreeNode(5,
                         nil,
                         nil
                ), 1
            ), 5)
    }
}

TestCase.defaultTestSuite.run()

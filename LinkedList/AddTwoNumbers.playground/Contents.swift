/*
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 Example 1:
 Input: l1 = [2,4,3], l2 = [5,6,4]
 Output: [7,0,8]
 Explanation: 342 + 465 = 807.

 Example 2:
 Input: l1 = [0], l2 = [0]
 Output: [0]

 Example 3:
 Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 Output: [8,9,9,9,0,0,0,1]

 Constraints:
     The number of nodes in each linked list is in the range [1, 100].
     0 <= Node.val <= 9
     It is guaranteed that the list represents a number that does not have leading zeros.

 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */

import XCTest

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1Pointer = l1
        var l2Pointer = l2
        var result: ListNode?
        var resultPointer = result
        var acc = 0
        while l1Pointer != nil || l2Pointer != nil || acc == 1 {
            var sum = acc + (l1Pointer?.val ?? 0) + (l2Pointer?.val ?? 0)
            if sum > 9 {
                acc = 1
                sum = sum % 10
            } else {
                acc = 0
            }

            if let resultSafePointer = resultPointer {
                resultSafePointer.next = ListNode(sum)
                resultPointer = resultSafePointer.next
            } else {
                result = ListNode(sum)
                resultPointer = result
            }

            if let l1Next = l1Pointer {
                l1Pointer = l1Next.next
            }
            if let l2Next = l2Pointer {
                l2Pointer = l2Next.next
            }
        }

        return result
    }
}

class RecursiveSolution {
    var carry = 0

    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard !(l1 == nil && l2 == nil && carry == 0) else { return nil }

        let sum = (l1?.val ?? 0) + (l2?.val ?? 0) + carry
        carry = sum / 10

        return ListNode(sum % 10, addTwoNumbers(l1?.next, l2?.next))
    }
}

extension ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next
    }
}

private class TestCase: XCTestCase {
    private let iterativeSol = Solution()
    private let recursiveSol = RecursiveSolution()

    func testSimpleIterativeSolution() {
        XCTAssertEqual(
            iterativeSol.addTwoNumbers(ListNode(2, ListNode(4, ListNode(3))),
                              ListNode(5, ListNode(6, ListNode(4)))),
                ListNode(7, ListNode(0, ListNode(8)))
        )
    }

    func testZerosIterativeSolution() {
        XCTAssertEqual(
            iterativeSol.addTwoNumbers(
                ListNode(0),
                ListNode(0)),
            ListNode(0)
        )
    }

    func testNinesIterativeSolution() {
        XCTAssertEqual(
            iterativeSol.addTwoNumbers(
                ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9))))))),
                ListNode(9, ListNode(9, ListNode(9, ListNode(9))))),
            ListNode(8, ListNode(9, ListNode(9, ListNode(9, ListNode(0, ListNode(0, ListNode(0, ListNode(1))))))))
        )
    }

    func testSimpleRecursiveSolution() {
        XCTAssertEqual(
            recursiveSol.addTwoNumbers(ListNode(2, ListNode(4, ListNode(3))),
                              ListNode(5, ListNode(6, ListNode(4)))),
                ListNode(7, ListNode(0, ListNode(8)))
        )
    }

    func testZerosRecursiveSolution() {
        XCTAssertEqual(
            recursiveSol.addTwoNumbers(
                ListNode(0),
                ListNode(0)),
            ListNode(0)
        )
    }

    func testNinesRecursiveSolution() {
        XCTAssertEqual(
            recursiveSol.addTwoNumbers(
                ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9))))))),
                ListNode(9, ListNode(9, ListNode(9, ListNode(9))))),
            ListNode(8, ListNode(9, ListNode(9, ListNode(9, ListNode(0, ListNode(0, ListNode(0, ListNode(1))))))))
        )
    }
}

TestCase.defaultTestSuite.run()

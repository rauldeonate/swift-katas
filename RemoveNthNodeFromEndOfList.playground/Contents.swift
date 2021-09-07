/*
 Given the head of a linked list, remove the nth node from the end of the list and return its head.

 Example 1:
 Input: head = [1,2,3,4,5], n = 2
 Output: [1,2,3,5]

 Example 2:
 Input: head = [1], n = 1
 Output: []

 Example 3:
 Input: head = [1,2], n = 1
 Output: [1]

 Constraints:
     The number of nodes in the list is sz.
     1 <= sz <= 30
     0 <= Node.val <= 100
     1 <= n <= sz

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

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    guard head != nil else { return nil }

    var first = head
    var second = head

    for _ in 0...n {
        first = first?.next
    }

    while (first != nil) {
        first = first?.next
        second = second?.next
    }

    second?.next = second?.next?.next

    return head
}


class TestCase: XCTestCase {
    func testSecondLast() {
        XCTAssertEqual(
            removeNthFromEnd(ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5))))), 2),
            ListNode(1, ListNode(2, ListNode(3, ListNode(5))))
        )
    }

    func testOneElement() {
        XCTAssertEqual(
            removeNthFromEnd(ListNode(1), 1),
            nil
        )
    }

    func testLast() {
        XCTAssertEqual(
            removeNthFromEnd(ListNode(1, ListNode(2)), 1),
            ListNode(1)
        )
    }

    func testEmpty() {
        XCTAssertEqual(
            removeNthFromEnd(nil, 1),
            nil
        )
    }

    func testFirst() {
        XCTAssertEqual(
            removeNthFromEnd(ListNode(1, ListNode(2)), 2),
            ListNode(2)
        )
    }
}



TestCase.defaultTestSuite.run()

extension ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next
    }
}

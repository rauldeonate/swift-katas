/*
 You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.

 Merge nums1 and nums2 into a single array sorted in non-decreasing order.

 The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.

 Example 1:
 Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
 Output: [1,2,2,3,5,6]
 Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
 The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.

 Example 2:
 Input: nums1 = [1], m = 1, nums2 = [], n = 0
 Output: [1]
 Explanation: The arrays we are merging are [1] and [].
 The result of the merge is [1].

 Example 3:
 Input: nums1 = [0], m = 0, nums2 = [1], n = 1
 Output: [1]
 Explanation: The arrays we are merging are [] and [1].
 The result of the merge is [1].
 Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.


 Constraints:
     nums1.length == m + n
     nums2.length == n
     0 <= m, n <= 200
     1 <= m + n <= 200
     -109 <= nums1[i], nums2[j] <= 109
 */

import XCTest

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var nums1Index = 0
    var nums2Index = 0
    var count = 0
    while nums1Index < nums1.count && nums2Index < nums2.count {
        if nums2[nums2Index] <= nums1[nums1Index] || (nums1[nums1Index] == 0 && nums1Index >= m + count) {
            count += 1
            nums1.insert(nums2[nums2Index], at: nums1Index)
            if let last = nums1.last, last == 0 {
                nums1.removeLast()
            }
            if nums1Index >= m {
                nums1Index += 1
            }
            nums2Index += 1
        } else {
            nums1Index += 1
        }
    }
}

class TestCase: XCTestCase {
    func testInputGeneric() {
        var nums1 = [1,2,3,0,0,0]
        merge(&nums1, 3, [2,5,6], 3)
        XCTAssertEqual(nums1, [1,2,2,3,5,6])
    }

    func testInputOneAndEmpty() {
        var nums1 = [1]
        merge(&nums1, 1, [], 0)
        XCTAssertEqual(nums1, [1])
    }

    func testInputZeroAndOne() {
        var nums1 = [0]
        merge(&nums1, 0, [1], 1)
        XCTAssertEqual(nums1, [1])
    }

    func testInputSmallAndBig() {
        var nums1 = [1,2,3,4,0,0,0,0]
        merge(&nums1, 4, [10,11,12,20], 4)
        XCTAssertEqual(nums1, [1,2,3,4,10,11,12,20])
    }

    func testInputBigAndSmall() {
        var nums1 = [10,11,12,20,0,0,0,0]
        merge(&nums1, 4, [1,2,3,4], 4)
        XCTAssertEqual(nums1, [1,2,3,4,10,11,12,20])
    }

    func testInputMiddleNumber() {
        var nums1 = [4,0,0,0,0,0]
        merge(&nums1, 1, [1,2,3,5,6], 5)
        XCTAssertEqual(nums1, [1,2,3,4,5,6])
    }

    func testInputNegatives() {
        var nums1 = [-1,3,0,0,0,0,0]
        merge(&nums1, 2, [0,0,1,2,3], 5)
        XCTAssertEqual(nums1, [-1,0,0,1,2,3,3])
    }

    func testInputNegativesAndZerosNumber() {
        var nums1 = [-1,0,0,3,3,3,0,0,0]
        merge(&nums1, 6, [1,2,2], 3)
        XCTAssertEqual(nums1, [-1,0,0,1,2,2,3,3,3])
    }
}

TestCase.defaultTestSuite.run()


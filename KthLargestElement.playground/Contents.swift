/*
 Given an integer array nums and an integer k, return the kth largest element in the array.

 Note that it is the kth largest element in the sorted order, not the kth distinct element.

 Example 1:

 Input: nums = [3,2,1,5,6,4], k = 2
 Output: 5

 Example 2:

 Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
 Output: 4

 Constraints:

     1 <= k <= nums.length <= 104
     -104 <= nums[i] <= 104
 */

import XCTest

func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var mutatingNums = nums
    let size = mutatingNums.count
    return quickSelect(&mutatingNums, start: 0, end: size-1, k: size-k)
}

private func quickSelect(_ nums: inout [Int], start: Int, end: Int, k: Int) -> Int {
    if (start == end) { return nums[start] }
    let p = partition(&nums, start, end)
    if p == k { return nums[p] }
    if k < p { return quickSelect(&nums, start: start, end: p-1, k: k) }
    return quickSelect(&nums, start: p+1, end: end, k: k)
}

private func partition(_ nums: inout [Int], _ start: Int, _ end: Int)->Int{
    let randomIndex = Int.random(in: start...end)
    swap(&nums, start, randomIndex)
    var left = start
    for i in start+1...end{
        if nums[i] < nums[start] {
            left += 1
            swap(&nums, left, i)
        }
    }
    swap(&nums, start, left)
    return left
}

private func swap(_ nums: inout [Int], _ i:Int, _ j:Int){
    let item = nums[i]
    nums[i] = nums[j]
    nums[j] = item
}

class TestCase: XCTestCase {
    func testStandardInput() {
        XCTAssertEqual(findKthLargest([3,2,1,5,6,4], 2), 5)
    }

    func testRepeatedValuesInput() {
        XCTAssertEqual(findKthLargest([3,2,3,1,2,4,5,5,6], 4), 4)
    }

    func testOneElementInput() {
        XCTAssertEqual(findKthLargest([3], 1), 3)
    }
}

TestCase.defaultTestSuite.run()

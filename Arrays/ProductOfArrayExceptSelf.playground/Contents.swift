/*
 Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

 You must write an algorithm that runs in O(n) time and without using the division operation.

 Example 1:
 Input: nums = [1,2,3,4]
 Output: [24,12,8,6]

 Example 2:
 Input: nums = [-1,1,0,-3,3]
 Output: [0,0,9,0,0]

 Constraints:
     2 <= nums.length <= 105
     -30 <= nums[i] <= 30
     The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

 Follow up: Can you solve the problem in O(1) extra space complexity? (The output array does not count as extra space for space complexity analysis.)
 */

import XCTest

final class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        /*
        First approach is keeping two arrays, one with the result of accumulated products starting from the left, and the other one keeping the result of accumulated products starting from the right. Then, to calculate the result array, it is only needed to multiplicate, for each index, the index of the left array with the index of the right array.
        To solve it with O(1) extra space complexity, instead keeping two arrays, one for each direction, we first calculate the accumulated products from left to right and then, we overwrite it while going from right to left, keeping only one extra variable that keeps the last product calculated
        */
        guard nums.count > 1 else {
            return []
        }

        var product = 1
        var result: [Int] = Array(repeating: 1, count: nums.count)

        // From left to right: reuse the product from previous entries for subsequent entries
        for i in 0..<nums.count {
            result[i] = product
            product *= nums[i]
        }

        product = 1
        // From right to left: resue the products from previous entries
        for i in (0..<nums.count).reversed() {
            result[i] *= product
            product *= nums[i]
        }
        return result
    }
}

final class TestCase: XCTestCase {

    let sol = Solution()

    func testIncreasingOrderArray() {
        let result = sol.productExceptSelf([1, 2, 3, 4])
        XCTAssertEqual(result, [24, 12, 8, 6])
    }

    func testWithZero() {
        let result = sol.productExceptSelf([-1, 1, 0, -3, 3])
        XCTAssertEqual(result, [0, 0, 9, 0, 0])
    }

    func testNegativeNumbers() {
        let result = sol.productExceptSelf([-1, 1, -3, 3])
        XCTAssertEqual(result, [-9, 9, -3, 3])
    }
}

TestCase.defaultTestSuite.run()

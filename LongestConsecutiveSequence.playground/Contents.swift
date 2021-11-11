 /*
  Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.

  You must write an algorithm that runs in O(n) time.

  Example 1:
  Input: nums = [100,4,200,1,3,2]
  Output: 4
  Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.

  Example 2:
  Input: nums = [0,3,7,2,5,8,4,6,0,1]
  Output: 9

  Constraints:
      0 <= nums.length <= 105
      -109 <= nums[i] <= 109
  */

import XCTest

func longestConsecutive(_ nums: [Int]) -> Int {
    let set = Set(nums)
    var maxLength = 0

    for num in nums {
        if !set.contains(num - 1) {
            var currentLength = 1
            var temp = num + 1

            while set.contains(temp) {
                currentLength += 1
                temp += 1
            }

            maxLength = max(maxLength, currentLength)
        }
    }

    return maxLength

/*
    Time complexity : O(n).

    Although the time complexity appears to be quadratic due to the while loop nested within the for loop, closer inspection reveals it to be linear. Because the while loop is reached only when currentNum marks the beginning of a sequence (i.e. currentNum-1 is not present in nums), the while loop can only run for nnn iterations throughout the entire runtime of the algorithm. This means that despite looking like O(n⋅n) complexity, the nested loops actually run in O(n+n)=O(n) time. All other computations occur in constant time, so the overall runtime is linear.

    Space complexity : O(n).

    In order to set up O(1) containment lookups, we allocate linear space for a hash table to store the O(n) numbers in nums. Other than that, the space complexity is identical to that of the brute force solution.
  */
}

class TestCase: XCTestCase {
    func testRegular() {
        XCTAssertEqual(longestConsecutive([100,4,200,1,3,2]), 4)
    }

    func testRepeatingNum() {
        XCTAssertEqual(longestConsecutive([0,3,7,2,5,8,4,6,0,1]), 9)
    }

    func testNoSequence() {
        XCTAssertEqual(longestConsecutive([7,5,3,1,20]), 1)
    }

    func testOneElement() {
        XCTAssertEqual(longestConsecutive([1]), 1)
    }

    func testZeroElements() {
        XCTAssertEqual(longestConsecutive([]), 0)
    }
}

TestCase.defaultTestSuite.run()

 class HashMapSolution {
    // Time complexity: O(n)
    // Space complexity: O(n)
    func longestConsecutive(_ nums: [Int]) -> Int {
         var countMap = [Int: Int]()
         var result = 0
         for num in nums {
             if countMap[num] == nil {
                 let leftSum = countMap[num - 1] ?? 0
                 let rightSum = countMap[num + 1] ?? 0
                 let streak = leftSum + rightSum + 1
                 countMap[num] = streak
                 if leftSum != 0 { countMap[num-leftSum] = streak }
                 if rightSum != 0 { countMap[num+rightSum] = streak }
                 result = max(result, streak)

             }
         }
         return result
     }
 }

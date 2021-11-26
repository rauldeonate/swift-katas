/*
 Given an integer n, return the number of prime numbers that are strictly less than n.

 Example 1:

 Input: n = 10
 Output: 4
 Explanation: There are 4 prime numbers less than 10, they are 2, 3, 5, 7.

 Example 2:

 Input: n = 0
 Output: 0

 Example 3:

 Input: n = 1
 Output: 0

 Constraints:
     0 <= n <= 5 * 106
 */

import XCTest

final class Solution {
    func countPrimes(_ n: Int) -> Int {
        /*
         Using Sieve of Eratosthenes, we create a list of all numbers from 2 to n. Then, we will mark all the numbers which are divisible by 2 and are greater than or equal to the square of it. Later, we move to our next unmarked number 3 and mark all the numbers which are multiples of 3 and are greater than or equal to the square of it. Afterwards, we move to our next unmarked number 5 and mark all multiples of 5 and are greater than or equal to the square of it. In the end we continue this process for the rest of unmarked numbers until n
         */

        guard n > 2 else { return 0 }
        var isPrime = Array(repeating: true, count: n)

        // Numbers 0 and 1 are not primes
        isPrime[0] = false
        isPrime[1] = false
        var count = 0

        for i in 2..<n {
            guard isPrime[i] else { continue }
            count += 1

            var index = i * i
            while index < n {
                isPrime[index] = false
                index += i
            }
        }
        return count
    }
}

final class TestCase: XCTestCase {

    let sol = Solution()

    func testTen() {
        XCTAssertEqual(sol.countPrimes(10), 4)
    }

    func testZero() {
        XCTAssertEqual(sol.countPrimes(0), 0)
    }

    func testOne() {
        XCTAssertEqual(sol.countPrimes(1), 0)
    }

    func testTwo() {
        XCTAssertEqual(sol.countPrimes(2), 0)
    }

    func testOneHundred() {
        XCTAssertEqual(sol.countPrimes(100), 25)
    }
}

TestCase.defaultTestSuite.run()

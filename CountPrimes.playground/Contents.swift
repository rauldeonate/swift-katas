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

func countPrimes(_ n: Int) -> Int {
    guard n > 2 else { return 0 }
    var isPrime = Array(repeating: true, count: n)

    // Numbers 0 and 1 are not primes
    isPrime[0] = false
    isPrime[1] = false
    var count = 0

    for i in 2..<n {
        // Using Sieve of Eratosthenes to reduce time complexity
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

class TestCase: XCTestCase {
    func testTen() {
        XCTAssertEqual(countPrimes(10), 4)
    }

    func testZero() {
        XCTAssertEqual(countPrimes(0), 0)
    }

    func testOne() {
        XCTAssertEqual(countPrimes(1), 0)
    }

    func testTwo() {
        XCTAssertEqual(countPrimes(2), 0)
    }

    func testOneHundred() {
        XCTAssertEqual(countPrimes(100), 25)
    }
}

TestCase.defaultTestSuite.run()

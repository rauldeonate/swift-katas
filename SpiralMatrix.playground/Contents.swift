/*
 Given an m x n matrix, return all elements of the matrix in spiral order.

 Example 1:
 Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
 Output: [1,2,3,6,9,8,7,4,5]

 Example 2:
 Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
 Output: [1,2,3,4,8,12,11,10,9,5,6,7]

 Constraints:
     m == matrix.length
     n == matrix[i].length
     1 <= m, n <= 10
     -100 <= matrix[i][j] <= 100
 */

import XCTest

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    guard  !matrix.isEmpty else {
        return []
    }
    var top = 0
    var bottom = matrix.count - 1
    var left = 0
    var right = matrix[0].count - 1
    let count = matrix.count * matrix[0].count
    var result = [Int]()
    while result.count < count {
        for i in stride(from: left, to: right+1, by: 1) where result.count < count {
            result.append(matrix[top][i])
        }
        top += 1
        for i in stride(from: top, to: bottom+1, by: 1) where result.count < count {
            result.append(matrix[i][right])
        }
        right -= 1
        for i in stride(from: right, to: left-1, by: -1) where result.count < count {
            result.append(matrix[bottom][i])
        }
        bottom -= 1
        for i in stride(from: bottom, to: top-1, by: -1) where result.count < count {
            result.append(matrix[i][left])
        }
        left += 1
    }
    return result
}

class TestCase: XCTestCase {
    func testThreeXThree() {
        XCTAssertEqual(
            spiralOrder([[1,2,3],[4,5,6],[7,8,9]]),
            [1,2,3,6,9,8,7,4,5]
        )
    }

    func testThreeXFour() {
        XCTAssertEqual(
            spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]]),
            [1,2,3,4,8,12,11,10,9,5,6,7]
        )
    }

    func testEmpty() {
        XCTAssertEqual(
            spiralOrder([]),
            []
        )
    }

    func testOne() {
        XCTAssertEqual(
            spiralOrder([[1]]),
            [1]
        )
    }
}

TestCase.defaultTestSuite.run()

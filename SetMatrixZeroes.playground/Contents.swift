 /*
  Given an m x n integer matrix matrix, if an element is 0, set its entire row and column to 0's, and return the matrix.

  You must do it in place.

  Example 1:
  Input: matrix = [[1,1,1],[1,0,1],[1,1,1]]
  Output: [[1,0,1],[0,0,0],[1,0,1]]

  Example 2:
  Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
  Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]

  Constraints:
      m == matrix.length
      n == matrix[0].length
      1 <= m, n <= 200
      -231 <= matrix[i][j] <= 231 - 1
  */

import XCTest

func setZeroes(_ matrix: inout [[Int]]) {
    guard matrix.count > 0 else { return }
    guard matrix[0].count > 0 else { return }

    let rows = matrix.count
    let columns = matrix[0].count

    var firstRow = false
    var firstColumn = false

    for i in 0..<rows {
        for j in 0..<columns {
            if matrix[i][j] == 0 {
                if i == 0 { firstRow = true }
                if j == 0 { firstColumn = true }
                matrix[i][0] = 0
                matrix[0][j] = 0
            }
        }
    }

    for i in 1..<rows {
        if matrix[i][0] == 0 {
            for j in 0..<matrix[i].count {
                matrix[i][j] = 0
            }
        }
    }
    for j in 1..<columns {
        if matrix[0][j] == 0 {
            for i in 0..<matrix.count {
                matrix[i][j] = 0
            }
        }
    }

    if firstRow == true {
        for j in 0..<matrix[0].count {
            matrix[0][j] = 0
        }
    }
    if firstColumn == true {
        for i in 0..<matrix.count {
            matrix[i][0] = 0
        }
    }
}

class TestCase: XCTestCase {
    func testZeroInCenter() {
        var matrix = [[1,1,1],[1,0,1],[1,1,1]]
        setZeroes(&matrix)
        XCTAssertEqual(matrix, [[1,0,1],[0,0,0],[1,0,1]])
    }

    func testZeroCorners() {
        var matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
        setZeroes(&matrix)
        XCTAssertEqual(matrix, [[0,0,0,0],[0,4,5,0],[0,3,1,0]])
    }
}

TestCase.defaultTestSuite.run()

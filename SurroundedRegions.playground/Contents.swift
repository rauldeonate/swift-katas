 /*
  Given an m x n matrix board containing 'X' and 'O', capture all regions that are 4-directionally surrounded by 'X'.

  A region is captured by flipping all 'O's into 'X's in that surrounded region.

  Example 1:
  Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
  Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
  Explanation: Surrounded regions should not be on the border, which means that any 'O' on the border of the board are not flipped to 'X'. Any 'O' that is not on the border and it is not connected to an 'O' on the border will be flipped to 'X'. Two cells are connected if they are adjacent cells connected horizontally or vertically.

  Example 2:
  Input: board = [["X"]]
  Output: [["X"]]

  Constraints:
      m == board.length
      n == board[i].length
      1 <= m, n <= 200
      board[i][j] is 'X' or 'O'.
  */

import XCTest

func solve(_ board: inout [[Character]]) {
    guard board.count > 0 else { return }
    let rows = board.count
    let cols = board[0].count

    //Check for the letter O in the first coloum and last coloumn of every row and apply DFS
    //which converts all the O's on the boundary and their connected O's to Y

    for row in 0 ..< rows {
        if board[row][0] == "O" {
            dfs(board: &board, row: row, col: 0)
        }
        if board[row][cols-1] == "O" {
            dfs(board: &board, row: row, col: cols-1)
        }
     }

     // Check for the letter O in the first row and last row of every coloumn and apply DFS
     // which converts all the O's on the boundary and their connected O's to Y
     for col in 0 ..< cols {
         if board[0][col] == "O" {
             dfs(board: &board, row: 0, col: col)
         }
         if board[rows-1][col] == "O" {
             dfs(board: &board, row: rows-1, col: col)
         }
     }

     // Now loop through the entire board and convert the Y's back to O and convert the O's to X
     for row in 0 ..< rows {
         for col in 0 ..< cols {
             if board[row][col] == "O" {
                 board[row][col] = "X"
             }
             if board[row][col] == "Y" {
                  board[row][col] = "O"
             }
         }
     }
 }

func dfs(board: inout [[Character]], row: Int, col: Int) {
    if row < 0 || row >= board.count || col < 0 || col >= board[0].count || board[row][col] == "Y" || board[row][col] == "X" {
        // Checking for boundary conditions
        // Already visited points are marked as Y
        // Return if the point contains X
        return
    }

    board[row][col] = "Y"

    // Traverse in all 4 directions : top / down / left / right
    dfs(board: &board, row: row + 1, col: col)
    dfs(board: &board, row: row - 1, col: col)
    dfs(board: &board, row: row, col: col + 1)
    dfs(board: &board, row: row, col: col - 1)
}

class TestCase: XCTestCase {
    func testStandardInput() {
        var matrix: [[Character]] = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
        solve(&matrix)
        XCTAssertEqual(
            matrix, [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
        )
    }

    func testThreeXThree() {
        var matrix: [[Character]] = [["X","O","X"],["X","O","X"],["X","O","X"]]
        solve(&matrix)
        XCTAssertEqual(
            matrix, [["X","O","X"],["X","O","X"],["X","O","X"]]
        )
    }
}

TestCase.defaultTestSuite.run()

import XCTest

/*
 Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

 An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

 Example 1:
 Input: grid = [
   ["1","1","1","1","0"],
   ["1","1","0","1","0"],
   ["1","1","0","0","0"],
   ["0","0","0","0","0"]
 ]
 Output: 1

 Example 2:
 Input: grid = [
   ["1","1","0","0","0"],
   ["1","1","0","0","0"],
   ["0","0","1","0","0"],
   ["0","0","0","1","1"]
 ]
 Output: 3

 */

func numIslands(_ grid: [[Character]]) -> Int {
    var numIslands = 0
    var mutableGrid = grid
    for i in 0..<mutableGrid.count {
        for j in 0..<mutableGrid[i].count {
            if mutableGrid[i][j] == "1" {
                numIslands += 1
                print(grid)
                searchPoint(grid: &mutableGrid, x: i, y: j)
            }
        }
    }

    return numIslands
}

func searchPoint(grid: inout [[Character]], x: Int, y: Int) {
    grid[x][y] = "0"
    if y+1 < grid[x].count {
        if grid[x][y+1] == "1" {
            searchPoint(grid: &grid, x: x, y: y+1)
        }
    }
    if x+1 < grid.count {
        if grid[x+1][y] == "1" {
            searchPoint(grid: &grid, x: x+1, y: y)
        }
    }
    if x-1 >= 0 {
        if grid[x-1][y] == "1" {
            searchPoint(grid: &grid, x: x-1, y: y)
        }
    }
    if y-1 >= 0 {
        if grid[x][y-1] == "1" {
            searchPoint(grid: &grid, x: x, y: y-1)
        }
    }
}

class TestCase: XCTestCase {

    func testSuccessSingleIsland() {
        XCTAssertEqual(numIslands([
            ["1","1","1","1","0"],
            ["1","1","0","1","0"],
            ["1","1","0","0","0"],
            ["0","0","0","0","0"]
          ]), 1)
    }

    func testSuccessWithDiagonal() {
        XCTAssertEqual(numIslands([
            ["1","1","0","0","0"],
            ["1","1","0","0","0"],
            ["0","0","1","0","0"],
            ["0","0","0","1","1"]
          ]), 3)
    }

    func testEmptyInput() {
        XCTAssertEqual(numIslands([
          ]), 0)
    }

    func testWrongInput() {
        XCTAssertEqual(numIslands([
            ["2","0"],
            ["0","a"]
          ]), 0)
    }

    func testPreviousTerrain() {
        XCTAssertEqual(numIslands([
            ["1","1","1"],
            ["0","1","0"],
            ["1","1","1"]
        ]), 1)
    }
}

TestCase.defaultTestSuite.run()

 /*
  Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

  Example 1:
  Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
  Output: [[1,6],[8,10],[15,18]]
  Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].

  Example 2:
  Input: intervals = [[1,4],[4,5]]
  Output: [[1,5]]
  Explanation: Intervals [1,4] and [4,5] are considered overlapping.

  Constraints:
      1 <= intervals.length <= 104
      intervals[i].length == 2
      0 <= starti <= endi <= 104
  */

import XCTest

func merge(_ intervals: [[Int]]) -> [[Int]] {
    guard intervals.count > 1 else { return intervals }

    let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
    var result: [[Int]] = []

    var candidateToMerge = sortedIntervals[0]
    for i in 1..<sortedIntervals.count {
        if candidateToMerge[1] >= sortedIntervals[i][0] {
            candidateToMerge = [candidateToMerge[0], max(candidateToMerge[1], sortedIntervals[i][1])]
        } else {
            result.append(candidateToMerge)
            candidateToMerge = sortedIntervals[i]
        }
    }
    result.append(candidateToMerge)
    return result
}

class TestCase: XCTestCase {
    func testOverlappingMiddle() {
        XCTAssertEqual(merge([[1,3],[2,6],[8,10],[15,18]]), [[1,6],[8,10],[15,18]])
    }

    func testOverlappingLimit() {
        XCTAssertEqual(merge([[1,4],[4,5]]), [[1,5]])
    }

    func testTripleOverlapping() {
    XCTAssertEqual(merge([[1,3],[2,6],[5,10],[15,18]]), [[1,10],[15,18]])
    }

    func testOverlappingFirstIndex() {
        XCTAssertEqual(merge([[5,8],[1,6],[15,18]]), [[1,8],[15,18]])
    }

    func testNoOverlapping() {
        XCTAssertEqual(merge([[5,8],[1,4]].sorted(by: { $0[0] < $1[0]})), [[5,8],[1,4]].sorted(by: { $0[0] < $1[0]}))
    }

    func testSameInterval() {
        XCTAssertEqual(merge([[1,4],[1,4]]), [[1,4]])
    }

    func testWithinInterval() {
        XCTAssertEqual(merge([[1,4],[2,3]]), [[1,4]])
    }
}

TestCase.defaultTestSuite.run()

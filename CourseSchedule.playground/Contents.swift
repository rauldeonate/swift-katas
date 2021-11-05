/*
 There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

     For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.

 Return true if you can finish all courses. Otherwise, return false.

 Example 1:

 Input: numCourses = 2, prerequisites = [[1,0]]
 Output: true
 Explanation: There are a total of 2 courses to take.
 To take course 1 you should have finished course 0. So it is possible.

 Example 2:

 Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
 Output: false
 Explanation: There are a total of 2 courses to take.
 To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.

 Constraints:

     1 <= numCourses <= 105
     0 <= prerequisites.length <= 5000
     prerequisites[i].length == 2
     0 <= ai, bi < numCourses
     All the pairs prerequisites[i] are unique.
 */

import XCTest

func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    // Recursive DFS

    var preCourses = [Int:[Int]]()
    for relation in prerequisites {
        preCourses[relation[0], default: []].append(relation[1])
    }

    var isVisited = [Int:Bool]()
    // Go through each courses iteratively, and find if there is any circle case, if so, return false
    for course in preCourses.keys {
        guard dfs(preCourses, course, &isVisited) else { return false }
    }
    return true
}

private func dfs(_ preCourses: [Int:[Int]], _ course: Int, _ isVisited: inout [Int:Bool]) -> Bool {
    // Check if we have visited this course before;
    // When not fully visited, which means has circle, return false
    // When fully visited, return true
    if let fullyVisited = isVisited[course] { return fullyVisited }

    // Mark as start visit this course, but not finished yet
    isVisited[course] = false

    for preCourse in preCourses[course] ?? [] {
        // Go through every case, and see if there occur circles
        guard dfs(preCourses, preCourse, &isVisited) else { return false }
    }

    // Fully check, no circles
    isVisited[course] = true

    return true
}

func canFinishTopologicalSort(_ total: Int, _ nums: [[Int]]) -> Bool {
    // Topological Sort BFS
    var dict = [Int: [Int]]()
    var indegree = Array(repeating: 0, count: total)
    for num in nums {
        indegree[num[0]] += 1
        dict[num[1], default: []].append(num[0])
    }
    var count = 0
    var queue: [Int] = []
    for (index, num) in indegree.enumerated() {
        if num == 0 {
            queue.append(index)
        }
    }
    while !queue.isEmpty {
        let num = queue.removeFirst()
        count += 1
        if let courses = dict[num] {
            for course in courses {
                indegree[course] -= 1
                if indegree[course] == 0 {
                    queue.append(course)
                }
            }
        }
    }
    return count == total
}

class TestCase: XCTestCase {
    func testTwoPrerequisitesClash() {
        XCTAssertEqual(canFinish(2, [[1,0],[0,1]]), false)
    }

    func testBasicCircularDependency() {
        XCTAssertEqual(canFinish(3, [[1,0],[0,2],[2,1]]), false)
    }

    func testFourRequisitesCircularClash() {
        XCTAssertEqual(canFinish(4, [[0,2],[1,0],[2,3],[3,1]]), false)
    }

    func testTwentyPrerequitesClash() {
        XCTAssertEqual(canFinish(20, [[0,10],[3,18],[5,5],[6,11],[11,14],[13,1],[15,1],[17,4]]), false)
    }

    func testFourPrerequisitesNoClash() {
        XCTAssertEqual(canFinish(5, [[1,4],[2,4],[3,1],[3,2]]), true)
    }

    func testTwoPrerequisitesClashTopologicalSort() {
        XCTAssertEqual(canFinishTopologicalSort(2, [[1,0],[0,1]]), false)
    }

    func testBasicCircularDependencyTopologicalSort() {
        XCTAssertEqual(canFinishTopologicalSort(3, [[1,0],[0,2],[2,1]]), false)
    }

    func testFourRequisitesCircularClashTopologicalSort() {
        XCTAssertEqual(canFinishTopologicalSort(4, [[0,2],[1,0],[2,3],[3,1]]), false)
    }

    func testTwentyPrerequitesClashTopologicalSort() {
        XCTAssertEqual(canFinishTopologicalSort(20, [[0,10],[3,18],[5,5],[6,11],[11,14],[13,1],[15,1],[17,4]]), false)
    }

    func testFourPrerequisitesNoClashTopologicalSort() {
        XCTAssertEqual(canFinishTopologicalSort(5, [[1,4],[2,4],[3,1],[3,2]]), true)
    }
}

TestCase.defaultTestSuite.run()

 /*
  You are given an integer array prices where prices[i] is the price of a given stock on the ith day.

  On each day, you may decide to buy and/or sell the stock. You can only hold at most one share of the stock at any time. However, you can buy it then immediately sell it on the same day.

  Find and return the maximum profit you can achieve.

  Example 1:
  Input: prices = [7,1,5,3,6,4]
  Output: 7
  Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
  Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
  Total profit is 4 + 3 = 7.

  Example 2:
  Input: prices = [1,2,3,4,5]
  Output: 4
  Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
  Total profit is 4.

  Example 3:
  Input: prices = [7,6,4,3,1]
  Output: 0
  Explanation: There is no way to make a positive profit, so we never buy the stock to achieve the maximum profit of 0.

  Constraints:
      1 <= prices.length <= 3 * 104
      0 <= prices[i] <= 104
  */

import XCTest

func maxProfit(_ prices: [Int]) -> Int {
    /*
     First valid approach:
    If we analyze the graph, we notice that the points of interest are the consecutive valleys and peaks.

    Mathematically speaking: TotalProfit=∑i(height(peaki)−height(valleyi))

    The key point is we need to consider every peak immediately following a valley to maximize the profit. In case we skip one of the peaks (trying to obtain more profit), we will end up losing the profit over one of the transactions leading to an overall lesser profit.

    For example, in the above case, if we skip peaki and valleyj trying to obtain more profit by considering points with more difference in heights, the net profit obtained will always be lesser than the one obtained by including them, since CCC will always be lesser than A+BA+BA+B.

     Second valid approach:
     This solution follows the logic used in Approach 2 itself, but with only a slight variation. In this case, instead of looking for every peak following a valley, we can simply go on crawling over the slope and keep on adding the profit obtained from every consecutive transaction. In the end,we will be using the peaks and valleys effectively, but we need not track the costs corresponding to the peaks and valleys along with the maximum profit, but we can directly keep on adding the difference between the consecutive numbers of the array if the second number is larger than the first one, and at the total sum we obtain will be the maximum profit. This approach will simplify the solution.
  */

    var profit = 0
    var i = 1
    while i < prices.count {
        if prices[i] > prices[i-1] {
            profit += prices[i] - prices[i-1]
        }
        i += 1
    }
    return profit
}

class TestCase: XCTestCase {
    func testRegular() {
        XCTAssertEqual(maxProfit([7,1,5,3,6,4]), 7)
    }

    func testIncreasingArray() {
        XCTAssertEqual(maxProfit([1,2,3,4,5]), 4)
    }

    func testDecreasingArray() {
        XCTAssertEqual(maxProfit([7,6,4,3,1]), 0)
    }

    func testOneElement() {
        XCTAssertEqual(maxProfit([5]), 0)
    }
}

TestCase.defaultTestSuite.run()

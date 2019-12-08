/*
josephus_survivor(7,3) => means 7 people in a circle;
one every 3 is eliminated until one remains
[1,2,3,4,5,6,7] - initial sequence
[1,2,4,5,6,7] => 3 is counted out
[1,2,4,5,7] => 6 is counted out
[1,4,5,7] => 2 is counted out
[1,4,5] => 7 is counted out
[1,4] => 5 is counted out
[4] => 1 counted out, 4 is the last element - the survivor!
 
assume that both n and k will always be >=1
*/

import XCTest

func populatePeopleArray(n: Int) -> [Int] {
    var array: [Int] = []
    for i in 1...n {
        array.append(i)
    }
    return array
}

func josephusSurvivor(n: Int, k: Int) -> Int? {
    guard n > 0, k > 0 else { return nil }
    var array = populatePeopleArray(n: n)
    print(array)
    var indexToKill: Int = 0
    repeat {
        if indexToKill >= array.count {
            indexToKill = 0
        }
        indexToKill = indexToKill + k-1
        var diff = indexToKill - array.count
        while diff >= 0 {
            indexToKill = diff
            diff = indexToKill - array.count
        }
        array.remove(at: indexToKill)
        print(array)
    } while array.count > 1
    
    return array.first ?? nil
}

XCTAssertEqual(josephusSurvivor(n: 7, k: 3), 4)
XCTAssertEqual(josephusSurvivor(n: 11, k: 5), 8)
XCTAssertEqual(josephusSurvivor(n: 5, k: 7), 4)
XCTAssertEqual(josephusSurvivor(n: 5, k: -1), nil)
XCTAssertEqual(josephusSurvivor(n: 0, k: 2), nil)
XCTAssertEqual(josephusSurvivor(n: 0, k: -1), nil)

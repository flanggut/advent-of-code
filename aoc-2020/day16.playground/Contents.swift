import Foundation
let file = "/Users/flanggut/Downloads/day16.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()

/// Parse input
var ranges : [String: [(Int, Int)]] = [:]
var line = 0
while input[line].count > 1 {
    let split = input[line].components(separatedBy: ": ")
    let split2 = split[1].components(separatedBy: " or ")
    let name = String(split[0])
    for range in split2 {
        let value1 = Int(range.split(separator: "-")[0])!
        let value2 = Int(range.split(separator: "-")[1])!
        ranges[name, default: []].append((value1, value2))
    }
    line += 1
}
line += 2
let myticket = input[line].split(separator: ",").map({Int($0)!})
print("MyTicket: \(myticket)")
line += 3
let numberCount = myticket.count

/// Part 1
var validTickets : [[Int]] = []
var result : Int = 0

/// Return true if number is in any range
func isNumInRanges(all : [String: [(Int, Int)]], num: Int) -> Bool {
    for (_, ranges) in all {
        for r in ranges {
            if r.0...r.1 ~= num {
                return true
            }
        }
    }
    return false;
}

for i in line..<input.count {
    let numbersOnTicket = input[i].split(separator: ",").map({Int($0)!})
    var valid = true
    for number in numbersOnTicket {
        if !isNumInRanges(all: ranges, num: number) {
            result += number
            valid = false
        }
    }
    if valid {
        validTickets.append(numbersOnTicket)
    }
}
print("Part1: \(result)")

/// Part 2
let validNames = Set(ranges.map({$0.0}))
var validNamesForId = Array(repeating: validNames, count: numberCount)

/// Return all ranges where the number does not appear
func missingInRanges(all : [String: [(Int, Int)]], num: Int) -> Set<String> {
    var res : Set<String> = []
    for (name, ranges) in all {
        var isIn = false
        for r in ranges {
            isIn = isIn || r.0...r.1 ~= num
        }
        if !isIn {
            res.insert(name)
        }
    }
    return res;
}

for ticket in validTickets {
    for (i, number) in ticket.enumerated() {
        validNamesForId[i].subtract(missingInRanges(all: ranges, num: number))
    }
}

var counter : [String : [Int]] = [:]
for (i, val) in validNamesForId.enumerated() {
    for name in val {
        counter[name, default: []].append(i)
    }
}

var filtered : Set<String> = []
var needFilter = true
while needFilter {
    needFilter = false
    var fname : String = ""
    var fnum : Int = -1
    for (name, list) in counter {
        if  list.count == 1 && !filtered.contains(name) {
            needFilter = true
            filtered.insert(name)
            fname = name
            fnum = list[0]
            break
        }
    }
    if needFilter {
        print(fname)
        for (name, list) in counter {
            if name != fname {
                counter[name] = list.filter({$0 != fnum})
            }
        }
    }
}

print(counter.filter({$0.key.hasPrefix("departure")}))
print("Part2: \(counter.filter({$0.key.hasPrefix("departure")}).reduce(1, {$0 * myticket[$1.value[0]]}))")

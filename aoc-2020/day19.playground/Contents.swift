import Foundation
//let file = "/Users/flanggut/Downloads/day19.txt"
let file = "/Users/flanggut/Downloads/day19-2.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")



// Parse rules
struct Rule {
    var c : Character = " "
    var others : [[Int]] = []
}

var line = 0
var rules : [Int: Rule] = [:]

while input[line].count > 0 {
    let str = input[line]
    let split = str.components(separatedBy: ": ")
    let id = Int(split[0])!
    if split[1].contains("\"") {
        let cc = split[1].split(separator: "\"")
        rules[id] = Rule(c: Array(cc[0])[0], others: [])
    } else {
        let cc = split[1].components(separatedBy: " | ")
        var o : [[Int]] = []
        for comp in cc {
            o.append(comp.split(separator: " ").map({Int($0)!}))
        }
        rules[id] = Rule(c: " ", others: o)
    }
    line += 1
}

print(rules)
line += 1

// Match a rule recursively
func matchRule(m : [Character], test : [Int], start : Int) -> [Int]? {
    var index = start
    var positions : [Int] = []
    for (i, r) in test.enumerated() {
        if rules[r]!.c != " " {
            if index >= m.count || m[index] != rules[r]!.c {
                return nil
            }
            index = index + 1
        } else {
            var matches : [Int] = []
            for tests in rules[r]!.others {
                if let result = matchRule(m: m, test: tests, start: index) {
                    matches = matches + result
                }
            }
            if matches.isEmpty {
                return nil
            } else {
                for id in matches {
                    if let result = matchRule(m: m, test: Array(test.dropFirst(i + 1)), start: id) {
                        positions = positions + result
                    }
                }
                if positions.isEmpty {
                    return nil
                }
                break
            }
        }
    }
    return positions.isEmpty ? [index] : positions
}

func checkString (m : String) -> Bool {
    let a = Array(m)
    for next in rules[0]!.others {
        if let result = matchRule(m: a, test: next, start: 0) {
            if (result.contains(a.count)) {
                print(result)
                return true
            }
        }
    }
    return false
}

var result : Int = 0
for i in line..<input.count {
    print(input[i])
    result += checkString(m: input[i]) ? 1 : 0
}

print(result)


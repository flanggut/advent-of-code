import Foundation
let file = "/Users/flanggut/Downloads/day13.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    //    let c = String(element) ~= "[BF]{7}"
}

//let matrix = input.map({Array($0)})
//let numbers = input.map({Int($0) ?? -1})

var state : Int64 = 0
var result : Int64 = 0

let minutes = Int(input[0])!
print("Minutes: \(minutes)")

let busIds = input[1].split(separator: ",")
print(busIds)

var best = 1000000000
var bestId = 0

func findNewStart (start: Int64, a : Int64, b : Int64, diff : Int64)  -> Int64 {
    print("Start \(start) \(a) \(b) \(diff)")
    var d : Int64 = 0
    var q = start
    var w = (start / b) * b
    let wInc = ((a - diff) / b) * b
    while d != diff {
        d = w - q
        if (d > diff) {
            q += a
            w += wInc
        } else {
            w += b
        }
    }
    return q
}

var period : Int64 = 1
var start : Int64 = 0
for (i, id) in busIds.enumerated() {
    if let m = Int64(id) {
        print("\(i), \(m)")
        start = findNewStart(start : start, a: period, b: m, diff: Int64(i))
        period = m * period
    }
}
print(start)


print("State: \(state), Result \(result)")

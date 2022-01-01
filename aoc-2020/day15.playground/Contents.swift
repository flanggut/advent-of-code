import Foundation
///"1,20,8,12,0,14"
let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()

let start = input[0].split(separator: ",").map({Int($0)!})
print(start)

var turnForNumber : [Int:Int] = [:]
var result : Int = 0
var nextNumber : Int = 0
for i in 1...2020 {
    result = nextNumber
    nextNumber = 0
    if i <= start.count {
        if let value = turnForNumber[start[i - 1]] {
            nextNumber = i - value
        }
        turnForNumber[start[i - 1]] = i
    } else {
        if let value = turnForNumber[result] {
            nextNumber = i - value
        }
        turnForNumber[result] = i
    }
}

print("Result: \(result)")

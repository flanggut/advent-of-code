import Foundation
let file = "/Users/flanggut/Downloads/day9.txt"
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

let numbers = input.map({Int($0) ?? -1})
//print(numbers)
//let list = Set(input.map({Int($0) ?? -1}))

//for i in 0...8 {
//  print(numbers[i])
//}

//var toSwitch : String = " "
//switch toSwitch {
//case " " : print("yes")
//default: print("WHAT")
//}


//var chars = Set<Character>()
//var numbers = Set<Int>()
var state : Int = 0
var result : Int = 0

let pSize = 25

var current : [Int] = []

func findPairWithSum(set: Set<Int>, sum: Int) -> Set<Int> {
    var solution : Set<Int> = Set()
    for number in set {
        let diff = sum - number
        if set.contains(diff) {
            solution.insert(diff)
        }
    }
    return solution
}

var error : Int = -1
for i in pSize..<numbers.count {
    if findPairWithSum(set: Set(numbers[i - pSize..<i]), sum: numbers[i]).count == 0 {
        error = numbers[i]
        break
    }
}

print("Error: \(error)")

var start = 0
var end = 0
var sum = numbers[0]
while sum != error {
    if sum < error {
        end += 1
        sum += numbers[end]
    } else {
        sum -= numbers[start]
        start += 1
    }
}

print(numbers[start...end].min()! + numbers[start...end].max()!)

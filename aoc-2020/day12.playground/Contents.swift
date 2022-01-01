import Foundation
let file = "/Users/flanggut/Downloads/day12.txt"
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
//let numbers = input.map({Int($0) ?? -1})

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

var dirX = 10
var dirY = 1

var stateX = 0
var stateY = 0

for line in input {
    let action = Array(line)[0]
    let number = Int(line.dropFirst()) ?? -1
    
    switch action {
    case "F" :
        stateX += dirX * number
        stateY += dirY * number
    case "N" :
        dirY += number
    case "S" :
        dirY -= number
    case "E" :
        dirX += number
    case "W" :
        dirX -= number
    case "L" :
        for _ in 1...(number / 90) % 4 {
            swap(&dirX, &dirY)
            dirX = -dirX
        }
    case "R" :
        for _ in 1...(number / 90) % 4 {
            swap(&dirX, &dirY)
            dirY = -dirY
        }
    default: print("WHAT")
    }
    
    print("Dir: \(dirX), \(dirY)")
    print("State: \(stateX), \(stateY)")
}

print("State: \(stateX), \(stateY)")
print(abs(stateX) + abs(stateY))

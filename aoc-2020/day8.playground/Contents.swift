import Foundation

let file = "/Users/flanggut/Downloads/day8.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines)
print(input)

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    //    let c = String(element) ~= "[BF]{7}"
}

//let matrix = input.map({Array($0)})
//let list = Set(input.map({Int($0) ?? -1}))

var chars = Set<Character>()
var numbers = Set<Int>()
var state : Int = 0
var result : Int = 0

var changed = Set<Int>()

var fail = true

while fail {
    fail = false
    result = 0
    numbers = Set<Int>()
    state = 0
    var didChange = false
    while true {
        let split = input[state].split(separator: " ")
        let num = Int(split[1]) ?? 0
        
        var next = 1
        switch split[0] {
        case "nop" :
            if changed.contains(state) || didChange {
            } else {
                changed.insert(state)
                didChange = true
                next = num
            }
        case "acc":
            result += num
        case "jmp":
            if changed.contains(state) || didChange {
                next = num
            } else {
                changed.insert(state)
                didChange = true
            }
        default: print("WHAT")
        }
        state += next
        
        if numbers.contains(state) {
            fail = true
            break
        }
        numbers.insert(state)
        if state == input.count - 1 {
            break
        }
    }
}

print(result)

//state = input.count - 1
//print(input[state])

import Foundation
//let file = "/Users/flanggut/Downloads/dayXX.txt"
let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")

var state : Int = 0
var result : Int = 0

print("State: \(state), Result: \(result)")

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

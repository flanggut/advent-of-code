import Foundation
let file = "/Users/flanggut/Downloads/day6.txt"
//let file = "/Users/flanggut/Downloads/test.txt"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines)

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
//    let c = String(element) ~= "[BF]{7}"
}

let matrix = input.map({Array($0)})
//let list = Set(input.map({Int($0) ?? -1}))

var chars = Set<Character>()
var numbers = Set<Int>()
var result : Int = 0
var reset = false

for line in matrix {
    if line.count == 0 {
        print(chars)
        result += chars.count
        reset = true
        continue
    }
    let localChars = Set(line)
    if reset {
        chars = localChars
        reset = false
    } else {
        chars = chars.intersection(localChars)
    }
}



print(result)

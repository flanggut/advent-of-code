import Foundation
let file = "/Users/flanggut/Downloads/day10.txt"
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

let adapters = input.map({Int($0)!}).sorted()
var diffs : [Int] = []
for i in 1..<adapters.count {
    diffs.append(adapters[i] - adapters[i - 1])
}
print(diffs.reduce(into: [:], { $0[$1, default: 0] += 1 }))


var optsForAdapter : [Int:Int] = [0:1]
for i in adapters {
    for prev in (adapters + [0]).filter({i - 3..<i ~= $0}) {
        optsForAdapter[i, default: 0] += optsForAdapter[prev]!
    }
    print("Adapter: \(i), Options: \(optsForAdapter[i]!)")
} 


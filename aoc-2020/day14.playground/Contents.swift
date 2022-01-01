import Foundation
let file = "/Users/flanggut/Downloads/day14.txt"
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
var result : UInt64 = 0

var bits : UInt64 = 0

var memoryFirst : [UInt64 : UInt64] = [:]
var memorySecond : [UInt64 : UInt64] = [:]
var mask : Array<Character> = []

func combineNumbers (array: Array<Character>, index: Int, base : UInt64) -> Set<UInt64> {
    var s : Set<UInt64> = []
    if (index == array.count) {
        return [base]
    }
    if (array[index] == "0") {
        s = s.union(combineNumbers(array: array, index: index + 1, base: base))
    }
    if (array[index] == "1") {
        let newBase = base | UInt64(1 << (35 - UInt64(index)))
        s = s.union(combineNumbers(array: array, index: index + 1, base: newBase))
    }
    if (array[index] == "X") {
        let newBase = base | UInt64(1 << (35 - UInt64(index)))
        s = s.union(combineNumbers(array: array, index: index + 1, base: newBase))
        s = s.union(combineNumbers(array: array, index: index + 1, base: base))
    }
    return s
}

for line in input {
    let split = line.components(separatedBy: " = ")
    let command = split[0]
    var number = UInt64(split[1]) ?? 0
    
    if command == "mask" {
        mask = Array(split[1])
        continue
    }
    
    let memoryAddress = UInt64(command.dropFirst(4).dropLast()) ?? 0
    
    var mem = mask
    for (i,c) in mask.enumerated() {
        if c == "0" && (memoryAddress & UInt64(1 << (35 - UInt64(i)))) > 0 {
            mem[i] = "1"
        }
    }
    for address in combineNumbers(array: mem, index: 0, base: 0) {
        memorySecond[address] = number
    }

    for (i, c) in mask.enumerated() {
        switch c {
        case "1" :
            number = number | (1 << (35 - UInt64(i)))
        case "0" :
            let mask = ~UInt64(1 << (35 - UInt64(i)))
            number = number & mask
        default : result = 0
        }
    }
    memoryFirst[memoryAddress] = number
}
 
print(memoryFirst.reduce(0, {$0 + $1.1}))
print(memorySecond.reduce(0, {$0 + $1.1}))

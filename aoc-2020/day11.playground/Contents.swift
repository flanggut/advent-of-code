import Foundation
//let file = "/Users/flanggut/Downloads/day11.txt"
let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
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

let matrix = input.map({Array($0)})
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

let directions : [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (1, 1), (1, -1), (-1, 0), (-1, 1), (-1, -1)]
print(directions.count)

var state : Int = 0
var result : Int = 0

var prevBoard = matrix
var nextBoard = matrix

var didChange = true

for i in 1...1000 {
    didChange = false
    for row in 0..<matrix.count {
        for col in 0..<matrix[0].count {
            if prevBoard[row][col] == "L" {
                var count = 0
                for dir in directions {
                    var isValid = true
                    var cr = row
                    var cc = col
                    while isValid {
                        cr += dir.0
                        cc += dir.1
                        if cr < matrix.count && cc < matrix[0].count && cr >= 0 && cc >= 0 {
                            if prevBoard[cr][cc] == "#" {
                                count += 1
                                break
                            }
                            if prevBoard[cr][cc] != "." {
                                break
                            }
                        } else {
                            isValid = false
                        }
                    }
                    if count > 0 {
                        break
                    }
                }
                if count == 0 {
                    nextBoard[row][col] = "#"
                    didChange = true
                }
            }
            if prevBoard[row][col] == "#" {
                var count = 0
                for dir in directions {
                    var isValid = true
                    var cr = row
                    var cc = col
                    while isValid {
                        cr += dir.0
                        cc += dir.1
                        if cr < matrix.count && cc < matrix[0].count && cr >= 0 && cc >= 0 {
                            if prevBoard[cr][cc] == "#" {
                                count += 1
                            }
                            if prevBoard[cr][cc] != "." {
                                break
                            }
                        } else {
                            isValid = false
                        }
                    }
                    if count == 5 {
                        break
                    }
                }
                if count > 4 {
                    nextBoard[row][col] = "L"
                    didChange = true
                }
            }
        }
    }
    
    prevBoard = nextBoard
//    for string in nextBoard.map({String($0)}) {
//        print(string)
//    }
    print("State: \(i), Result: \(didChange)")
    if !didChange {
        result = 0
        for row in 0..<matrix.count {
            for col in 0..<matrix[0].count {
                if prevBoard[row][col] == "#" {
                    result += 1
                }
            }
        }
        print("State: \(state), Result: \(result)")
        break
    }
}

result = 0
for row in 0..<matrix.count {
    for col in 0..<matrix[0].count {
        if prevBoard[row][col] == "#" {
            result += 1
        }
    }
}

print("State: \(state), Result: \(result)")

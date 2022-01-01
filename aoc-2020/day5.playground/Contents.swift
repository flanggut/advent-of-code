import Foundation
let file = "/Users/flanggut/Downloads/day5.txt"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines)
let matrix = input.map({Array($0)}).dropLast()

var numbers = Set<Int>()
for element in matrix {
    var row : Int = 0
    for i in 0...6 {
        if element[i] == "B" {
            row |= 1 << (6 - i)
        }
    }
    var col : Int = 0
    for i in 7...9 {
        if element[i] == "R" {
            col |= 1 << (9 - i)
        }
    }
    numbers.insert(row * 8 + col)
}

print(numbers.max()!)

for number in numbers {
    if !numbers.contains(number + 1) && numbers.contains(number + 2) {
        print(number + 1)
    }
}


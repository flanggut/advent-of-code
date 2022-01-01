import Foundation
//let file = "/Users/flanggut/Downloads/day25.txt"
let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
//print("Last line: \(input.last!)")


var subjectnumber = 0

func mainloop(value : Int, subject: Int) -> Int {
    var value1 = value * subject
    value1 %= 20201227
    return value1
}

let cardNum = 7
let doorNum = 7

//var doorKey = 17807724
//var cardKey = 5764801

var doorKey = 8184785
var cardKey = 5293040

var v = 1
var c = 0
while v != cardKey {
    v = mainloop(value: v, subject: cardNum)
    c += 1
}
let cardLoop = c
print(c)

v = 1
c = 0
while v != doorKey {
    v = mainloop(value: v, subject: doorNum)
    c += 1
}
let doorLoop = c
print(c)

v = 1
for i in 1...cardLoop {
    v = mainloop(value: v, subject: doorKey)
}
print(v)

import Foundation
let file = "/Users/flanggut/Downloads/day17.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")

struct Point : Hashable, CustomStringConvertible {
    var x : Int
    var y : Int
    var z : Int
    var w : Int
    var description: String {
        return "(\(x), \(y), \(z), \(w)"
    }
    var neighbors : [Point] {
        var points : [Point] = []
        for dx in -1...1 {
            for dy in -1...1 {
                for dz in -1...1 {
                    for dw in -1...1 {
                        if dx | dy | dz | dw != 0 {
                            points.append(Point(x: x + dx, y: y + dy, z: z + dz, w: w + dw))
                        }
                    }
                }
            }
        }
        return points
    }
}
var board : [Point : Character] = [:]

for (i, line) in input.enumerated() {
    let a = Array(line)
    for (j, c) in a.enumerated() {
        board[Point(x:i, y:j, z:0, w: 0)] = c
    }
}

for _ in 1...6 {
    var newBoard = board
    for point in board.keys {
        for n in point.neighbors {
            if newBoard[n] == nil {
                newBoard[n] = "."
            }
        }
    }
    board = newBoard
    for (point, state) in board {
        let n = point.neighbors.reduce(0) {
            board[$1, default: "."] == "#" ? $0 + 1 : $0
        }
        if state == "#" && !(2...3 ~= n) {
            newBoard[point] = "."
        }
        if state == "." && n == 3 {
            newBoard[point] = "#"
        }
    }
    board = newBoard
}

print(board.reduce(0, { $1.1 == "#" ? $0 + 1 : $0}))

import Foundation
let file = "/Users/flanggut/Downloads/day24.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")


struct Coord : Hashable {
    var x : Int
    var y : Int
}

func nextDirection(list: inout String) -> Coord? {
    if list.isEmpty {
        return nil
    }
    let a = list.removeFirst()
    if a == "e" {
        return Coord(x: 2, y: 0)
    } else if a == "s" {
        let b = list.removeFirst()
        if b == "e" {
            return Coord(x: 1, y: -1)
        } else {
            return Coord(x: -1, y: -1)
        }
    } else if a == "w" {
        return Coord(x: -2, y: 0)
    } else {
        let b = list.removeFirst()
        if b == "e" {
            return Coord(x: 1, y: 1)
        } else {
            return Coord(x: -1, y: 1)
        }
    }
}

var tiles : [Coord:Int] = [:]

for line in input {
    var list = String(line)
    var c  = Coord(x: 0, y: 0)
    while let dir = nextDirection(list: &list) {
        c.x += dir.x
        c.y += dir.y
    }
    tiles[c] = tiles[c, default:0] == 0 ? 1 : 0
}

var counter = 0
for tile in tiles {
    if tile.value == 1 {
        counter += 1
    }
}
print(counter)

func getAllNeighbors(c: Coord) -> [Coord] {
    var list : [Coord] = []
    list.append(Coord(x: c.x + 2, y: c.y))
    list.append(Coord(x: c.x - 2, y: c.y))
    list.append(Coord(x: c.x + 1, y: c.y - 1))
    list.append(Coord(x: c.x + 1, y: c.y + 1))
    list.append(Coord(x: c.x - 1, y: c.y - 1))
    list.append(Coord(x: c.x - 1, y: c.y + 1))
    return list
}

for _ in 1...100 {
    var newBoard = tiles
    // Expand
    for tile in tiles {
        if tile.value == 1 {
            for n in getAllNeighbors(c: tile.key) {
                newBoard[n] = newBoard[n, default: 0]
            }
        }
    }
    tiles = newBoard
    for tile in tiles {
        var cBlack = 0
        for n in getAllNeighbors(c: tile.key) {
            if tiles[n, default: 0] == 1 {
                cBlack += 1
            }
        }
        if tile.value == 1 && (cBlack == 0 || cBlack > 2) {
            newBoard[tile.key] = 0
        }
        if tile.value == 0 && cBlack == 2 {
            newBoard[tile.key] = 1
        }
    }
    
    tiles = newBoard
    counter = 0
    for tile in tiles {
        if tile.value == 1 {
            counter += 1
        }
    }
    print(counter)
}


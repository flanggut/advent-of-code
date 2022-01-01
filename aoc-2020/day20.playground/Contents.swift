import Foundation
let file = "/Users/flanggut/Downloads/day20.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")

struct Match {
    var id : Int
    var side1 : Int
    var side2 : Int
    var flippedH : Bool
    var flippedV : Bool
}

struct Tile {
    var m : [[Character]]
        
    var top : [Character] {
        get {
            return m[0]
        }
    }
    var bottom : [Character] {
        get {
            return m.last!
        }
    }
    var left : [Character] {
        get {
            var array : [Character] = []
            for line in m {
                array.append(line.first!)
            }
            return array
        }
    }
    var right : [Character] {
        get {
            var array : [Character] = []
            for line in m {
                array.append(line.last!)
            }
            return array
        }
    }
    var all : [[Character]] {
        get {
            return [top, right, bottom, left]
        }
    }
}

func flipV(t : Tile) -> Tile {
    var nt = t
    for i in 0..<(t.m.count / 2) {
        nt.m.swapAt(i, t.m.count - 1 - i)
    }
    return nt
}
func flipH(t : Tile) -> Tile {
    var nt = t
    for j in 0..<nt.m.count{
        for i in 0..<(t.m.count / 2) {
            nt.m[j].swapAt(i, t.m.count - 1 - i)
        }
    }
    return nt
}

func rotate(t: Tile, num: Int) -> Tile {
    var nt = t
    for _ in 0..<num {
        let pt = nt
        for j in 0..<t.m.count {
            for i in 0..<t.m.count {
                nt.m[i][t.m.count - 1 - j] = pt.m[j][i]
            }
        }

    }
    return nt
}


// Read Tiles

var line = 0

var tiles : [Int:Tile] = [:]

while line < input.count {
    let id = Int(input[line].split(separator: " ")[1].dropLast())!
    line += 1
    var t = Tile(m: [])
    while input[line].count > 0 {
        t.m.append(Array(input[line]))
        line += 1
    }
    tiles[id] = t
    line += 1
}

let target = Int(sqrt(Double(tiles.count)))
print(target)

var countMatches : [Int: Int] = [:]
var matches : [Int:[Match]] = [:]

for t in tiles {
    for o in tiles.filter({$0.key != t.key}) {
        for (i, s) in t.value.all.enumerated() {
            for (j, os) in o.value.all.enumerated() {
                if s == os {
                    print("Match \(t.key): \(i), \(o.key): \(j)")
                    countMatches[t.key, default: 0] += 1
                    
                    matches[t.key, default: []].append(Match(id: o.key, side1: i, side2: j, flippedH: false, flippedV: false))
                }
                if s.reversed() == os {
                    print("Match \(t.key): \(i), \(o.key): \(j)")
                    countMatches[t.key, default: 0] += 1
                    
                    matches[t.key, default: []].append(Match(id: o.key, side1: i, side2: j, flippedH: i % 2 == 0, flippedV: i % 2 == 1))
                }
            }
        }
    }
}
print(countMatches)

let startId = tiles.filter({countMatches[$0.key]! == 2}).keys.sorted().first!
print(tiles.filter({countMatches[$0.key]! == 2}).keys)
print(startId)

struct Piece : CustomStringConvertible {
    var id : Int
    var rotated : Int
    var flippedH : Bool
    var flippedV : Bool
    var description: String {
        String(id)
    }
}

var usedIds : Set<Int> = []

var image : [[Piece]] = []
image.append([])
image[0].append(Piece(id: startId, rotated: 0, flippedH: false, flippedV: false))
usedIds.insert(startId)

for x in 1..<target {
    for m in matches[image[0][x - 1].id]! {
        if usedIds.contains(m.id) {
            continue
        }
        if countMatches[m.id]! > 3 {
            continue
        }
        image[0].append(Piece(id: m.id, rotated: 0, flippedH: false, flippedV: false))
        usedIds.insert(m.id)
        break
    }
}
for y in 1..<target {
    image.append([])
    for m in matches[image[y - 1][0].id]! {
        if usedIds.contains(m.id) {
            continue
        }
        if countMatches[m.id]! > 3 {
            continue
        }

        image[y].append(Piece(id: m.id, rotated: 0, flippedH: false, flippedV: false))
        usedIds.insert(m.id)
        break
    }
    for x in 1..<target {
        for m in matches[image[y][x - 1].id]! {
            if usedIds.contains(m.id) {
                continue
            }
            if matches[image[y - 1][x].id]!.filter({$0.id == m.id}).count == 0 {
                continue
            }
            image[y].append(Piece(id: m.id, rotated: 0, flippedH: false, flippedV: false))
            usedIds.insert(m.id)
            break
        }
    }
}

func mapForState(p : Piece) -> [Int] {
    var array = [0, 1, 2, 3].map({($0 + p.rotated) % 4})
    if p.flippedH {
        array.swapAt(1, 3)
    }
    if p.flippedV {
        array.swapAt(0, 2)
    }
    return array
}


print(image)

print(matches[image[0][0].id]!)

for m in matches[image[0][0].id]! {
    if m.flippedH {
        image[0][0].flippedH = true
    }
    if m.flippedV {
        image[0][0].flippedV = true
    }
}
for i in 0...3 {
    var p = image[0][0]
    p.rotated = i
    let matchedSides = matches[p.id]!.map({$0.side1})
    let map = mapForState(p: p)
    print(map)
    if 1...2 ~= map[matchedSides[0]] && 1...2 ~= map[matchedSides[1]] {
        image[0][0].rotated = i
        break
    }
}
let zeroTile = image[0][0]
tiles[zeroTile.id] = rotate(t: tiles[zeroTile.id]!, num: zeroTile.rotated)
if zeroTile.flippedH {
    tiles[zeroTile.id] = flipH(t: tiles[zeroTile.id]!)
}
if zeroTile.flippedV {
    tiles[zeroTile.id] = flipV(t: tiles[zeroTile.id]!)
}


for x in 1..<target {
    let id = image[0][x].id
    let prev = image[0][x - 1]
    let pt = tiles[prev.id]!
    let mt = tiles[id]!
    var matched = false
    for m in matches[id]! {
        if matched {
            break
        }
        if m.id == prev.id {
            print(m)
            for i in 0...3 {
                let rt = rotate(t: mt, num: i)
                if (rt.left == pt.right) {
                    matched = true
                    image[0][x].rotated = i
                    break
                }
                let vt = flipV(t: rt)
                if (vt.left == pt.right) {
                    matched = true
                    image[0][x].rotated = i
                    image[0][x].flippedV = true
                    break
                }
                let ht = flipH(t: rt)
                if (ht.left == pt.right) {
                    matched = true
                    image[0][x].rotated = i
                    image[0][x].flippedH = true
                    break
                }
            }
        }
    }
    let p = image[0][x]
    tiles[id] = rotate(t: tiles[id]!, num: p.rotated)
    if p.flippedH {
        tiles[id] = flipH(t: tiles[id]!)
    }
    if p.flippedV {
        tiles[id] = flipV(t: tiles[id]!)
    }
}


for x in 0..<target {
    for y in 1..<target {
        let id = image[y][x].id
        let prev = image[y-1][x]
        let pt = tiles[prev.id]!
        let mt = tiles[id]!
        var matched = false
        for m in matches[id]! {
            if matched {
                break
            }
            if m.id == prev.id {
                print(m)
                for i in 0...3 {
                    let rt = rotate(t: mt, num: i)
                    if (rt.top == pt.bottom) {
                        matched = true
                        image[y][x].rotated = i
                        break
                    }
                    let vt = flipV(t: rt)
                    if (vt.top == pt.bottom) {
                        matched = true
                        image[y][x].rotated = i
                        image[y][x].flippedV = true
                        break
                    }
                    let ht = flipH(t: rt)
                    if (ht.top == pt.bottom) {
                        matched = true
                        image[y][x].rotated = i
                        image[y][x].flippedH = true
                        break
                    }
                }
            }
        }
        let p = image[y][x]
        tiles[id] = rotate(t: tiles[id]!, num: p.rotated)
        if p.flippedH {
            tiles[id] = flipH(t: tiles[id]!)
        }
        if p.flippedV {
            tiles[id] = flipV(t: tiles[id]!)
        }
    }
}

let tilesize = tiles.first!.value.m.count

for j in 0..<target {
    for r in 0..<tilesize {
        var string = ""
        for i in 0..<target {
            string += String(tiles[image[j][i].id]!.m[r]) + " "
        }
        print(string)
    }
    print(" ")
}

var mapString = ""
for j in 0..<target {
    for r in 1..<tilesize-1 {
        var string = ""
        for i in 0..<target {
            string += String(tiles[image[j][i].id]!.m[r].dropFirst().dropLast())
        }
//        print(string)
        mapString += string + "\n"
    }
}

let in2 = mapString.components(separatedBy: .newlines).dropLast()
let monstermap = in2.map({Array($0)})

let monsterS : [String] = ["                  # "
                         ,"#    ##    ##    ###"
                         ," #  #  #  #  #  #   "]
let monster = monsterS.map({Array($0)})

let mt = Tile(m: monstermap)

func findMonsters(map: [[Character]]) -> Int {
    var counter = 0
    for r in 0..<map.count - monster.count {
        for c in 0..<map[0].count - monster[0].count {
            var match = true
            for mr in 0..<monster.count {
                if match == false {
                    break
                }
                for mc in 0..<monster[0].count {
                    if monster[mr][mc] == "#" {
                        if map[r + mr][c + mc] != "#" {
                            match = false
                            break
                        }
                    }
                }
            }
            counter += match ? 1 : 0;
        }
    }
    return counter;
}


for i in 0...3 {
    let rt = rotate(t: mt, num: i)
    print(findMonsters(map: rt.m))
    let vt = flipV(t: rt)
    print(findMonsters(map: vt.m))
    let ht = flipH(t: rt)
    print(findMonsters(map: ht.m))
}

func count(m : [[Character]]) -> Int {
    var cc = 0
    for i in m {
        for c in i {
            if c == "#" {
                cc += 1
            }
        }
    }
    return cc
}

print(count(m: monstermap))
print(count(m: monster))


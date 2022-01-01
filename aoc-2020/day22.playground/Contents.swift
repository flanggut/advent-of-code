import Foundation
let file = "/Users/flanggut/Downloads/day22.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")

let split = input.split(separator: "")

let deck1 = split[0].dropFirst().map({Int($0)!})
let deck2 = split[1].dropFirst().map({Int($0)!})
print(deck1)
print(deck2)

let numCards = deck1.count + deck2.count
//
//while !deck2.isEmpty && !deck1.isEmpty {
//    let top1 = deck1.first!
//    let top2 = deck2.first!
//    deck1 = Array(deck1.dropFirst())
//    deck2 = Array(deck2.dropFirst())
//
//    if top1 > top2 {
//        deck1 += [top1, top2]
//    } else {
//        deck2 += [top2, top1]
//    }
//}
//let deck = deck2.isEmpty ? deck1 : deck2
//
//var result = 0
//for (i, v) in deck.enumerated(){
//    result += (numCards - i) * v
//}
//print(result)
//
//deck1 = split[0].dropFirst().map({Int($0)!})
//deck2 = split[1].dropFirst().map({Int($0)!})
//


struct decks {
    var d1 : [Int]
    var d2 : [Int]
}

func combat(d1 : [Int], d2: [Int], memory: inout [decks]) -> Int {
    for d in memory {
        if d.d1 == d1 && d.d2 == d2 {
//            print("rec")
            return 1
        }
    }
    memory.append(decks(d1: d1, d2: d2))
//    print(d1)
//    print(d2)
//    print(" ")
    let top1 = d1.first!
    let top2 = d2.first!
    if (d1.count - 1) >= top1 && (d2.count - 1) >= top2 {
        let winner = fullcombat(d1: Array(d1[1...top1]), d2: Array(d2[1...top2])).0
        return winner
    }
    if top1 > top2 {
        return 1
    } else {
        return 2
    }
}

var c = 1
func fullcombat (d1 : [Int], d2 : [Int]) -> (Int, [Int]) {
    var ldeck1 = d1
    var ldeck2 = d2
    var memory : [decks] = []
    print("Game \(c)")
    c += 1
    while !ldeck2.isEmpty && !ldeck1.isEmpty {
        let winner = combat(d1: ldeck1, d2: ldeck2, memory: &memory)
        let top1 = ldeck1.first!
        let top2 = ldeck2.first!
        if winner == 1 {
            ldeck1 = ldeck1.dropFirst() + [top1, top2]
            ldeck2.removeFirst()
        } else {
            ldeck2 = ldeck2.dropFirst() + [top2, top1]
            ldeck1.removeFirst()
        }
    }
    return ldeck1.isEmpty ? (2, ldeck2) : (1, ldeck1)
}

let deck = fullcombat(d1: deck1, d2: deck2).1
print(deck)
var result = 0
for (i, v) in deck.enumerated(){
    result += (numCards - i) * v
}
print(result)

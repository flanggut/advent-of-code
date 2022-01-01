import Foundation
let file = "/Users/flanggut/Downloads/numbers.txt"
let numbers = try! String(contentsOfFile: file).components(separatedBy: .newlines)
let set = Set(numbers.map({Int($0) ?? 0}))
var solution : Set<Int> = Set()
for number in set {
    let diff = 2020 - number
    if set.contains(diff) {
        solution.insert(diff)
    }
}
assert(solution.count == 2)
print(solution.reduce(1, {$0 * $1}))

func findPairWithSum(set: Set<Int>, sum: Int) -> Set<Int> {
    var solution : Set<Int> = Set()
    for number in set {
        let diff = sum - number
        if set.contains(diff) {
            solution.insert(diff)
        }
    }
    return solution
}
var triple : Set<Int> = Set()
for number in set {
    let diff = 2020 - number
    let solution = findPairWithSum(set: set, sum: diff)
    if (solution.count == 2) {
        triple = triple.union(solution)
        triple.insert(number)
    }
}
assert(triple.count == 3)
print(triple.reduce(1, {$0 * $1}))









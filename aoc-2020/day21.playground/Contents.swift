import Foundation
let file = "/Users/flanggut/Downloads/day21.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")

var recipes : [Set<String>] = []

var inForAller : [String:Set<String>] = [:]

for line in input {
    let split = line.dropLast().components(separatedBy: " (contains ")
    let allergens = split[1].components(separatedBy: ", ")
    let ingredients = Set<String>(split[0].split(separator: " ").map({String($0)}))
    recipes.append(ingredients)
    for a in allergens {
        inForAller[a, default: ingredients].formIntersection(ingredients)
    }
}

var allIngredients = recipes.reduce(Set<String>(), {$0.union($1)})

for v in inForAller.values {
    allIngredients.subtract(v)
}

print(allIngredients)

var counter = 0
for r in recipes {
    for i in allIngredients {
        if r.contains(i) {
            counter += 1
        }
    }
}

print(counter)

var used : Set<String> = []

var didReplace = true
while didReplace {
    didReplace = false
    for (k, v) in inForAller {
        if v.count == 1 && !used.contains(k) {
            used.insert(k)
            for other in inForAller.keys {
                if other != k {
                    inForAller[other]!.subtract(v)
                }
            }
            didReplace = true
            break
        }
    }
}

print(inForAller)

var list = ""
for k in inForAller.keys.sorted() {
    list += inForAller[k]!.first! + ","
}

print(list.dropLast())

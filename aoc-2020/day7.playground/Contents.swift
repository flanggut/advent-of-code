import Foundation
let file = "/Users/flanggut/Downloads/day7.txt"
//let file = "/Users/flanggut/Downloads/test.txt"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines)

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
//    let c = String(element) ~= "[BF]{7}"
}

//let matrix = input.map({Array($0)})
//let list = Set(input.map({Int($0) ?? -1}))

var chars = Set<Character>()
var numbers = Set<Int>()
var state : Int = 0
var result : Int = 0

var bags : [String:[(String, Int)]] = [:]
var bagsInverse : [String:[(String, Int)]] = [:]

for line in input {
    if (line.count == 0) {
        continue
    }
    let elements = line.components(separatedBy: " bags contain ")
    let bag = String(elements[0])
    for element in elements[1].components(separatedBy: ", "){
        let split = element.split(separator: " ")
        let number = Int(split[0]) ?? -1
        if number > 0 {
            let otherBag = String(split[1]) + " " + String(split[2])
            if bags[otherBag] == nil {
                bags[otherBag] = []
            }
            bags[otherBag]!.append((bag, number))
            if bagsInverse[bag] == nil {
                bagsInverse[bag] = []
            }
            bagsInverse[bag]!.append((otherBag, number))
        }
    }
}

func findBags(search: String, contains : inout Set<String>) {
    if let bagsLocal = bags[search] {
        for localBag in bagsLocal {
            contains.insert(localBag.0)
            findBags(search: localBag.0, contains: &contains)
        }
    }
}

var containsGold = Set<String>()
findBags(search: "shiny gold", contains: &containsGold)
result = containsGold.count
print(result)

func findBags2(search: String, base : Int) -> Int {
    var num : Int = 0
    if let bagsLocal = bagsInverse[search] {
        for localBag in bagsLocal {
            num += base * localBag.1
            num += findBags2(search: localBag.0, base:base * localBag.1)
        }
    }
    return num
}

print(findBags2(search: "shiny gold", base: 1))

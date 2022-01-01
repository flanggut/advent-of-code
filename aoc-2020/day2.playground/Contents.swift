import Foundation
let file = "/Users/flanggut/Downloads/day2.txt"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines)

var counter : Int = 0
for line in input {
    let split = line.split(separator: ":")
    let countChar = split[0].split(separator: " ")
    let char = countChar[1]
    let countMin = Int(countChar[0].split(separator: "-")[0]) ?? -1
    let countMax = Int(countChar[0].split(separator: "-")[1]) ?? -1
    let passsword = split[1]
    let count = passsword.filter { $0 == char[char.startIndex] }.count
    
    if (count < countMin || count > countMax) {
    } else {
        counter += 1
    }
}
print(counter)

var counter2 : Int = 0
for line in input {
    let split = line.split(separator: ":")
    let countChar = split[0].split(separator: " ")
    let char = countChar[1]
    let index1 = Int(countChar[0].split(separator: "-")[0]) ?? -1
    let index2 = Int(countChar[0].split(separator: "-")[1]) ?? -1
    assert(index1 > 0)
    assert(index2 > 0)
    let password = split[1].trimmingCharacters(in: .whitespaces)
    let chars = Array(password)
    
    let test : Character = char[char.startIndex]
    if (chars[index1 - 1] == test && chars[index2 - 1] != test) {
        counter2 += 1
    } else if (chars[index1 - 1] != test && chars[index2 - 1] == test) {
        counter2 += 1
    }

}
print(counter2)

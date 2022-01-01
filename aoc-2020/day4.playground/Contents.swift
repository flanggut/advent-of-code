import Foundation
let file = "/Users/flanggut/Downloads/day4.txt"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines)

let target : Set = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
let validColor : Set<Character> = ["a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9"]
let eyeColor : Set<String> = ["amb","blu","brn","gry","grn","hzl","oth"]

var passport = Set<String>()
var passportFull = Set<String>()
var count : Int = 0
for line in input {
    if line == "" {
        var valid = true
        for element in target {
            if !passport.contains(element) {
                valid = false
                break
            }
        }
        if valid {
            for element in passportFull {
                let split = element.split(separator: ":")
                let field = String(split[0])
                if field == "byr" {
                    let number = Int(split[1]) ?? -1
                    if number < 1920 || number > 2002 {
//                        print(passportFull)
//                        print(field)
//                        print(number)
                        valid = false
                    }
                }
                if field == "iyr" {
                    let number = Int(split[1]) ?? -1
                    if number < 2010 || number > 2020 {
//                        print(passportFull)
//                        print(field)
//                        print(number)
                        valid = false
                    }
                }
                if field == "eyr" {
                    let number = Int(split[1]) ?? -1
                    if number < 2020 || number > 2030 {
//                        print(passportFull)
//                        print(field)
//                        print(number)
                        valid = false
                    }
                }
                if field == "hgt" {
                    let value = Int(split[1].dropLast(2)) ?? -1
                    let label = String(split[1].suffix(2))
                    if label == "cm" && (value < 150 || value > 193) {
//                        print(passportFull)
//                        print(field)
//                        print(value)
                        valid = false
                    } else if label == "in" && (value < 59 || value > 76) {
//                        print(passportFull)
//                        print(field)
//                        print(value)
                        valid = false
                    } else if label != "in" && label != "cm" {
//                        print(passportFull)
//                        print(field)
//                        print(label)
                        valid = false
                    }
                }
                if field == "hcl" {
                    let value = Array(String(split[1]))
                    if value.count != 7 {
                        valid = false
                    } else {
                        if value[0] != "#" {
                            valid = false
                        }
                        for i in 1...6 {
                            if !validColor.contains(value[i]){
                                print(value[i])
                                valid = false
                            }
                        }
                    }
                }
                if field == "ecl" {
                    let value = String(split[1])
                    if !eyeColor.contains(value) {
                        valid = false
                    }
                }
                if field == "pid" {
                    let value = String(split[1])
                    if value.count != 9 {
                        valid = false
                    }
                }
            }
            
            if valid {
                count += 1
            }
        }
        passport = Set<String>()
        passportFull = Set<String>()
    } else {
        for field in line.split(separator: " ") {
            passportFull.insert(String(field))
            passport.insert(String(field.split(separator: ":")[0]))
        }
    }
//    if count == 2 {
//        break
//    }
}

print(count)
//print(input)
//let set = Set(numbers.map({Int($0) ?? 0}))
//let matrix = input.map({Array($0)})
//let split = line.split(separator: ":")
//let countChar = split[0].split(separator: " ")
//let char = countChar[1]
//let countMin = Int(countChar[0].split(separator: "-")[0]) ?? -1
//let countMax = Int(countChar[0].split(separator: "-")[1]) ?? -1
//let passsword = split[1]
//let count = passsword.filter { $0 == char[char.startIndex] }.count
//
//
//func trees(matrix : [[Character]], slopeX : Int, slopeY : Int) -> Int {
//    let sizeX = matrix[0].count
//    let sizeY = matrix.count
//
//    var coordX : Int = 0
//    var coordY : Int = 0
//
//    var countTrees = 0
//    while coordY < sizeY - 1 {
//        coordX += slopeX
//        coordY += slopeY
//        if (matrix[coordY][coordX % sizeX] == "#") {
//            countTrees += 1
//        }
//    }
//    return countTrees
//}
//
//let a = trees(matrix: matrix, slopeX: 1, slopeY: 1)
//let b = trees(matrix: matrix, slopeX: 3, slopeY: 1)
//let c = trees(matrix: matrix, slopeX: 5, slopeY: 1)
//let d = trees(matrix: matrix, slopeX: 7, slopeY: 1)
//let e = trees(matrix: matrix, slopeX: 1, slopeY: 2)
//
//print(a * b * c * d * e)


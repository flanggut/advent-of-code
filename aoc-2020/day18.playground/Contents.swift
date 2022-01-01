import Foundation
let file = "/Users/flanggut/Downloads/day18.txt"
//let file = "/Users/flanggut/Desktop/aoc2020/test.strings"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines).dropLast()
print("Last line: \(input.last!)")

enum Op {
    case plus
    case mul
}

func mysplit (expression : String, oo : Character) -> [(Op, String)] {
    var result : [(Op, String)] = [];
    var braces = 0;
    var currentChunk = "";
    var op : Op = .plus
    let array = Array(expression)
    var reducedTo0 = 0
    for char in array {
        if (char == "(") {
            braces += 1;
        } else if (char == ")") {
            braces -= 1;
            if braces == 0 {
                reducedTo0 += 1
            }
        }
        if (braces == 0 && char == oo) {
            if char == "*" {
                result.append((op, currentChunk.trimmingCharacters(in: .whitespaces)));
                currentChunk = "";
                op = .mul
            }
            if char == "+" {
                result.append((op, currentChunk.trimmingCharacters(in: .whitespaces)));
                currentChunk = "";
                op = .plus
            }
        } else {
            currentChunk += String(char);
        }
    }
    if reducedTo0 == 1 && result.count == 0 && array.first! == "(" && array.last! == ")" {
        return mysplit(expression: String(array.dropFirst().dropLast()), oo: oo)
    }
    
    if (currentChunk != "") {
        result.append((op, String(currentChunk).trimmingCharacters(in: .whitespaces)));
    }
    return result;
};

func parseadd (expression : String) -> Int {
    var result  = 0
    let ops = mysplit(expression: expression, oo: "+")
    for o in ops {
        switch o.0 {
        case .plus:
            if let v = Int(o.1) {
                result = result + v
            } else {
                result = result + parsemul(expression: o.1)
            }
        case .mul:
            print("waht")
        }
    }
    return result;
}

func parsemul (expression : String) -> Int {
    var result  = 0
    let ops = mysplit(expression: expression, oo : "*")
    for o in ops {
        switch o.0 {
        case .plus:
            if let v = Int(o.1) {
                result = result + v
            } else {
                if mysplit(expression: expression, oo : "*").count > 1 {
                    result = result + parsemul(expression: o.1)
                } else {
                    result = result + parseadd(expression: o.1)
                }
            }
        case .mul:
            if let v = Int(o.1) {
                result = result * v
            } else {
                if mysplit(expression: expression, oo : "*").count > 1 {
                    result = result * parsemul(expression: o.1)
                } else {
                    result = result * parseadd(expression: o.1)
                }
            }
        }
    }
    return result;
}

print(input.reduce(0){ $0 + parsemul(expression: $1) })


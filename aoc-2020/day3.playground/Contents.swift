import Foundation
let file = "/Users/flanggut/Downloads/day3.txt"
let input = try! String(contentsOfFile: file).components(separatedBy: .newlines)
let matrix = input.map({Array($0)})

func trees(matrix : [[Character]], slopeX : Int, slopeY : Int) -> Int {
    let sizeX = matrix[0].count
    let sizeY = matrix.count

    var coordX : Int = 0
    var coordY : Int = 0

    var countTrees = 0
    while coordY < sizeY - 1 {
        coordX += slopeX
        coordY += slopeY
        if (matrix[coordY][coordX % sizeX] == "#") {
            countTrees += 1
        }
    }
    return countTrees
}

let a = trees(matrix: matrix, slopeX: 1, slopeY: 1)
let b = trees(matrix: matrix, slopeX: 3, slopeY: 1)
let c = trees(matrix: matrix, slopeX: 5, slopeY: 1)
let d = trees(matrix: matrix, slopeX: 7, slopeY: 1)
let e = trees(matrix: matrix, slopeX: 1, slopeY: 2)

print(a * b * c * d * e)


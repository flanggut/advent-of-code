import Foundation

class Node {
    public var value : Int
    public var next : Node?
    public init(value: Int) {
        self.value = value
    }
    
    public func insertAfter(v: Int) -> Node {
        let v = Node(value: v)
        v.next = self.next!
        self.next = v
        return v
    }
    
    public func cut3After() -> Node {
        let cut = self.next!
        self.next = cut.next!.next!.next!
        return cut
    }

    public func insert3After(node3: inout Node) {
        node3.next!.next!.next = self.next!
        self.next = node3
    }
}


func print(node : Node) {
    var c = node
    var s = "\(c.value)"
    while !(c.next! === node) {
        c = c.next!
        s += " \(c.value)"
    }
    print(s)
}

let input : String = "3 8 9 1 2 5 4 6 7"
//let input : String = "1 9 3 4 6 7 2 5 8"
let initial : Array<Int> = input.split(separator: " ").map({Int($0)!})
var nodes : [Int:Node] = [:]
var circle = Node(value: initial[0])
circle.next = circle
nodes[circle.value] = circle
for i in 1..<initial.count {
    let next = circle.insertAfter(v: initial[i])
    circle = next
    nodes[circle.value] = next
}
let MAXVALUE = 1_000_000
if MAXVALUE > 9 {
    for i in 10...MAXVALUE {
        let next = circle.insertAfter(v: i)
        circle = next
        nodes[circle.value] = next
    }
}

func move(current : inout Node) {
    let currentV = current.value
    var cut = current.cut3After()
    
    let cutValues = [currentV, cut.value, cut.next!.value, cut.next!.next!.value]
    var nextV = currentV
    while cutValues.contains(nextV) {
        nextV -= 1
        if nextV < 1 {
            nextV = MAXVALUE
        }
    }
    nodes[nextV]!.insert3After(node3: &cut)
}

circle = nodes[initial[0]]!
for i in 1...10_000_000 {
    if i % 1000 == 0 {
        print(i)
    }
    move(current: &circle)
    circle = circle.next!
}

print(nodes[1]!.next!.value * nodes[1]!.next!.next!.value)
circle.next = nil

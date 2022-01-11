import aoc
from math import floor, ceil

def explode(number):
    for i, n in enumerate(number):
        if len(n[1]) > 4:
            if i > 0:
                number[i - 1][0] += n[0]
            if i + 2 < len(number):
                number[i + 2][0] += number[i + 1][0]
            number.pop(i)
            number[i][0] = 0
            number[i][1].pop()
            return True
    return False

def split(number):
    for i, n in enumerate(number):
        if n[0] > 9:
            number.pop(i)
            type = n[1].copy()
            type.append("r")
            number.insert(i, [ceil(n[0] / 2), type.copy()])
            type.pop()
            type.append("l")
            number.insert(i, [floor(n[0] / 2), type.copy()])
            return True
    return False


def add(x, y):
    for n in x:
        n[1].insert(0, "l")
    for n in y:
        n[1].insert(0, "r")
    return x + y


def reduce(n):
    while True:
        if explode(n):
            continue
        if not split(n):
            break
    return n


def readNum(line):
    number = []
    type = []
    for c in line:
        if c == "[":
            type.append("l")
        elif c == "]":
            type.pop()
        elif c == ",":
            type.pop()
            type.append("r")
        else:
            number.append([int(c), type.copy()])
    return number

def magnitude(number):
    while len(number) > 1:
        for i, n in enumerate(number):
            if n[1][-1] == "l" and number[i+1][1][-1] == "r":
                newNum = n.copy()
                newNum[0] = 3 * n[0] + 2 * number[i+1][0]
                newNum[1].pop()
                number.pop(i)
                number.pop(i)
                number.insert(i, newNum)
                break
    return number[0][0]

data = aoc.get_data(18)[0]

number = []
for i, l in enumerate(data):
   newNumber = readNum(list(l))
   if i == 0:
      number = newNumber
      continue
   number = add(number, newNumber)
   reduce(number)

print(f"Part 1: {magnitude(number)}")

mags = [magnitude(reduce(add(readNum(list(data[i])), readNum(list(data[j]))))) for i in range(0, len(data)) for j in range(0, len(data)) if i != j]
print(f"Part 2: {max(mags)}")

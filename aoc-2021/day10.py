import aoc
import numpy as np

data = "[({(<(())[]>[[{[]{<()<>> [(()[<>])]({[<{<<[]>>( {([(<{}[<>[]}>{[]{[(<()> (((({<>}<{<{<>}{[]{[]{} [[<[([]))<([[{}[[()]]] [{[{({}]{}}([{[{{{}}([] {<[[]]>}<{[{[{[]{()[[[] [<(<(<(<{}))><([]([]() <{([([[(<>()){}]>(<<{{ <{([{{}}[<[[[<>{}]]]>[]]".split()

data = aoc.get_data(10)[0]

pairs = {"(": ")", "{": "}", "[": "]", "<": ">"}

counters = {v: 0 for _, v in pairs.items()}
print(f"{counters}")

corrupted = []
for line in data:
    stack = []
    for char in line:
        if char in pairs:
            stack.append(char)
        elif char != pairs[stack.pop()]:
            print(f"invalid : {char}")
            counters[char] += 1
            corrupted.append(line)
            break

points = {")": 3, "]": 57, "}": 1197, ">": 25137}
print(f"{counters}")

result = 0
for k, v in counters.items():
    result += v * points[k]

print(f"{result}")

for line in corrupted:
    data.remove(line)

comp = []
for line in data:
    stack = []
    completion = []
    for char in line:
        if char in pairs:
            stack.append(char)
        else:
            stack.pop()
    while stack:
      completion.append(pairs[stack.pop()])

    print(f"{completion}")
    comp.append(completion)

points = {")": 1, "]": 2, "}": 3, ">": 4}

scores  = []
for c in comp:
    score = 0
    for char in c:
        score *= 5
        score += points[char]
    print(f"{score}")
    scores.append(score)

print(f"{np.median(scores)}")

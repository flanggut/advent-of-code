import aoc
import numpy as np

template, rulesdata = aoc.get_data(14)

template = np.array(list(template[0]))
print(f"{template}")

rules = {}
for line in rulesdata:
    p, n = line.split(" -> ")
    rules[p] = n
print(f"{rules}")

pairs = {}
counters = {}


def insertPair(pair, count):
    if pair in pairs:
        pairs[pair] += count
    else:
        pairs[pair] = count


def addCount(char, count):
    if char in counters:
        counters[char] += count
    else:
        counters[char] = count


for i in range(len(template) - 1):
    insertPair("".join(template[i : i + 2]), 1)
for i in template:
    addCount(i, 1)
print(f"{pairs}")


for _ in range(0, 40):
    toiter = pairs.copy()
    for pair in toiter:
        if pair in rules:
            pairs[pair] -= toiter[pair]
            insertPair(pair[0] + rules[pair], toiter[pair])
            insertPair(rules[pair] + pair[1], toiter[pair])
            addCount(rules[pair], toiter[pair])


values = sorted(counters.values())
print(f"{values[-1] - values[0]}")

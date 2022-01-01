import aoc


def fillremainder(linemap, digits):
    inv = {v: set(k) for k, v in linemap.items()}
    found = []
    for i in digits:
        if set(i).union(inv[1]) == inv[8]:
            inv[6] = set(i)
            found.append(i)
        elif set(i).union(inv[4]) == inv[8] and len(i) == 6:
            inv[0] = set(i)
            found.append(i)
        if set(i).union(inv[4]) == inv[8] and len(i) == 5:
            inv[2] = set(i)
            found.append(i)

    for i in found:
        digits.remove(i)
    found.clear()

    for i in digits:
        if len(i) == 6:
            inv[9] = set(i)
        elif len(set(i).difference(inv[1])) == 3:
            inv[3] = set(i)
        else:
            inv[5] = set(i)

    return {"".join(sorted(v)): k for k, v in inv.items()}


data = [
    "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
]

patterns = {
    0: ["a", "b", "c", "e", "f", "g"],
    1: ["c", "f"],
    2: ["a", "c", "d", "e", "f"],
    3: ["a", "c", "d", "f", "g"],
    4: ["b", "c", "d", "f"],
    5: ["a", "b", "d", "f", "g"],
    6: ["a", "b", "d", "e", "f", "g"],
    7: ["a", "c", "f"],
    8: ["a", "b", "c", "d", "e", "f", "g"],
    9: ["a", "b", "c", "d", "f", "g"],
}

setlookup = {"".join(v): k for k, v in patterns.items()}


result = 0
data = aoc.get_data(8)[0]

for line in data:
    unique = ["".join(sorted(i)) for i in line.split("|")[0].split()]
    output = ["".join(sorted(i)) for i in line.split("|")[1].split()]

    linemap = {}
    for i in unique:
        if len(i) == 2:
            linemap[i] = 1
        elif len(i) == 4:
            linemap[i] = 4
        elif len(i) == 3:
            linemap[i] = 7
        elif len(i) == 7:
            linemap[i] = 8
    for e in linemap.keys():
        unique.remove(e)

    linemap = fillremainder(linemap, unique)
    print(f"{linemap}")

    for i, v in enumerate(output):
        result += linemap[v] * 10 ** (3 - i)

    # for i in output:
    #     string = "".join(i)
    #     if string in linemap:
    #         result += 1
    #         print(f"{linemap[string]}")


print(f"{result}")

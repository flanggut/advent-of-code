import aoc


data = aoc.get_data(12)[0]
# data = "start-A start-b A-c A-b b-d A-end b-end".split()

print(f"{data}")

nodes = {"start": [], "end": []}
for line in data:
    n, m = line.split("-")
    if n in nodes:
        nodes[n].append(m)
    else:
        nodes[n] = [m]
    if m in nodes:
        nodes[m].append(n)
    else:
        nodes[m] = [n]


def findpaths(graph, doublenode):
    print(f"{doublenode}")
    finishedpaths = []
    paths = [(["start"], int(0))]

    while paths:
        path, counter = paths.pop()
        node = path[-1]
        for other in graph[node]:
            if (
                other.isupper()
                or other not in path
                or (other == doublenode and counter < 2)
            ):
                newpath = path.copy()
                newpath.append(other)
                if other == "end":
                    finishedpaths.append(newpath)
                else:
                    if other == doublenode:
                        paths.append((newpath, counter + 1))
                    else:
                        paths.append((newpath, counter))

    return finishedpaths


allpaths = []

for node in nodes:
    if node.islower() and node != "start" and node != "end":
        finishedpaths = findpaths(nodes, node)
        allpaths += [",".join(p) for p in finishedpaths]
    allpaths = list(set(allpaths))

for path in sorted(allpaths):
    print(f"{path}")

print(f"{len(allpaths)}")

import aoc
import numpy as np
from numpy.lib import stride_tricks

data = "2199943210 3987894921 9856789892 8767896789 9899965678".split()
data = aoc.get_data(9)[0]
data = [list(i) for i in data]

oa = np.array(data).astype(np.int32)
a = np.pad(oa, (1, 1), "maximum")
print(f"{a}")

wins = stride_tricks.sliding_window_view(a, (3, 3))
windows = np.reshape(wins, (wins.shape[0] * wins.shape[1], 3, 3))
print(f"{windows.shape}")


minpoints = []
result = 0
for i, w in enumerate(windows):
    if (
        w[1, 1] < w[1, 0]
        and w[1, 1] < w[0, 1]
        and w[1, 1] < w[1, 2]
        and w[1, 1] < w[2, 1]
    ):
        result += 1 + w[1, 1]
        coordx = i // wins.shape[1]
        coordy = i % wins.shape[1]
        minpoints.append((w[1, 1], np.array([coordx, coordy])))

print(f"{result}")
print(f"{minpoints}")

# region growing
offsets = [np.array([-1, 0]), np.array([0, -1]), np.array([1, 0]), np.array([0, 1])]
basins = []
for p in minpoints:
    q = [p]
    counter = 1
    pushed = []
    while q:
        value, coord = q.pop(0)
        for o in offsets:
            nc = coord + o
            x = nc[0]
            y = nc[1]
            if x < 0 or y < 0 or x >= oa.shape[0] or y >= oa.shape[1]:
                continue
            if oa[x, y] < 9 and oa[x, y] > value and (x, y) not in pushed:
                pushed.append((x, y))
                t = (oa[x, y], nc)
                q.append(t)
                counter += 1
    print(f"{counter}")
    basins.append(counter)

result = sorted(basins)[-3:]
print(f"{result}")
print(f"{np.prod(result)}")

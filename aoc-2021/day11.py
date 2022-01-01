import aoc
import numpy as np


data = aoc.get_data(11)[0]

data = [list(i) for i in data]

a = np.array(data).astype(np.int8)

adj = [(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1)]


def isInGrid(a, x, y):
    return x >= 0 and y >= 0 and x < a.shape[0] and y < a.shape[1]


def flash(a, coord):
    x, y = coord
    for dx, dy in adj:
        cx = x + dx
        cy = y + dy
        if isInGrid(a, cx, cy) and a[cx, cy] >= 0:
            a[cx, cy] += 1
    a[x, y] = -1
    return a


def step(a, numflashes):
    a = a + np.ones_like(a)
    ii = list(zip(*np.where(a > 9)))
    localflashes = 0
    while ii:
        for coord in ii:
            a = flash(a, coord)
            numflashes += 1
            localflashes += 1
        ii = list(zip(*np.where(a > 9)))
    a[a < 0] = 0
    return (a, numflashes, localflashes)


numflashes = 0
for i in range(0, 1000):
    a, numflashes, localflashes = step(a, numflashes)
    if i == 99:
        print(f"{numflashes}")
    if localflashes == 100:
        print(f"{i + 1}")
        break


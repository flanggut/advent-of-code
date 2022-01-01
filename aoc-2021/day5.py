import aoc
import numpy as np


def drawlinetogrid(grid, begin, end):
    diff = end - begin
    numpoints = np.max(np.abs(diff))
    if numpoints == 0:
        return
    diff = diff / numpoints
    for i in range(0, numpoints + 1):
        coord = (begin + i * diff).astype(int)
        grid[coord[0], coord[1]] += 1


data = aoc.get_data(5)[0]

board = np.zeros(shape=(1000, 1000))

for line in data:
    begin, end = line.split(" -> ")
    begin = np.array(begin.split(",")).astype(int)
    end = np.array(end.split(",")).astype(int)
    drawlinetogrid(board, begin, end)

print(np.count_nonzero(board >= 2))

from numpy.core.numeric import zeros_like
import aoc
import numpy as np

data = "1163751742 1381373672 2136511328 3694931569 7463417111 1319128137 1359912421 3125421639 1293138521 2311944581".split()
data = aoc.get_data(15)[0]

data = [list(d) for d in data]
board = np.array(data).astype(int)

nextboard1 = np.ones_like(board) + board
nextboard1[nextboard1 == 10] = 1
nextboard2 = np.ones_like(board) + nextboard1
nextboard2[nextboard2 == 10] = 1
nextboard3 = np.ones_like(board) + nextboard2
nextboard3[nextboard3 == 10] = 1
nextboard4 = np.ones_like(board) + nextboard3
nextboard4[nextboard4 == 10] = 1
board = np.hstack([board, nextboard1, nextboard2, nextboard3, nextboard4])

nextboard1 = np.ones_like(board) + board
nextboard1[nextboard1 == 10] = 1
nextboard2 = np.ones_like(board) + nextboard1
nextboard2[nextboard2 == 10] = 1
nextboard3 = np.ones_like(board) + nextboard2
nextboard3[nextboard3 == 10] = 1
nextboard4 = np.ones_like(board) + nextboard3
nextboard4[nextboard4 == 10] = 1
board = np.vstack([board, nextboard1, nextboard2, nextboard3, nextboard4])

neigbors = [(0, 1), (1, 0), (-1, 0), (0, -1)]

dist = np.full_like(board, 2 ** 30)
prevx = np.full_like(board, -1)
prevy = np.full_like(board, -1)
allcoords = aoc.coords_for_array(board).tolist()
allcoords = [tuple(c) for c in allcoords]

source = (0, 0)
target = (board.shape[0] - 1, board.shape[1] - 1)
dist[source] = 0

updated_coords = set([source])
allcoords = set(allcoords)

valid = zeros_like(dist)

while allcoords:
    newdist = dist + valid
    testcoords = np.where(newdist == np.amin(newdist))
    coord = list(zip(testcoords[0], testcoords[1]))[0]

    if coord == (board.shape[0] - 1, board.shape[1] - 1):
        break
    allcoords.remove(coord)
    valid[coord] = 2**30

    for n in neigbors:
        nx = coord[0] + n[0]
        ny = coord[1] + n[1]
        nc = (nx, ny)
        if (
            nx < 0
            or nx >= board.shape[0]
            or ny < 0
            or ny >= board.shape[1]
            or nc not in allcoords
        ):
            continue
        alt = dist[coord] + board[nc]
        if alt < dist[nc]:
            dist[nc] = alt
            prevx[nc] = coord[0]
            prevy[nc] = coord[1]
            updated_coords.add(nc)

path = []
u = target
risk = 0
if prevx[u] >= 0 and prevy[u] >= 0:
    while u[0] >= 0 and u[1] >= 0:
        path.append(u)
        nx = prevx[u]
        ny = prevy[u]
        u = (nx, ny)

print(f"{path[::-1]}")
print(f"{dist[target]}")

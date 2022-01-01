import aoc
import numpy as np

coorddata, folddata = aoc.get_data(13)

coordlist = []
for e in coorddata:
    coordlist.append(np.array(e.split(",")).astype(int))
coords = np.array(coordlist)

size = (np.max(coords[:, 1]) + 1, np.max(coords[:, 0]) + 1)
print(f"{size}")

board = np.zeros(shape=size, dtype=np.uint8)

for c in coordlist:
    board[c[1], c[0]] = 8
print(f"{board}")


def fold_horizontal(board, value):
    for i in range(1, board.shape[0] - value):
        for j in range(0, board.shape[1]):
            board[value - i, j] |= board[value + i, j]
    return board[0:value, :]


def fold_vertical(board, value):
    for i in range(0, board.shape[0]):
        for j in range(1, board.shape[1] - value):
            board[i, value - j] |= board[i, value + j]
    return board[:, 0:value]


np.set_printoptions(linewidth=100)
for fold in folddata:
    axis, value = fold.split("g ")[1].split("=")
    value = int(value)
    if axis == "y":
        board = fold_horizontal(board, value)
    else:
        board = fold_vertical(board, value)
    print(f"{board}")
    print(f"{np.count_nonzero(board)}")

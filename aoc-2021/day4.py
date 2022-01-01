import aoc
import numpy as np


def didwin(board):
    for i in range(0, board.shape[0]):
        if np.sum(board[i, :]) == -board.shape[0]:
            return True

    for i in range(0, board.shape[1]):
        if np.sum(board[:, i]) == -board.shape[1]:
            return True

    return False


data = aoc.get_data(4)

numbers = [int(i) for i in data[0][0].split(",")]
print(numbers)
boards = data[1:]

npboards = [np.array(np.char.split(board).tolist()).astype(int) for board in boards]

haswon = np.array([False for _ in boards])
for n in numbers:
    if haswon.all():
        break
    for i, board in enumerate(npboards):
        if haswon[i]:
            continue
        board[board == n] = -1
        haswon[i] = didwin(board)
        if haswon.all():
            sum = np.sum(board[board > 0])
            print(sum * n)

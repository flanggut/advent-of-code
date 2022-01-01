import numpy as np


def get_data(day=1):
    with open(f"data/day{day}.dat") as file:
        data = [s.split("\n") for s in file.read().strip().split("\n\n")]
        return data


def get_example(day=1):
    with open(f"data/day{day}.ex") as file:
        data = [s.split("\n") for s in file.read().strip().split("\n\n")]
        return data


def coords_for_array(array):
    return np.column_stack(
        map(np.ravel, np.meshgrid(np.arange(array.shape[0]), np.arange(array.shape[1])))
    )

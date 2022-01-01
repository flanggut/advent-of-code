import aoc
import numpy as np


def binarray_to_num(array):
    result = 0
    size = array.size - 1
    for i, v in enumerate(array):
        result += int(v) << (size - i)
    return result


def most_least(array):
    mostcommon = [int(i) - 1 for i in np.round(np.mean(array + 1, 0))]
    leastcommon = [-i + 1 for i in mostcommon]
    return (mostcommon, leastcommon)


data = aoc.get_data(3)[0]
lists = [list(i) for i in data]
array = np.array(lists).astype(int)

mean = np.round(np.mean(array, 0))

size = mean.size - 1
gamma = 0
for i, v in enumerate(mean):
    gamma += int(v) << (size - i)

epsilon = 0
for i, v in enumerate(mean):
    if v == 0:
        epsilon += 1 << (size - i)

print(gamma * epsilon)


data = aoc.get_data(3)[0]
lists = [list(i) for i in data]
array = np.array(lists).astype(int)

most, least = most_least(array)
i = 0
while array.shape[0] > 1:
    array = array[array[:, i] == most[i]]
    most, least = most_least(array)
    i += 1
oxygen = binarray_to_num(array[0, :])
print(oxygen)

array = np.array(lists).astype(int)
most, lest = most_least(array)
i = 0
while array.shape[0] > 1:
    array = array[array[:, i] == least[i]]
    most, least = most_least(array)
    i += 1
co = binarray_to_num(array[0, :])
print(co)

print(co * oxygen)

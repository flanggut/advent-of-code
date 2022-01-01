import aoc


def countup(data, offset=1):
    counter = 0
    for i in range(len(data) - offset):
        print(i)
        if data[i + offset] > data[i]:
            print(f"{data[i+offset]} > {data[i]}")
            counter += 1
        else:
            print(f"{data[i+offset]} < {data[i]}")
    return counter


data = [int(i) for i in aoc.get_example(1)[0]]
data = [int(i) for i in aoc.get_data(1)[0]]
print(countup(data, 3))

import aoc

data = aoc.get_data(2)[0]
directions = [i.split(" ") for i in data]

horizontal = 0
depth = 0

for dir, distance in directions:
    dist = int(distance)
    if dir == "forward":
        horizontal += dist
    elif dir == "down":
        depth += dist
    elif dir == "up" : 
        depth -= dist


data = aoc.get_data(2)[0]
directions = [i.split(" ") for i in data]

aim = 0
horizontal = 0
depth = 0

for dir, distance in directions:
    dist = int(distance)
    if dir == "forward":
        horizontal += dist
        depth += aim * dist
    elif dir == "down":
        aim += dist
    elif dir == "up" : 
        aim -= dist

print(horizontal * depth)

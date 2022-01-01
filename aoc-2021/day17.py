minx = 20
maxx = 30
miny = -10
maxy = -5

minx = 25
maxx = 67
miny = -260
maxy = -200

def simulate(vx, vy):
    x = 0
    y = 0
    highest = 0
    while y > miny:
        x += vx
        y += vy
        if vx > 0:
            vx -= 1
        elif vx < 0:
            vx += 1
        vy -= 1
        if vy == 0:
            highest = y

        if x >= minx and x <= maxx and y >= miny and y <= maxy:
            return highest

    return -1


result = 0
num = 0
for x in range(1, maxx + 1):
    for y in range(miny, 500):
        v = simulate(x, y)
        if v >= 0:
            num += 1
        if v > result:
            result = v


print(f"{result}")
print(f"{num}")

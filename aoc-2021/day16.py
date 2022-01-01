import aoc

data = aoc.get_data(16)[0][0]

hex_to_bits = {
    "0": "0000",
    "1": "0001",
    "2": "0010",
    "3": "0011",
    "4": "0100",
    "5": "0101",
    "6": "0110",
    "7": "0111",
    "8": "1000",
    "9": "1001",
    "A": "1010",
    "B": "1011",
    "C": "1100",
    "D": "1101",
    "E": "1110",
    "F": "1111",
}

bits_to_hex = {v: k for k, v in hex_to_bits.items()}


class Transmission:
    data = []

    def __init__(self, data) -> None:
        if isinstance(data, str):
            for char in data:
                self.data += list(hex_to_bits[char])
        else:
            self.data = data

        print(f"Transmission with: {len(self.data)} bits")

    def get_bits(self, num: int) -> str:
        if num == 0:
            return ""
        bits = ""
        for _ in range(0, num):
            bits += self.data.pop(0)
        return bits


class Node:
    def __init__(self) -> None:
        self.version = 0
        self.operator = 0
        self.value = ""
        self.nodes = []

    def int_val(self):
        if not self.value:
            return 0
        return int(self.value, 2)

    def versionsum(self) -> int:
        sum = self.version
        for node in self.nodes:
            sum += node.versionsum()
        return sum

    def execute(self) -> int:
        result = 0
        if self.operator == 1:
            result = 1
        elif self.operator == 2:
            result = 2**30
        elif self.operator == 3:
            result = 0
        elif self.operator == 4:
            return self.int_val()
        elif self.operator == 5:
            return int(self.nodes[0].execute() > self.nodes[1].execute())
        elif self.operator == 6:
            return int(self.nodes[0].execute() < self.nodes[1].execute())
        elif self.operator == 7:
            return int(self.nodes[0].execute() == self.nodes[1].execute())

        for node in self.nodes:
            if self.operator == 0:
                result += node.execute()
            elif self.operator == 1:
                result *= node.execute()
            elif self.operator == 2:
                result = min(result, node.execute())
            elif self.operator == 3:
                result = max(result, node.execute())

        return result


def read_value(t: Transmission):
    value = ""
    bits_read = 5
    while t.get_bits(1) == "1":
        value += t.get_bits(4)
        bits_read += 5
    value += t.get_bits(4)
    return (value, bits_read)


def read_package(t: Transmission):
    version = int(t.get_bits(3), 2)
    typeId = int(t.get_bits(3), 2)
    bits_read = 6

    node = Node()
    node.version = version
    node.operator = typeId

    if typeId == 4:
        node.value, numread = read_value(t)
        bits_read += numread
        print(f"Value: {version}, {typeId}, {node.int_val()}")
        return (node, bits_read)

    print(f"Operator: {version}, {typeId}, {node.operator}")
    length_type_id = t.get_bits(1)
    bits_read += 1

    total_length = 0
    num_sub_packages = 0

    if length_type_id == "0":
        total_length = int(t.get_bits(15), 2)
        bits_read += 15
    else:
        num_sub_packages = int(t.get_bits(11), 2)
        bits_read += 11

    subpackage_bits_read = 0
    subpackages_read = 0
    while total_length > subpackage_bits_read or num_sub_packages > subpackages_read:
        subnode, numread = read_package(t)
        node.nodes.append(subnode)
        bits_read += numread
        subpackage_bits_read += numread
        subpackages_read += 1

    return (node, bits_read)


node, _ = read_package(Transmission(data))
print(f"{node.versionsum()}")
print(f"{node.execute()}")

import sys


def read():
    root = {}
    root['__parrent'] = root
    current = root
    parrent = root
    while True:
        line = sys.stdin.readline().strip()
        if not line:
            break
        if line.startswith("$"):
            line = line[2:]
            if not line.startswith("cd"):
                continue
            line = line[3:]
            if line == '..':
                current = parrent
                parrent = current["__parrent"]
            elif line == '/':
                current = root
                parrent = root
            else:
                parrent = current
                current = current.get(line, None)
                if current is None:
                    current = {'__parrent': parrent}
                    parrent[line] = current

        else:  # ls, ignore dir
            if not line.startswith("dir"):
                size, name = line.split(" ")
                current[name] = int(size)
    return root


def count(tree, cwd, sizes):
    size = 0
    for path, val in tree.items():
        if path == '__parrent':
            continue
        if type(val) is dict:
            path_size = count(val, f'{cwd}/{path}', sizes)
            size += path_size
        else:
            size += val
    sizes[cwd] = size
    return size


if __name__ == '__main__':
    sizes = {}
    count(read(), '/',  sizes)
    print(sum(i for i in sizes.values() if i <= 100000))

    # part 2
    total = 70000000
    required = 30000000
    free = total - sizes["/"]
    missing = required - free
    print(min(i for i in sizes.values() if i >= missing))

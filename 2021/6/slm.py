import sys
import time

nr = list(map(int,sys.stdin.readline().split(',')))
iter = 256

cache={
}

def sim(start, n):
    res = cache.get(start, 0)
    if res != 0:
        return res
    print(f"checking {start}")

    all=bytearray([start])
    for day in range(n):
        for i in range(len(all)):
            if all[i]==0:
                all[i]=6
                all.append(8)
            else:
                all[i]-=1
    cache[start] = len(all)
    print(f"res {start}:{cache[start]}")
    return cache[start]

res = 0
for n in nr:
    res += sim(n, iter)

print(res)

import sys
import time
from statistics import median

nr = list(map(int,sys.stdin.readline().split(',')))

m = median(nr)
l = 0
for n in nr:
    l+=abs(n-m)
print(l)

import math
avg = math.floor(sum(nr)/len(nr))
print(avg)
l = 0
for n in nr:
    n = abs(n-avg)
    l+= n*(n+1)/2
print(l)

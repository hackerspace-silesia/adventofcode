# only part 2
import sys
input = []

for line in sys.stdin:
    input.append(line)


oxygen = input.copy()
index = 0
while len(oxygen)>1:
    ones = [i for i in oxygen if i[index]=="1"]
    zeros = [i for i in oxygen if i[index]=="0"]
    if len(ones)>=len(zeros):
        oxygen = ones
    else:
        oxygen = zeros
    index += 1

co = input.copy()
index = 0
while len(co)>1:
    ones = [i for i in co if i[index]=="1"]
    zeros = [i for i in co if i[index]=="0"]
    if len(ones)<len(zeros):
        co = ones
    else:
        co = zeros
    index += 1
print(int(co[0],2) * int(oxygen[0],2))


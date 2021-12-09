import sys
import time
from statistics import median

lines = []

'''
 0000
1    2
1    2
 3333
4    5
4    5
 6666
'''

segments =[
'abcdefg',
'abcdefg',
'abcdefg',
'abcdefg',
'abcdefg',
'abcdefg',
'abcdefg',
]

c=0
for line in sys.stdin:
    segs = segments.copy()
    p1, p2 = line.split('|')
    all = p1.split()
    all.extend(p2.split())

    zero = one = two = three = four = five = six = seven = eight = nine = ""

    # unique numbers of segement for numbers: 1, 4, 7
    for d in all:
        l = len(d)
        if l == 2: # number 1, segemtns 2, 5
            for i in [0,1,3,4,6]:
                for s in d:
                    segs[i] = segs[i].replace(s, "")
            one = d
        if l == 4: # number 4, segemtns 1, 2, 3, 5
            for i in [0,4,6]:
                for s in d:
                    segs[i] = segs[i].replace(s, "")
            four = d
        if l == 3: # number 7, segemtns 0, 2, 5
            for i in [1, 3, 4, 6]:
                for s in d:
                    segs[i] = segs[i].replace(s, "")
            seven = d


    # 1 and 7 share one segment
    if one and seven:
        segs[0] = (set(seven)-set(one)).pop()
        for i in [1, 2, 3, 4, 5, 6]:
            for s in d:
                segs[i] = segs[i].replace(segs[0], "")

    # 0, 6 and 9 have len 6. But only 9 shares all segments with 4
    if four:
        for d in all:
            if len(d) != 6: continue
            if not set(four).issubset(set(d)): continue
            nine = d
            segs[6] = (set(nine)-set(four)-set(seven)).pop()
            for i in [0, 1, 2, 3, 4, 5]:
                for s in d:
                    segs[i] = segs[i].replace(segs[6], "")

    # 2 ,3  and 5 have len 5. Having 9 we can get segments 4 and 5
    if nine:
        s_nine = set(nine)
        for d in all:
            if len(d) != 5: continue
            # 2
            s = set(d) - s_nine
            if len(s) == 1:
                segs[4] = s.pop()
                two = d
                for i in [0, 1, 2, 3, 5, 6]:
                    for s in d:
                        segs[i] = segs[i].replace(segs[4], "")

    # having two we can get from three segment 5
    if two:
        s_two = set(two)
        for d in all:
            if len(d) != 5: continue
            # 3
            s = set(d) - s_two
            if len(s) == 1:
                segs[5] = s.pop()
                three = d
                for i in [0, 1, 2, 3, 4, 6]:
                    for s in d:
                        segs[i] = segs[i].replace(segs[5], "")

    # havin three and two we can get five and segment 1
    if two and three:
        stt = set(two+three)
        for d in all:
            if len(d) != 5: continue
            # 5
            s = set(d) - stt
            if len(s) == 1:
                segs[1] = s.pop()
                five = d
                for i in [0,  2, 3, 4, 5, 6]:
                    for s in d:
                        segs[i] = segs[i].replace(segs[1], "")


    for i in range(len(segs)):
        for j in range(len(segs)):
            if i == j: continue
            if len(segs[j]) != 1: continue
            segs[i] = segs[i].replace(segs[j], "")

    s=segs
    m = {
        "0": set([s[0], s[1],s[2],s[4],s[5],s[6]]),
        "1": set([s[2],s[5]]),
        "2": set([s[0], s[2], s[3], s[4],s[6]]),
        "3": set([s[0], s[2],s[3],s[5],s[6]]),
        "4": set([s[1],s[2], s[3], s[5]]),
        "5": set([s[0], s[1],s[3],s[5],s[6]]),
        "6": set([s[0], s[1],s[3],s[4],s[5],s[6]]),
        "7": set([s[0], s[2],s[5]]),
        "8": set("abcdefg"),
        "9": set([s[0], s[1], s[2], s[3],s[5],s[6]]),
    }

    nr = ""
    for p in p2.split():
        p = set(p)
        for k, v in m.items():
            if p == v:
                nr+=k
                break
    c+=int(nr)
print(c)



#!/usr/bin/env python
import sys

avg = 0
mx = -1
ct = 0

for line in open(sys.argv[1]):
    ct += 1
    line = line.strip().split()
    BLEU = float(line[4][:-1])
    time = float(line[-1])

    mx = max(BLEU, mx)
    avg += time

    if len(sys.argv) > 2 and ct == int(sys.argv[2]):
        break

avg /= ct


print("%60s: Average time = %f, Max BLEU = %f, Score = %f, iteration=%d" % (sys.argv[1], avg, mx, BLEU,ct))


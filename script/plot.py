#!/usr/bin/env python3

import matplotlib.pyplot as plt
import sys

if len(sys.argv) <= 1:
    raise Exception("Usage plot.py [PROGS]")

output = sys.argv[-1]
# Read in data
data = []
for i in range(1,len(sys.argv)-1):
    name = sys.argv[i]
    with open(name) as fp:
        bleu_arr = []
        time_arr = []
        name = name.split("/")[-1]
        name = name[:name.index(".")]
        for line in fp:
            line = line.strip().split()
            bleu_arr.append(float(line[4][:len(line[4])-1]))
            time_arr.append(float(line[-1]))
        data.append((name, bleu_arr, time_arr))

for name, bleu, time in data:
    plt.plot(time, bleu, marker="o")

plt.xlabel("time (minutes)")
plt.ylabel("BLEU")
plt.grid(True)
plt.savefig(output)
plt.show()

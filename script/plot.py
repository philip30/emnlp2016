#!/usr/bin/env python3

import matplotlib.pyplot as plt
import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--input", nargs="+", type=str)
parser.add_argument("--output", type=str)
parser.add_argument("--mode", type=str, choices=["time", "epoch"], default="time")
parser.add_argument("--cut_time", type=int, default=1e10)
args = parser.parse_args()

output = args.output
# Read in data
data = []
for i in range(len(args.input)):
    name = args.input[i]
    with open(name) as fp:
        bleu_arr = []
        time_arr = []
        name = name.split("/")[-1]
        name = name[:name.index(".")]
        for i, line in enumerate(fp):
            line = line.strip().split()
            bleu_arr.append(float(line[4][:len(line[4])-1]))
            if args.mode == "epoch":
                time_arr.append(i+1)
            else:
                time_arr.append(float(line[-1]))
        data.append((name, bleu_arr, time_arr))

for name, bleu, time in data:
    plt.plot(time, bleu, marker="o")

if args.mode == "epoch":
    plt.xlabel("epoch")
else:
    plt.xlabel("time (minutes)")
plt.ylabel("BLEU")
plt.grid(True)
plt.savefig(output)
plt.show()

#!/usr/bin/env python3

import matplotlib.pyplot as plt
import sys
import argparse

filled_markers = ('o', 'v', '^', '*', 'h', 'D', '>', '<')

parser = argparse.ArgumentParser()
parser.add_argument("--input", nargs="+", type=str)
parser.add_argument("--output", type=str)
parser.add_argument("--mode", type=str, choices=["time", "epoch"], default="time")
parser.add_argument("--cut_time", type=int, default=1e10)
parser.add_argument("--label", type=str, nargs="+", default=[])
args = parser.parse_args()

def parse_name(name):
    name = name.split("/")[-2]
    return name

output = args.output
# Read in data
data = []
legend = args.label
for i in range(len(args.input)):
    name = args.input[i]
    if len(legend) == 0: legend.append(parse_name(name))
    with open(name) as fp:
        bleu_arr = []
        time_arr = []
        time = 0
        name = name.split("/")[-1]
        name = name[:name.index(".")]
        for i, line in enumerate(fp):
            line = line.strip().split()
            
            if args.mode == "epoch":
                if args.cut_time and args.cut_time >= i+1:
                    bleu_arr.append(float(line[4][:len(line[4])-1]))
                    time_arr.append(i+1)
            else:
                time += float(line[-1])
                if args.cut_time and args.cut_time >= time:
                    bleu_arr.append(float(line[4][:len(line[4])-1]))
                    time_arr.append(time)
        data.append((name, bleu_arr, time_arr))

for i, (name, bleu, time) in enumerate(data):
    plt.plot(time, bleu, marker=filled_markers[i])

if args.mode == "epoch":
    plt.xlabel("epoch")
else:
    plt.xlabel("time (minutes)")

plt.ylabel("BLEU")
plt.legend(legend, loc="best")
plt.grid(True)
plt.savefig(output,bbox_inches='tight')

plt.show()

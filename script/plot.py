#!/usr/bin/env python3

import matplotlib
import matplotlib.pyplot as plt
import sys
import argparse

matplotlib.rcParams.update({'font.size': 22})

filled_markers = ('o', 'H', '^', '*', 's', 'D', 'x', 'p', '+', '|', '_')

parser = argparse.ArgumentParser()
parser.add_argument("--input", nargs="+", type=str)
parser.add_argument("--output", type=str)
parser.add_argument("--mode", type=str, choices=["time", "epoch"], default="time")
parser.add_argument("--cut_time", type=int, default=1e10)
parser.add_argument("--label", type=str, nargs="+", default=[])
parser.add_argument("--eval", type=str, choices=["BLEU", "NIST"], default="BLEU")
args = parser.parse_args()

def parse_name(name):
    name = name.split("/")[-2]
    return name

valid_line_len = -1
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
            
            if valid_line_len == -1:
                valid_line_len = len(line)
            elif valid_line_len != len(line):
                continue


            if args.eval == "BLEU":
                f = lambda x: x[4][:len(line[4])-1]
            else:
                f = lambda x: x[2][5:]

            score = float(f(line))
            if abs(score) < 1e-6:
                continue
            if args.mode == "epoch":
                if args.cut_time and args.cut_time >= i+1:
                    bleu_arr.append(score)
                    time_arr.append(i+1)
            else:
                time += float(line[-1])
                if args.cut_time and args.cut_time >= i+1:
                    bleu_arr.append(score)
                    time_arr.append(time)
        data.append((name, bleu_arr, time_arr))

fig = plt.figure(figsize=(8,5))
ax = fig.add_subplot(1,1,1)
for i, (name, bleu, time) in enumerate(data):
    ax.plot(time, bleu, marker=filled_markers[i], markersize=10, linestyle=":", label=legend[i])
ax.legend(prop={'size':15})

if args.mode == "epoch":
    ax.set_xlabel("epoch")
else:
    ax.set_xlabel("time (minutes)")

ax.set_ylabel(args.eval)
plt.grid(True)
#
fig.savefig(output,bbox_inches='tight', format='eps', dpi=1000)


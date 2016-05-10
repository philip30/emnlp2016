#!/usr/bin/env python3

import sys

out = []
base = []
ref = []
src = []

if len(sys.argv) <= 3:
    raise Exception("USAGE: show-different.py [DCT] [ATT] [SRC] [REFERENCE]")

def read(arr, file_dir):
    with open(file_dir) as sys_fp:
        for line in sys_fp:
            arr.append(line.strip())

read(out, sys.argv[1])
read(base, sys.argv[2])
read(ref, sys.argv[4])
read(src, sys.argv[3])

assert(len(out) == len(base) == len(ref) == len(src))

for i, (out_l,  base_l, ref_l, src_l) in enumerate(zip(out, base, ref, src)):
    if base_l != out_l:
        print("EX#  :", (i+1))
        print("SRC  :", src_l)
        print("DCT  :", out_l)
        print("ATT  :", base_l)
        print("REF  :", ref_l)
        print("===================================================")


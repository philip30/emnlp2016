#!/usr/bin/env python3
# arg1: SRC
# arg2: TRG
# arg3: SRC_OUT
# arg4: TRG_OUT
# arg5: max_len

# This script will first remove sentence that has length > threshold

import sys
from collections import defaultdict

short_threshold = int(sys.argv[5])
def short_enough(sent):
    l = len(sent.split())
    return l <= short_threshold and l != 0

data = []
with open(sys.argv[1]) as src_fp:
    with open(sys.argv[2]) as trg_fp:
        for src, trg in zip(src_fp, trg_fp):
            src_tok = src.strip().split()
            data.append((src.strip(), trg.strip()))

with open(sys.argv[3], "w") as src_fp:
    with open(sys.argv[4], "w") as trg_fp:
        for item in data:
            if short_enough(item[0]) and short_enough(item[1]):
                print(item[0], file=src_fp)
                print(item[1], file=trg_fp)


#!/usr/bin/env python3

import sys
from collections import defaultdict

src_trg = defaultdict(lambda:0)
count   = defaultdict(lambda:0)
total = 0
non_word = 0
with open(sys.argv[1]) as en_file:
    with open(sys.argv[2]) as ja_file:
        for en, ja in zip(en_file, ja_file):
            en = en.strip().lower()
            ja = ja.strip().lower()

            en_len = len(en.split())
            ja_len = len(ja.split())
            
            if en_len == ja_len and en_len == 1:
                src_trg[en,ja] += 1
                count[en] += 1
                count[ja] += 1
            else:
                non_word += 1
            total += 1

print("Non lexical: %d" % non_word, file=sys.stderr)
print("Total      : %d" % total, file=sys.stderr)

def write_prob(dct, fout, which):
    for x, ct in sorted(dct.items(), key=lambda x: x[0][0]):
        en, ja = x[::which]
        prob = float(ct) / count[ja]
        print("%s %s %f" % (en, ja, prob), file=fout)

with open(sys.argv[3], "w") as st_out:
    with open(sys.argv[4], "w") as ts_out:
        write_prob(src_trg, st_out, 1)
        write_prob(src_trg, ts_out, -1)
        

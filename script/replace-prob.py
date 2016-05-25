#!/usr/bin/env python

import sys
from collections import defaultdict

handmade = defaultdict(lambda:{})
automatic = defaultdict(lambda:{})

def read_dict(dct, out):
    with open(dct) as dfp:
        for line in dfp:
            try:
                t, s, p = line.strip().split()
                out[s][t] = float(p)
            except: pass

read_dict(sys.argv[1], handmade)
read_dict(sys.argv[2], automatic)

uncovered = [x for x in automatic if x not in handmade]
coverage = (len(automatic) - len(uncovered)) / len(automatic)
print("Coverage:", coverage, file=sys.stderr)

# replacing
for src in handmade:
    if src in automatic:
        automatic[src] = handmade[src]

for src, trg_prob in sorted(automatic.items()):
    for trg, prob in sorted(trg_prob.items()):
        print("%s %s %f" % (trg, src, prob))

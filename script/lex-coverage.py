#!/usr/bin/env python3

import sys

words = set()
covered = set()
for line in sys.stdin:
    line = line.strip().split()
    for word in line:
        words.add(word)

with open(sys.argv[1]) as lex_fp:
    for line in lex_fp:
        trg, src, prob = line.strip().split()
        covered.add(src)

print("Coverage: %f" % (float(len([x for x in words if x in covered])) / len(words)))

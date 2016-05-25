#!/usr/bin/env python

import sys
from collections import defaultdict

dct = defaultdict(lambda:0)
for line in sys.stdin:
    s, t, p= line.strip().split()
    dct[t] += float(p)

for x, p in dct.items():
    print(x, p)


#!/usr/bin/env python

import sys

tok = set()
max_len = 0

for line in sys.stdin:
    line = line.lower().strip().split()
    
    max_len = max(max_len, len(line))
    for t in line:
        tok.add(t)

print("Unique tokens:",len(tok))
print("Max sentence length:", max_len)

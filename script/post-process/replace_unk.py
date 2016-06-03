#!/usr/bin/env python3

import sys
import argparse

parser = argparse.ArgumentParser("Replace Unk")
parser.add_argument("-s", "--src", required=True, type=str, help="src file")
parser.add_argument("-a", "--align", required=True, help="Alignment file from nmt.py")
parser.add_argument("-p", "--lex", required=True, help="Lexical probability file p(s|t)")
parser.add_argument("-v", "--verbose", action="store_true", help="Print error message or not")
args = parser.parse_args()

# Reading in src
with open(args.src) as src_fp:
    srcs = []
    for line in src_fp:
        srcs.append(line.strip().split())

# Reading in alignment file to take the alignment matrices
align = []
i     = -1
with open(args.align) as align_fp:
    for line in align_fp:
        line = line.strip()
        if line.isdigit():
            align.append([])
            i = int(line)
        else:
            line = line.split()
            if len(align[i]) != 0: line = list(map(float, line[1:]))
            align[i].append(line)

# 2 is a plus from EOS and src_head
assert(all(len(x) == len(y)+2 for (x, y) in zip(align, srcs)))

# Taking argmax_src of p(src|trg)
word_prob = {}
word_dct  = {}
with open(args.lex) as lex_fp:
    for line in lex_fp:
        try :
            trg, src, prob = line.strip().split()
        except:
            continue
        prob = float(prob)
        if src not in word_prob or word_prob[src] < prob:
            word_prob[src] = prob
            word_dct[src]  = trg

# Start replacing unknown word 1 by 1
def replace_unknown(word_dct, trg_word, src):
    if src not in word_dct:
        return src
    else:
        return word_dct[src]

def find_max(trg_index, src, align):
    assert(len(src) == len(align))
    word_max = None
    align_max = -1
    for src_word, prob in zip(src, align):
        prob = prob[trg_index]
        if prob > align_max:
            word_max  = src_word
            align_max = prob
    if args.verbose:
        print("Choosing", word_max, "to replace", trg_index, file=sys.stderr)
    assert(word_max is not None)
    return word_max

assert(len(srcs) == len(align))
for src, align_matrix in zip(srcs, align):
    trg = align_matrix[0][:-1] #except eos
    a   = align_matrix[1:-1] # except eos
    if args.verbose:
        print("SRC   :", " ".join(src), file=sys.stderr)
        print("BEFORE:", " ".join(trg), file=sys.stderr)
    for i, trg_word in enumerate(trg):
        if trg_word == "<UNK>":
            trg[i] = replace_unknown(word_dct, trg_word, find_max(i, src, a))
    if args.verbose:
        print("AFTER :", " ".join(trg), file=sys.stderr)
        print("---------------------------------", file=sys.stderr)
    print(" ".join(trg))

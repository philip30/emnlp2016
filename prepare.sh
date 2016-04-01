#!/bin/bash

set -e
set -o xtrace

THRESHOLD=80

for x in 001 002 004 008 016 032 064 128; do
    script/clean-batch.py data/par-lamtram/train-$x.en data/par-lamtram/train-$x.ja data/par-lamtram/train-$x.clean.en data/par-lamtram/train-$x.clean.ja $THRESHOLD 
done


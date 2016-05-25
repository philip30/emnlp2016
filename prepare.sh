#!/bin/bash

set -e
set -o xtrace

THRESHOLD=50

data() {
    for x in 001 002 004 008 016 032 064 128; do
        script/clean-batch.py data/btec/train-$x.en data/btec/train-$x.ja data/btec/train-$x.clean.en data/btec/train-$x.clean.ja $THRESHOLD 
    done
    script/clean-batch.py data/kftt/kyoto-train.en data/kftt/kyoto-train.ja data/kftt/kyoto-train.clean.en data/kftt/kyoto-train.clean.ja $THRESHOLD
}


lexicon() {
    # Eijiro
    script/extract-eijiro.py data/eijiro/EIJI-133.en data/eijiro/EIJI-133.ja tm/eijiro/src_given_trg.lex tm/eijiro/trg_given_src.lex

    # Hybrid
    mkdir -p tm/hyb
    for dict in src_given_trg trg_given_src; do
        script/replace-prob.py tm/eijiro/${dict}.lex tm/kftt/${dict}.lex > tm/hyb/kftt-${dict}.lex
        script/replace-prob.py tm/eijiro/${dict}.lex tm/btec/tm-001/lex/${dict}.lex > tm/hyb/btec-${dict}.lex
    done
}

#data
lexicon

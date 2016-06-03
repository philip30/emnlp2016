#!/bin/bash

set -e
set -o xtrace

experiment=btec

source script/bash/config.sh

### GPU ###
gpu=$1
if [ -z $gpu ];then
    gpu=""
else
    gpu="--gpu $gpu"
fi
###########

### start epoch ###
start_epoch=$2
[ -z $start_epoch ] && start_epoch=0
########

max_epoch=14
BATCH_SIZE=64
DROPOUT=0.2

### Training options
training_options="--seed $SEED --batch $BATCH_SIZE $gpu --unk_cut 1 --dropout $DROPOUT"
decoder_options="--verbose --beam 5 --eos_disc 0.1"
test_ext=""

### Start!
mkdir -p $LOG
mkdir -p $MODEL_OUT

for split in 001; do
for (( ep=$start_epoch; ep < $max_epoch; ep++ )); do
for model in attn dictattn; do
for hidden in 800; do
for depth in 4; do
    src_train=$DATA/btec/train-${split}.clean.en
    trg_train=$DATA/btec/train-${split}.clean.ja
    name=$model-h${hidden}-d${depth}-$split
    if [ $model = "dictattn" ]; then
        for DICT_METHOD in bias linear; do
            for dict in auto man hyb; do
                if [ $dict = "auto" ]; then
                    name=${model}_${DICT_METHOD}-h${hidden}-d${depth}-$split
                    DICT=$ROOT/tm/btec/tm-$split/lex/trg_given_src.lex
                    TM=$ROOT/tm/btec/tm-$split/lex/src_given_trg.lex
                elif [ $dict = "man" ]; then
                    name=${model}_${DICT_METHOD}_eijiro-h${hidden}-d${depth}-$split
                    DICT=$ROOT/tm/eijiro/trg_given_src.lex
                    TM=$ROOT/tm/eijiro/src_given_trg.lex
                elif [ $dict = "hyb" ]; then
                    name=${model}_${DICT_METHOD}_hyb-h${hidden}-d${depth}-$split
                    DICT=$ROOT/tm/hyb/btec-001-trg_given_src.lex
                    TM=$ROOT/tm/hyb/btec-001-src_given_trg.lex
                else
                    echo "Unrecognized lexicon: $dict"
                    exit 1
                fi
                # Training
                source script/bash/training.sh
                # Testing
                source script/bash/testing.sh
            done
        done
    else
        DICT=$ROOT/tm/btec/tm-$split/lex/trg_given_src.lex
        TM=$ROOT/tm/btec/tm-$split/lex/src_given_trg.lex
        # Training
        source script/bash/training.sh
        # Testing
        source script/bash/testing.sh
    fi
    done
done
done
done
done


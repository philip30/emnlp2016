#!/bin/bash

set -e
set -o xtrace

experiment=btec

source script/bash/config.sh
source script/bash/hyper-param.sh

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

DEV=""
decoder_options="--verbose --eos_disc 0.1"
max_epoch=40

mkdir -p $LOG
mkdir -p $MODEL_OUT

for split in 001 002 004 008 016 032 064 128; do
TM=tm/btec/tm-$split/lex/src_given_trg.lex
DICT=$ROOT/tm/btec/tm-$split/lex/trg_given_src.lex
for (( ep=$start_epoch; ep < $max_epoch; ep++ )); do
for model in dictattn; do
for hidden in 256; do
for depth in 1; do
    src_train=$DATA/btec/train-${split}.clean.en
    trg_train=$DATA/btec/train-${split}.clean.ja
    name=$model-h${hidden}-d${depth}-$split
    if [ $model = "dictattn" ]; then
        for DICT_METHOD in bias; do
            name=${model}_${DICT_METHOD}-h${hidden}-d${depth}-$split
            # Training
            source script/bash/training.sh
            # Testing
            source script/bash/testing.sh
        done
    else
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


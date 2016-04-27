#!/bin/bash

set -e
set -o xtrace

experiment=kftt

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
decoder_options="--verbose --eos_disc 0.3"
max_epoch=30

mkdir -p $LOG
mkdir -p $MODEL_OUT

TM=$ROOT/tm/kyoto/src_given_trg.lex
DICT=$ROOT/tm/kyoto/trg_given_src.lex
for (( ep=$start_epoch; ep < $max_epoch; ep++ )); do
for model in attn dictattn; do
for hidden in 256; do
for depth in 1; do
    src_train=$DATA/kftt/kyoto-train.cln.en
    trg_train=$DATA/kftt/kyoto-train.cln.ja
    name=$model-h${hidden}-d${depth}
    if [ $model = "dictattn" ]; then
        for DICT_METHOD in bias linear; do
            name=${model}_${DICT_METHOD}-h${hidden}-d${depth}
            # Training
            source $ROOT/script/bash/training.sh
            # Testing
            source $ROOT/script/bash/testing.sh
        done
    else
        # Training
        source $ROOT/script/bash/training.sh
        # Testing
        source $ROOTscript/bash/testing.sh
    fi
    done
done
done
done


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

max_epoch=15
BATCH_SIZE=64
DROPOUT=0.2

### Training options
training_options="--seed $SEED --batch $BATCH_SIZE $gpu --unk_cut 3 --dropout $DROPOUT"
decoder_options="--verbose --eos_disc 0.1 --beam 5"

### Start!
mkdir -p $LOG
mkdir -p $MODEL_OUT

for (( ep=$start_epoch; ep < $max_epoch; ep++ )); do
for model in attn dictattn; do
for hidden in 800; do
for depth in 4; do
    src_train=$DATA/kftt/kyoto-train.clean.en
    trg_train=$DATA/kftt/kyoto-train.clean.ja
    name=$model-h${hidden}-d${depth}
    if [ $model = "dictattn" ]; then
        for DICT_METHOD in bias linear; do
            for dict in kftt eijiro eigiz hyb; do
                if [ $dict = "kftt" ]; then
                    name=${model}_${DICT_METHOD}-h${hidden}-d${depth}
                    DICT=$ROOT/tm/kftt/trg_given_src.lex
                    TM=$ROOT/tm/kftt/src_given_trg.lex
                elif [ $dict = "eijiro" ]; then
                    name=${model}_${DICT_METHOD}_eijiro-h${hidden}-d${depth}
                    DICT=$ROOT/tm/eijiro/trg_given_src.lex
                    TM=$ROOT/tm/eijiro/src_given_trg.lex
                elif [ $dict = "hyb" ]; then
                    name=${model}_${DICT_METHOD}_hyb-h${hidden}-d${depth}
                    DICT=$ROOT/tm/hyb/kftt-trg_given_src.lex
                    TM=$ROOT/tm/hyb/kftt-src_given_trg.lex
                fi
                # Training
                source $ROOT/script/bash/training.sh
                # Testing
                source $ROOT/script/bash/testing.sh
            done
        done
    else
        # Training
        source $ROOT/script/bash/training.sh
        # Testing
        source $ROOT/script/bash/testing.sh
    fi
    done
done
done
done


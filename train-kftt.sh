#!/bin/bash

set -e
set -o xtrace

experiment=kftt

source script/bash/config.sh
source script/bash/dictionary-kyoto.sh
source script/bash/hyper-param.sh

### GPU ###
gpu=$1
if [ -z $gpu ];then
    gpu=""
else
    gpu="--gpu $gpu"
fi
###########

DEV="--src_dev $DATA/kftt/kyoto-dev.en --trg_dev $DATA/kftt/kyoto-dev.ja"

mkdir -p $LOG
mkdir -p $MODEL_OUT

unk_cut="--unk_cut 2"

for model in dictattn; do
for hidden in 256; do
for depth in 1; do
for epoch in 20; do
for BATCH_SIZE in 64; do
    src_train=$DATA/kftt/kyoto-train.cln.en
    trg_train=$DATA/kftt/kyoto-train.cln.ja
    name=$model-h${hidden}-d${depth}
    if [ $model = "dictattn" ] && [ $DICT_METHOD = "bias" ]; then
        name=${model}_bias-h${hidden}-d${depth}
    fi
    source script/bash/training.sh
done
done
done
done
done

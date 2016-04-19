#!/bin/bash

set -e
set -o xtrace

experiment=btec

source script/bash/config.sh
source script/bash/dictionary.sh
source script/bash/hyper-param.sh

### GPU ###
gpu=$1
if [ -z $gpu ];then
    gpu=""
else
    gpu="--gpu $gpu"
fi
###########

DEV="--src_dev $DATA/btec/dev.en --trg_dev $DATA/btec/dev.ja"

mkdir -p $LOG
mkdir -p $MODEL_OUT

for split in 001; do
for model in dictattn; do
for hidden in 256; do
for depth in 1; do
for epoch in 20; do
    src_train=$DATA/btec/train-${split}.clean.en
    trg_train=$DATA/btec/train-${split}.clean.ja
    name=$model-h${hidden}-d${depth}-$split
    if [ $model = "dictattn" ] && [ $DICT_METHOD = "bias" ]; then
        name=${model}_bias-h${hidden}-d${depth}-$split
    fi
    source script/bash/training.sh
done
done
done
done
done


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

mkdir -p $LOG
mkdir -p $MODEL_OUT

for split in 001; do
for model in attn; do
for hidden in 1024 512; do
for depth in 2; do
    src_train=$DATA/btec/train-${split}.clean.en
    trg_train=$DATA/btec/train-${split}.clean.ja
    name=$model-h${hidden}-d${depth}-$split
    source script/bash/training.sh
done
done
done
done


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

mkdir -p $LOG
mkdir -p $MODEL_OUT

unk_cut="--unk_cut 3"

for model in attn; do
for hidden in 256; do
for depth in 1; do
    src_train=$DATA/kftt/kyoto-train.cln.en
    trg_train=$DATA/kftt/kyoto-train.cln.ja
    name=$model-h${hidden}-d${depth}
    source script/bash/training.sh
done
done
done


#!/bin/bash
set -e
set -o xtrace

experiment=kftt

source script/bash/config.sh
source script/bash/dictionary.sh
source script/bash/hyper-param.sh

gpu=$1
if [ -z $gpu ];then
    gpu=""
else
    gpu="--gpu $gpu"
fi

# options
### Start ####
mkdir -p $TEST

for model in attn encdec dictattn; do
for hidden in 256; do
for depth in 1; do
    data=$DATA/$experiment
    name=$model-h${hidden}-d${depth}
    model_out=$MODEL_OUT/${name}/model
    mkdir -p $TEST/$name
    source script/bash/testing.sh
done
done
done


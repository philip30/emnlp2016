#!/bin/bash
set -e
set -o xtrace

experiment=btec

source script/bash/config.sh
source script/bash/dictionary.sh
source script/bash/hyper-param.sh

gpu=$1
if [ -z $gpu ];then
    gpu=""
else
    gpu="--gpu $gpu"
fi

decoder_options="--verbose"

# options
### Start ####
mkdir -p $TEST

for split in 001 002 004 008 016 032 064 128; do
for model in dictattn; do
for hidden in 256; do
for depth in 1; do
for epoch in 40; do
    data=$DATA/$experiment
    name=$model-h${hidden}-d${depth}-$split
    if [ $model = "dictattn" ] && [ $DICT_METHOD = "bias" ]; then
        name=${model}_bias-h${hidden}-d${depth}-$split
    fi
    model_out=$MODEL_OUT/${name}/model  
    if [ -e $MODEL_OUT/$name ]; then
        mkdir -p $TEST/$name
        source script/bash/testing.sh
    fi
done
done
done
done
done

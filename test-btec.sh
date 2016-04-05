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

decoder_options="--eos_disc 0.2 --verbose"

# options
### Start ####
mkdir -p $TEST

for split in 002 004 008 016 032 064 128; do
for model in attn dictattn; do
for hidden in 1024 512 256; do
for depth in 2 1; do
    data=$DATA/$experiment
    name=$model-h${hidden}-d${depth}-$split
    model_out=$MODEL_OUT/${name}/model
    if [ -e $MODEL_OUT/$name ]; then
        mkdir -p $TEST/$name
        source script/bash/testing.sh
    fi
done
done
done
done


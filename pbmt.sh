#!/bin/bash

set -e
set -o xtrace

source script/bash/config.sh

DATA=data
THREADS=24

pbmt() {
    method=$1
    train=$2
    dev=$3
    test=$4
    src=$5
    trg=$6

    TM=$ROOT/tm/pbmt/$method
    TUNE=$ROOT/model/pbmt/$method
    TEST=$ROOT/test/pbmt/$method

    #### Train
#    # Build Translation model
#    SECONDS=0
#    mkdir -p `dirname $TM`
#    $MOSES/scripts/training/train-model.perl -root-dir $TM -corpus $train -f $src -e $trg -alignment grow-diag-final-and -lm 0:5:$PWD/lm/$method/lm.blm:8 -external-bin-dir $GIZA -cores $THREADS
#    train_time=$SECONDS
#
#    #### Tune
#    SECONDS=0
#    mkdir -p `dirname $TUNE`
#    $MOSES/scripts/training/mert-moses.pl ${dev}.$src ${dev}.$trg $MOSES/bin/moses $TM/model/moses.ini --mertdir $MOSES/bin --working-dir $TUNE --decoder-flags "-threads $THREADS"
#    duration=$SECONDS
#    tune_time=$SECONDS
    
    #### Writing time
#    perl -le 'printf "LM: %f\n", $ARGV[0]/60' $lm_time    >  $TUNE/train-time.detail
#    perl -le 'printf "TM: %f\n", $ARGV[0]/60' $train_time >> $TUNE/train-time.detail
#    perl -le 'printf "PL: %f\n", $ARGV[0]/60' $tune_time  >> $TUNE/train-time.detail
#    perl -le 'printf "%f\n", ($ARGV[0]+$ARGV[1]+$ARGV[2])/60' $lm_time $train_time $tune_time > $TUNE/train.time
#
    #### TEST   
    mkdir -p $TEST
    $MOSES/bin/moses -f $TUNE/moses.ini -threads $THREADS < ${test}.${src} > $TEST/test.out
    $TRAVATAR/src/bin/mt-evaluator -ref ${test}.${trg} $TEST/test.out > $TEST/test.result
}


btec() {
    # BTEC Hiero
    for split in 001; do
        pbmt btec-$split $DATA/btec/train-$split.clean $DATA/btec/dev $DATA/btec/test en ja
    done
}

kftt(){
    pbmt kftt $DATA/kftt/kyoto-train.clean $DATA/kftt/kyoto-dev $DATA/kftt/test en ja
}

#btec
kftt

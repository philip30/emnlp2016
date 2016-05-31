#!/bin/bash

set -e
set -o xtrace

source script/bash/config.sh

DATA=data
THREADS=4

hiero() {
    method=$1
    train_en=$2
    train_ja=$3
    dev_en=$4
    dev_ja=$5
    test_en=$6
    test_ja=$7

    TM=tm/$method
    TUNE=model/hiero/$method
    TEST=test/hiero/$method

    #### Train
    # Build Language model
    SECONDS=0
    mkdir -p lm/$method
    $TRAVATAR/src/kenlm/lm/lmplz -o 5 < $train_ja > lm/$method/lm.arpa
    $TRAVATAR/src/kenlm/lm/build_binary -i lm/$method/lm.arpa lm/$method/lm.blm
    lm_time=$SECONDS

    # Build Translation model
    SECONDS=0
    mkdir -p `dirname $TM`
    $TRAVATAR/script/train/train-travatar.pl --src_file $train_en --trg_file $train_ja --travatar_dir $TRAVATAR --bin_dir $GIZA --threads $THREADS --lm_file lm/$method/lm.blm --work_dir $TM --method hiero        
    train_time=$SECONDS

    #### Tune
    SECONDS=0
    mkdir -p `dirname $TUNE`
    $TRAVATAR/script/mert/mert-travatar.pl --threads $THREADS --travatar-config $TM/model/travatar.ini --nbest 100 --src $dev_en --ref $dev_ja --travatar-dir $TRAVATAR --working-dir $TUNE
    duration=$SECONDS
    tune_time=$SECONDS
    
    #### Writing time
    perl -le 'printf "LM: %f\n", $ARGV[0]/60' $lm_time    >  $TUNE/train-time.detail
    perl -le 'printf "TM: %f\n", $ARGV[0]/60' $train_time >> $TUNE/train-time.detail
    perl -le 'printf "PL: %f\n", $ARGV[0]/60' $tune_time  >> $TUNE/train-time.detail
    perl -le 'printf "%f\n", ($ARGV[0]+$ARGV[1]+$ARGV[2])/60' $lm_time $train_time $tune_time > $TUNE/train.time

    #### TEST   
    mkdir -p $TEST
    $TRAVATAR/src/bin/travatar -config_file $TUNE/travatar.ini -trace_out $TEST/test.trace -buffer false < $test_en -threads $THREADS > $TEST/test.out
    $TRAVATAR/src/bin/mt-evaluator -ref $test_ja $TEST/test.out > $TEST/test.result

}


btec() {
    # BTEC Hiero
    for split in 001; do
        hiero btec-$split $DATA/btec/train-$split.clean.{en,ja} $DATA/btec/dev.{en,ja} $DATA/btec/test.{en,ja}
    done
}

kftt(){
    hiero kftt $DATA/kftt/kyoto-train.clean.{en,ja} $DATA/kftt/kyoto-dev.{en,ja} $DATA/kftt/test.{en,ja}
}

#btec
kftt

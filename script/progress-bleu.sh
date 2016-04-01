#!/bin/bash

set -e

# Parameters
dir=$1
MAX=30

if [[ $dir == "" ]];then
    echo "Usage progress-bleu.sh [TEST_DIR]"
    exit 1
fi

for (( tc=0; tc < $MAX; tc++ )); do
    if [ -e $1/test-$tc.result ]; then
        let "k=$tc+1"
        printf "Epoch %02d: %20s %s\n" $k "`cat $1/test-$tc.result`" "`cat $1/test-$tc.time`"
    fi
done

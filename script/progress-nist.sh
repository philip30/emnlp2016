#!/bin/bash

set -e

# Parameters
dir=$1

if [[ $dir == "" ]];then
    echo "Usage progress-nist.sh [TEST_DIR]"
    exit 1
fi

for (( tc=0; tc < $max_epoch; tc++ )); do
    if [ -e $2/test-$tc.result ]; then
        let "k=$tc+1"
        printf "Epoch %02d: %20s %s\n" $k "`cat $2/test-$tc.nist.result`" "`cat $1-$tc/train.time`"
    fi
done

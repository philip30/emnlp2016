#!/bin/bash

set -e
set -o xtrace

mkdir -p png


for eval in BLEU; do

if [ $eval == "BLEU" ]; then
    ex=""
else
    ex=".nist"
fi


script/plot.py --input \
    test/btec/attn-h800-d4-001/test$ex.report \
    test/btec/dictattn_bias-h800-d4-001/test$ex.report \
    test/btec/dictattn_bias_hyb-h800-d4-001/test$ex.report \
    --output png/btec-time-$eval.eps \
    --label attn auto-bias hyb-bias \
    --mode time --cut_time 14 --eval $eval

script/plot.py --input \
    test/kftt/attn-h800-d4/test$ex.report \
    test/kftt/dictattn_bias-h800-d4/test$ex.report \
    test/kftt/dictattn_bias_hyb-h800-d4/test$ex.report \
    --output png/kftt-time-$eval.eps \
    --label attn auto-bias hyb-bias \
    --mode time --cut_time 14 --eval $eval
done


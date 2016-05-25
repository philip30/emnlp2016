#!/bin/bash

set -e
set -o xtrace

btec_method() {
    # Method comparison
    for split in 001 002 004 008 016 032 064 128; do
        for hidden in 256 512 1024; do
            for depth in 1 2 4; do
                extension="h$hidden-d$depth-$split"
                if [ -d test/btec/attn-$extension ] && [ -d test/btec/dictattn_bias-$extension ] && [ -d test/btec/dictattn_linear-$extension ]; then
                    python script/plot.py --input test/btec/{attn,dictattn_bias,dictattn_linear}-$extension/test.report --mode time --output png/btec/${extension}.time.png
                    python script/plot.py --input test/btec/{attn,dictattn_bias,dictattn_linear}-$extension/test.report --mode epoch --output png/btec/${extension}.epoch.png
                fi
            done
        done
    done
}

btec_hidden() {
    for split in 001 002 004 008 016 032 064 128; do
    for depth in 1 2 4; do
          extension="d$depth-$split"
          if [ -d test/btec/attn-h256-$extension ] && [ -d test/btec/attn-h512-$extension ] && [ -d test/btec/attn-h1024-$extension ]; then
              python script/plot.py --input test/btec/attn-h{256,512,1024}-$extension/test.report --mode time --output png/btec/hidden-${extension}.time.png
              python script/plot.py --input test/btec/attn-h{256,512,1024}-$extension/test.report --mode epoch --output png/btec/hidden-${extension}.epoch.png
          fi
   done
   done
}

btec_depth() {
    for split in 001 002 004 008 016 032 064 128; do
    for hidden in 256 512 1024; do
          if [ -d test/btec/attn-h$hidden-d1-$split ] && [ -d test/btec/attn-h$hidden-d2-$split ] && [ -d test/btec/attn-h$hidden-d4-$split ]; then
              python script/plot.py --input test/btec/attn-h$hidden-d{1,2,4}-$split/test.report --mode time --output png/btec/depth-h$hidden-${split}.time.png
              python script/plot.py --input test/btec/attn-h$hidden-d{1,2,4}-$split/test.report --mode epoch --output png/btec/depth-h$hidden-${split}.epoch.png
          fi
   done
   done
}

btec() {
    mkdir -p png/btec
    btec_method
#    btec_hidden
#    btec_depth
}

kftt_method() {
    for hidden in 256 512 1024; do
        for depth in 1 2 4; do
            extension="h$hidden-d$depth"
            if [ -d test/kftt/attn-$extension ] && [ -d test/kftt/dictattn_bias-$extension ] && [ -d test/kftt/dictattn_linear-$extension ]; then
                python script/plot.py --input test/kftt/{attn,dictattn_bias,dictattn_linear}-$extension/test.report --mode time --output png/kftt/${extension}-time.png
                python script/plot.py --input test/kftt/{attn,dictattn_bias,dictattn_linear}-$extension/test.report --mode epoch --output png/kftt/${extension}-epoch.png
            fi
        done
    done
}

kftt() {
    mkdir -p png/kftt
    kftt_method
}


# Execute
btec
kftt

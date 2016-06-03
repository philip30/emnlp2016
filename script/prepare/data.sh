data() {
    for x in 001; do
        script/clean-batch.py data/btec/train-$x.en data/btec/train-$x.ja data/btec/train-$x.clean.en data/btec/train-$x.clean.ja $THRESHOLD 
    done
    script/clean-batch.py data/kftt/kyoto-train.en data/kftt/kyoto-train.ja data/kftt/kyoto-train.clean.en data/kftt/kyoto-train.clean.ja $THRESHOLD
}


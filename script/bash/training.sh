model_out=$MODEL_OUT/${name}
train_log=$LOG/${name}.log
options="--hidden $hidden --epoch $EPOCH --embed $hidden --seed $SEED --batch $BATCH_SIZE $gpu $unk_cut --save_models init_model"    

# Dict
if [ $model = "dictattn" ]; then
    options="$options --dict $DICT --dict_caching"
fi

mkdir -p $model_out
model_out=$MODEL_OUT/${name}/model

# Training
if [ -d $model_out ]; then
    rm -rf $model_out
fi
python3 $CHAINN/train-nmt.py --depth $depth --src ${src_train} --trg ${trg_train} --model $model --model_out $model_out $options 2> $train_log


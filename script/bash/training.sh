model_out=$MODEL_OUT/${name}
train_log=$LOG/${name}.log
options="--hidden $hidden --epoch $max_epoch --embed $hidden --seed $SEED --batch $BATCH_SIZE $gpu $unk_cut --dropout $DROPOUT --one_epoch"    

# Dict
if [ $model = "dictattn" ]; then
    options="$options --dict $DICT --dict_caching --dict_method $DICT_METHOD $DEV"
fi

mkdir -p $model_out
model_out=$MODEL_OUT/${name}/model

# init model
if [ $ep -ne 0 ]; then
    prev_epoch=$(($ep-1))
    init_model="--init_model ${model_out}-${prev_epoch}"
else
    [ -e $train_log ] && rm -f $train_log
    init_model=
fi

# Training
[ -d $model_out ] && rm -rf $model_out
SECONDS=0
python3 $CHAINN/train-nmt.py --depth $depth --src ${src_train} --trg ${trg_train} --model $model --model_out ${model_out}-$ep $options $init_model 2>> $train_log
duration=$SECONDS

perl -le 'printf "%f\n", $ARGV[0]/60' $duration > $model_out-$ep/train.time


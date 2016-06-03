model_out=$MODEL_OUT/${name}
train_log=$LOG/${name}.log
options="--hidden $hidden --epoch $max_epoch --embed $hidden --one_epoch $training_options"    

# Dict
if [ "$model" = "dictattn" ]; then
    options="$options --dict $DICT --dict_caching --dict_method $DICT_METHOD"
fi

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
model_iter=$model_out-$ep
if [ "$CONTINUE" != "true" ] || [ ! -d "$model_iter" ]; then
    [ -d "$model_iter" ] && rm -rf $model_iter
    mkdir -p `dirname $model_iter`
    SECONDS=0
    python3 $CHAINN/train-nmt.py --depth $depth --src ${src_train} --trg ${trg_train} --model $model --model_out $model_iter $options $init_model 2>> $train_log
    duration=$SECONDS
    
    perl -le 'printf "%f\n", $ARGV[0]/60' $duration > $model_iter/train.time
fi

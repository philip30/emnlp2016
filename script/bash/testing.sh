# Testing
data=$DATA/$experiment

# Directory
if [ $ep -eq 0 ]; then
    [ -d ${TEST}/$name ] && rm -rf ${TEST}/$name
    mkdir -p ${TEST}/$name
fi

# Decoding
echo "Testing $name, epoch: $ep"
test_name=$TEST/$name/test-$ep
python3 $CHAINN/nmt.py --init_model ${model_out}-$ep $gpu $decoder_options < ${data}/test.en --align_out ${test_name}.align > ${test_name}.out 2> ${test_name}.log

if [ ! -z $TM ]; then
    python3 script/post-process/replace_unk.py -s $data/test.en -a ${test_name}.align -p $TM > ${test_name}.out
fi

# BLEU
$BLEU_EVALUATOR -lc ${data}/test.ja < ${test_name}.out > ${test_name}.result

#python3 script/calculate-time.py $LOG/${name}.log $TEST/$name
source script/progress-bleu.sh $model_out $TEST/$name > $TEST/$name/test.report


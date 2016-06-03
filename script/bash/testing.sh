# Testing
data=$DATA/$experiment

# Decoding
test_name=$TEST/$name/test-$ep
if [ "$CONTINUE" != "true" ] || [ ! -e ${test_name}.result ]; then
    # Directory
    if [ $ep -eq 0 ]; then
        [ -d ${TEST}/$name ] && [ $REPLACE_ONLY != "true" ] && rm -rf ${TEST}/$name
        mkdir -p ${TEST}/$name
    fi

    echo "Testing $name"
    if [ "$REPLACE_ONLY" != "true" ]; then
        python3 $CHAINN/nmt.py --init_model $MODEL_OUT/${name}/model-$ep $gpu $decoder_options < ${data}/test${test_ext}.en --align_out ${test_name}.align > ${test_name}.out 2> ${test_name}.log
    fi
    if [ ! -z $DICT ]; then
        python3 script/post-process/replace_unk.py -s $data/test${test_ext}.en -a ${test_name}.align -p $DICT > ${test_name}.out
    fi
    
    # BLEU
    $BLEU_EVALUATOR -lc $data/test${test_ext}.ja < ${test_name}.out > ${test_name}.result
    
    # NIST
    $MT_EVAL -e NIST -r $data/test${test_ext}.ja -h ${test_name}.out > ${test_name}.nist.result

    source script/progress-bleu.sh $MODEL_OUT/$name/model $TEST/$name > $TEST/$name/test.report
    source script/progress-nist.sh $MODEL_OUT/$name/model $TEST/$name > $TEST/$name/test.nist.report
fi

# Testing
if [ -d ${TEST}/$name ]; then
    rm -rf ${TEST}/$name
fi

mkdir -p ${TEST}/$name

python3 script/calculate-time.py $LOG/${name}.log $TEST/$name
for (( tc=0; tc < $epoch; tc++ )) do
    if [ -e ${model_out}-$tc ]; then
        echo "Testing $name, epoch: $tc"
        test_name=$TEST/$name/test-$tc
        python3 $CHAINN/nmt.py --init_model ${model_out}-$tc $gpu $decoder_options < ${data}/test.en --align_out ${test_name}-single.align > ${test_name}-single.out 2> ${test_name}-single.log
        $BLEU_EVALUATOR -lc ${data}/test.ja < ${test_name}-single.out > ${test_name}.result
    fi
done

source script/progress-bleu.sh $TEST/$name > $TEST/$name/test.report

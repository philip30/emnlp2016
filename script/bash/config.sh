ROOT=/project/nakamura-lab01/Work/philip-a/experiment/emnlp-2016
DEV=$HOME/dev
PYTHONPATH=$DEV
DATA=$ROOT/data
MODEL_OUT=$ROOT/model/$experiment
TEST=$ROOT/test/$experiment
CHAINN=$DEV/chainn
LOG=$ROOT/log/$experiment
SEED=1300487

# Baseline
TRAVATAR=$DEV/travatar
MOSES=$HOME/src/mosesdecoder
GIZA=$HOME/github/giza-pp

# Evaluator
BLEU_EVALUATOR=$MOSES/scripts/training/train-model.perl

[ ! -d $ROOT ] && exit 1
[ ! -d $DEV ] && exit 1
[ ! -e $BLEU_EVALUATOR ] && exit 1

echo PID: $$

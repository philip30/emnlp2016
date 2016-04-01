ROOT=$HOME/experiment/emnlp-2016
DEV=$HOME/tools_production
PYTHONPATH=$DEV
DATA=$ROOT/data
MODEL_OUT=$ROOT/model/$experiment
TEST=$ROOT/test/$experiment
CHAINN=$DEV/chainn
LOG=$ROOT/log/$experiment
SEED=1300487
BLEU_EVALUATOR=~/tools/mosesdecoder/scripts/generic/multi-bleu.perl

decoder_options="--eos_disc 0 --verbose"

### Instruction: Fill in all the !!
# The root of the experiment [recommended: $PWD ] !!
ROOT=

# Path to chainn (the code for this submission) up one level directory [recommended: $PWD] !!
PYTHONPATH=

# Path to chainn directory (absolute directory) [recommended: $PWD/chainn] !!
CHAINN=

# Baseline
### TRAVATAR !!
TRAVATAR=
### MOSES !!
MOSES=
### GIZA++ !!
GIZA=
### MT_EVAL !!
MT_EVAL=$HOME/mteval/src/bin/mteval-corpus

##### NO NEED TO CHANGE #######
BLEU_EVALUATOR=$MOSES/scripts/generic/multi-bleu.perl

# DATA
DATA=$ROOT/data
MODEL_OUT=$ROOT/model/$experiment
TEST=$ROOT/test/$experiment
LOG=$ROOT/log/$experiment
SEED=1300487

[ ! -d $ROOT ] && exit 1
[ ! -e $CHAINN/nmt.py ] && exit 1
[ ! -e $BLEU_EVALUATOR ] && exit 1
[ ! -e $MT_EVAL/mteval/src/bin/mteval-corpus ] && exit 1
[ ! -e $TRAVATAR/src/bin/travatar ] && exit 1


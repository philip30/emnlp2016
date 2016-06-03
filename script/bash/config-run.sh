
# The root of the experiment ($PWD?)
ROOT=

# Path to chainn (up one level) directory (+ your PYTHONPATH) [recommended: $PWD] !!
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

# Path to MOSES multi-bleu.perl !!
BLEU_EVALUATOR=$HOME/mosesdecoder/scripts/generic/multi-bleu.perl
# Path to mt-eval !!
MT_EVAL=$HOME/mteval/src/bin/mteval-corpus

##### NO NEED TO CHANGE #######
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


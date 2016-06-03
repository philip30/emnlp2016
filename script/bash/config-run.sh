
# The root of the experiment ($PWD?)
ROOT=

# Path to chainn (up one level) directory (+ your PYTHONPATH)
PYTHONPATH=

# Path to chainn directory (absolute directory)
CHAINN=

# Path to MOSES multi-bleu.perl 
BLEU_EVALUATOR=$HOME/mosesdecoder/scripts/generic/multi-bleu.perl
# Path to mt-eval
MT_EVAL=~/tools/mteval/src/bin/mteval-corpus

##### NO NEED TO CHANGE #######
# DATA
DATA=$ROOT/data
MODEL_OUT=$ROOT/model/$experiment
TEST=$ROOT/test/$experiment
LOG=$ROOT/log/$experiment
SEED=1300487


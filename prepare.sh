#!/bin/bash

set -e
set -o xtrace

THRESHOLD=50

source script/prepare/data.sh
source script/prepare/lexicon.sh

data
lexicon

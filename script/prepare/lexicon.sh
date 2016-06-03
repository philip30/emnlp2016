lexicon() {
    mkdir -p tm/eijiro
    # Eijiro
    script/extract-eijiro.py data/eijiro/EIJI-133.en data/eijiro/EIJI-133.ja tm/eijiro/src_given_trg.lex tm/eijiro/trg_given_src.lex

    }


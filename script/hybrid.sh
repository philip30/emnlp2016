# Hybrid
mkdir -p tm/hyb
for dict in trg_given_src; do
    script/replace-prob.py tm/eijiro/${dict}.lex tm/kftt/${dict}.lex > tm/hyb/kftt-${dict}.lex
    script/replace-prob.py tm/eijiro/${dict}.lex tm/btec/${dict}.lex > tm/hyb/btec-${dict}.lex
done


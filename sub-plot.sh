#!/bin/bash


script/plot.py --input test/btec/{attn-h256-d1-001,dictattn_bias_eijiro-h256-d1-001,dictattn_linear_eijiro-h256-d1-001,dictattn_bias-h256-d1-001,dictattn_linear-h256-d1-001,dictattn_bias_int-h256-d1-001,dictattn_linear_int-h256-d1-001}/test.report --output png/btec-epoch.png --label baseline ei-bias ei-lin btec-bias btec-lin hyb-bias hyb-lin --mode epoch --cut_time 40

script/plot.py --input test/btec/{attn-h256-d1-001,dictattn_bias_eijiro-h256-d1-001,dictattn_linear_eijiro-h256-d1-001,dictattn_bias-h256-d1-001,dictattn_linear-h256-d1-001,dictattn_bias_int-h256-d1-001,dictattn_linear_int-h256-d1-001}/test.report --output png/btec-time.png --label baseline ei-bias ei-lin btec-bias btec-lin hyb-bias hyb-lin --mode time --cut_time 800

script/plot.py --input test/kftt/{attn-h256-d1,dictattn_bias_eijiro-h256-d1,dictattn_linear_eijiro-h256-d1,dictattn_bias-h256-d1,dictattn_linear-h256-d1,dictattn_bias_int-h256-d1,dictattn_linear_int-h256-d1}/test.report --output png/kftt-epoch.png --label baseline ei-bias ei-lin kftt-bias kftt-lin hyb-bias hyb-lin --mode epoch --cut_time 30

script/plot.py --input test/kftt/{attn-h256-d1,dictattn_bias_eijiro-h256-d1,dictattn_linear_eijiro-h256-d1,dictattn_bias-h256-d1,dictattn_linear-h256-d1,dictattn_bias_int-h256-d1,dictattn_linear_int-h256-d1}/test.report --output png/kftt-time.png --label baseline ei-bias ei-lin kftt-bias kftt-lin hyb-bias hyb-lin --mode time --cut_time 3500

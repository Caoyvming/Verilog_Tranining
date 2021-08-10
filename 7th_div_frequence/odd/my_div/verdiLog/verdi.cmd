debImport "./src/my_div.v" "./src/tb_my_div.v"
debLoadSimResult \
           /home/cym/Desktop/work_trainning/11.div_frequence/odd/my_div/tb_my_div.fsdb
wvCreateWindow
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_my_div"
wvGetSignalSetScope -win $_nWave2 "/tb_my_div/DUT"
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_my_div/DUT/clk_in} \
{/tb_my_div/DUT/clk_neg} \
{/tb_my_div/DUT/clk_out} \
{/tb_my_div/DUT/clk_pos} \
{/tb_my_div/DUT/cnt_neg\[4:0\]} \
{/tb_my_div/DUT/cnt_pos\[4:0\]} \
{/tb_my_div/DUT/rst_n} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_my_div/DUT/clk_in} \
{/tb_my_div/DUT/clk_neg} \
{/tb_my_div/DUT/clk_out} \
{/tb_my_div/DUT/clk_pos} \
{/tb_my_div/DUT/cnt_neg\[4:0\]} \
{/tb_my_div/DUT/cnt_pos\[4:0\]} \
{/tb_my_div/DUT/rst_n} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetPosition -win $_nWave2 {("G1" 7)}
wvGetSignalClose -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 2458.097534 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 2609.608605 -snap {("G1" 6)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
debExit

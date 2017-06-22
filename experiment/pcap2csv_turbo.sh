###############################
#DON'T RUN THIS SCRIPT AS ROOT#
###############################

WORKDIR="/home/vk/fair-drop_results/workdir"
EXPDIR="/home/vk/fair-drop_results/workdir"
SCRIPTS="/home/vk/scripts"

for i in bell exponential
do
BW=0.1
until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
                        #vstate#
    echo -e "\n\nConverting fair-drop_$i""64_turbo_$BW.pcap to fair-drop_$i""64_turbo_$BW.csv\n\n"
    $SCRIPTS/pcap2csv.sh $EXPDIR/fair-drop_$i""64_turbo_$BW.pcap $EXPDIR/fair-drop_$i""64_turbo_$BW.csv
    echo -e "\n\nConverting fair-drop_$i""64_turbo_$BW.csv to fair-drop_$i""64_turbo_$BW.dat\n\n"
    cat $EXPDIR/fair-drop_$i""64_turbo_$BW.csv | awk '{print $2}' | sort -n | uniq --count > $EXPDIR/fair-drop_$i""64_turbo_$BW.dat
                        #FIFO#
    echo -e "\n\nConverting fair-drop_$i""64_turbo_fifo_$BW.pcap to fair-drop_$i""64_turbo_fifo_$BW.csv\n\n"
    $SCRIPTS/pcap2csv.sh $EXPDIR/fair-drop_$i""64_turbo_fifo_$BW.pcap $EXPDIR/fair-drop_$i""64_turbo_fifo_$BW.csv
    echo -e "\n\nConverting fair-drop_$i""64_turbo_fifo_$BW.csv to fair-drop_$i""64_turbo_fifo_$BW.dat\n\n"
    cat $EXPDIR/fair-drop_$i""64_turbo_fifo_$BW.csv | awk '{print $2}' | sort -n | uniq --count > $EXPDIR/fair-drop_$i""64_turbo_fifo_$BW.dat
    BW=$(python -c "print($BW+0.1)")
done
                        #TG#
    echo -e "\n\nConverting fair-drop_$i""64_sent_turbo.pcap to fair-drop_$i""64_sent_turbo.csv\n\n"
    $SCRIPTS/pcap2csv.sh $EXPDIR/fair-drop_$i""64_sent_turbo.pcap $EXPDIR/fair-drop_$i""64_sent_turbo.csv
    echo -e "\n\nConverting fair-drop_$i""64_sent_turbo.csv to fair-drop_$i""64_sent_turbo.dat\n\n"
    cat $EXPDIR/fair-drop_$i""64_sent_turbo.csv | awk '{print $2}'| sort -n | uniq --count > $EXPDIR/fair-drop_$i""64_sent_turbo.dat

    echo -e "\n\nConverting fair-drop_$i""64_sent_turbo_fifo.pcap to fair-drop_$i""64_sent_turbo_fifo.csv\n\n"
    $SCRIPTS/pcap2csv.sh $EXPDIR/fair-drop_$i""64_sent_turbo_fifo.pcap $EXPDIR/fair-drop_$i""64_sent_turbo_fifo.csv
    echo -e "\n\nConverting fair-drop_$i""64_sent_turbo_fifo.csv to fair-drop_$i""64_sent_turbo_fifo.dat\n\n"
    cat $EXPDIR/fair-drop_$i""64_sent_turbo_fifo.csv | awk '{print $2}'| sort -n | uniq --count > $EXPDIR/fair-drop_$i""64_sent_turbo_fifo.dat

done

echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo "     TURBO BOOST MODE           "
echo "  CONVERTED ALL PCAP TO CSV     "
echo "  CONVERTED ALL CSV TO DAT      "
echo -e "\n"
echo "################################"

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
    echo -e "\n\nConverting fair-drop_$i""64_$BW.pcap to fair-drop_$i""64_$BW.csv\n\n"
    $SCRIPTS/pcap2csv.sh $EXPDIR/fair-drop_$i""64_$BW.pcap $EXPDIR/fair-drop_$i""64_$BW.csv
    echo -e "\n\nConverting fair-drop_$i""64_$BW.csv to fair-drop_$i""64_$BW.dat\n\n"
    cat $EXPDIR/fair-drop_$i""64_$BW.csv | awk '{print $2}' | sort -n | uniq --count > $EXPDIR/fair-drop_$i""64_$BW.dat
                        #FIFO#
    echo -e "\n\nConverting fair-drop_$i""64_fifo_$BW.pcap to fair-drop_$i""64_fifo_$BW.csv\n\n"
    $SCRIPTS/pcap2csv.sh $EXPDIR/fair-drop_$i""64_fifo_$BW.pcap $EXPDIR/fair-drop_$i""64_fifo_$BW.csv
    echo -e "\n\nConverting fair-drop_$i""64_fifo_$BW.csv to fair-drop_$i""64_fifo_$BW.dat\n\n"
    cat $EXPDIR/fair-drop_$i""64_fifo_$BW.csv | awk '{print $2}' | sort -n | uniq --count > $EXPDIR/fair-drop_$i""64_fifo_$BW.dat
    BW=$(python -c "print($BW+0.1)")
done
                        #TG#
    echo -e "\n\nConverting fair-drop_$i""64_sent.pcap to fair-drop_$i""64_sent.csv\n\n"
    $SCRIPTS/pcap2csv.sh $EXPDIR/fair-drop_$i""64_sent.pcap $EXPDIR/fair-drop_$i""64_sent.csv
    echo -e "\n\nConverting fair-drop_$i""64_sent.csv to fair-drop_$i""64_sent.dat\n\n"
    cat $EXPDIR/fair-drop_$i""64_sent.csv | awk '{print $2}'| sort -n | uniq --count > $EXPDIR/fair-drop_$i""64_sent.dat

    echo -e "\n\nConverting fair-drop_$i""64_sent_fifo.pcap to fair-drop_$i""64_sent_fifo.csv\n\n"
    $SCRIPTS/pcap2csv.sh $EXPDIR/fair-drop_$i""64_sent_fifo.pcap $EXPDIR/fair-drop_$i""64_sent_fifo.csv
    echo -e "\n\nConverting fair-drop_$i""64_sent_fifo.csv to fair-drop_$i""64_sent_fifo.dat\n\n"
    cat $EXPDIR/fair-drop_$i""64_sent_fifo.csv | awk '{print $2}'| sort -n | uniq --count > $EXPDIR/fair-drop_$i""64_sent_fifo.dat

done

echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo "     NO TURBO BOOST MODE        "
echo "  CONVERTED ALL PCAP TO CSV     "
echo "  CONVERTED ALL CSV TO DAT      "
echo -e "\n"
echo "################################"

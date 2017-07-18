WORKDIR="/home/vk/fair-drop_results/workdir"
sleep 10
echo "started experiment" > strt.dat

#sudo -E $WORKDIR/experiment64-bell-exp.sh
sudo -E $WORKDIR/experiment64-bell-exp-fifo.sh
sudo -E $WORKDIR/experiment64-bell-exp.sh

$WORKDIR/pcap2csv_noturbo.sh
$WORKDIR/pcap2csv_turbo.sh

$WORKDIR/plot_turbo.sh
$WORKDIR/plot_no_turbo.sh

echo "bye" >> strt.dat

echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo -e "\n"
echo "################################"

echo "FINISHED EXPEIMENT" > $WORKDIR/round-6succes.dat


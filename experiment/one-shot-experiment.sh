###########################
#	USAGE:		  #
#     nohup mode	  #
#nohup sudo -E ./round-3.sh
#	bash		  #
#  sudo -E ./round-3.sh	  #
###########################

WORKDIR="/home/vk/fair-drop_results/workdir"
sleep 10
echo "started experiment" > strt.dat
sudo -E $WORKDIR/experiment64-bell-exp.sh
sudo -E $WORKDIR/experiment64-bell-exp-fifo.sh
$WORKDIR/pcap2csv_noturbo.sh
$WORKDIR/pcap2csv_turbo.sh
$WORKDIR/plot_noturbo.sh
$WORKDIR/plot_turbo.sh

echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo -e "\n"
echo "################################"

echo "FINISHED EXPEIMENT" > $WORKDIR/round-3succes.dat


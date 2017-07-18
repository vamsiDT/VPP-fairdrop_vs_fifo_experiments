WORKDIR="/home/vk/fair-drop_results/workdir"
SCRIPTS="/home/vk/scripts"
BW=0.1

sudo killall vpp_main
sudo killall pktgen
sudo rm $RTE_PKTGEN/*.pcap  #Removing all pcap files in pktgen folder since the captured pcap in the experiment are stored here by default#

#CHECK DPDK-SETUP BEFORE RUNNING THE EXPERIMENT#

####################With cpu turbo boost##################
echo "enabling turbo boost"
echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo

echo "copying virtual fifo files to vpp src"
sudo -E $SCRIPTS/cpfifo.sh

####################BELL TRAFFIC##########################
sudo -E cp $WORKDIR/pktgen-ipv4-bell.c $RTE_PKTGEN/app/pktgen-ipv4.c
cd $RTE_PKTGEN
make

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
    echo -e "\n\n\\nPerforming experiment for Bandwidth limit $BW Bell traffic with cpu turbo boost\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 2 $BW
    sudo -E $SCRIPTS/installvpp.sh
    echo -e "\n\n\nStarting VPP in l3 forwarding mode with $NAMELC1P0 (Receiving interface) and $NAMELC1P1 (Transmitting Interface)\n\n\n"
    sleep 3
    sudo -E $SCRIPTS/vpp_l3.sh &
    sleep 20
    sudo -E $SCRIPTS/ctl.sh
    echo -e "\n\n\nStarting Dpdk-Pktgen with $LC0P0 (Transmitting Interface) and $LC0P1 (Capturing Interface)\n\n\n"
    #screen -L 
    $SCRIPTS/pktgen_capture.sh
    sudo killall vpp_main
    mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_bell64_turbo_fifo_"$BW".pcap
    BW=$(python -c "print($BW+0.1)")
done

echo "captured 1second traces from VPP with BW limitations [0.1 - 1] implementing virtual fifo with bell traffic and cpu turbo boost"

echo "capturing 1second trace of sent traffic (Bell-turbo)"

#screen -L 
$SCRIPTS/pktgen_capture_sent.sh
mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_bell64_sent_turbo_fifo.pcap

sudo killall vpp_main
sudo killall pktgen
sudo rm $RTE_PKTGEN/*.pcap

BW=0.1
####################EXPONENTIAL TRAFFIC##########################
sudo -E cp $WORKDIR/pktgen-ipv4-exp.c $RTE_PKTGEN/app/pktgen-ipv4.c
cd $RTE_PKTGEN
make

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
    echo -e "\n\n\\nPerforming experiment for Bandwidth limit $BW Exponential Traffic with cpu turbo boost\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 2 $BW
    sudo -E $SCRIPTS/installvpp.sh
    echo -e "\n\n\nStarting VPP in l3 forwarding mode with $NAMELC1P0 (Receiving interface) and $NAMELC1P1 (Transmitting Interface)\n\n\n"
    sleep 3
    sudo -E $SCRIPTS/vpp_l3.sh &
    sleep 20
    sudo -E $SCRIPTS/ctl.sh
    echo -e "\n\n\nStarting Dpdk-Pktgen with $LC0P0 (Transmitting Interface) and $LC0P1 (Capturing Interface)\n\n\n"
    #screen -L 
    $SCRIPTS/pktgen_capture.sh
    sudo killall vpp_main
    mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_exponential64_turbo_fifo_"$BW".pcap
    BW=$(python -c "print($BW+0.1)")
done

echo "captured 1second traces from VPP with BW limitations [0.1 - 1] implementing virtual fifo with exponential traffic and cpu turbo boost"

echo "capturing 1second trace of sent traffic (exponential-turbo)"

#screen -L 
$SCRIPTS/pktgen_capture_sent.sh
mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_exponential64_sent_turbo_fifo.pcap


######################WIthout cpu turbo boost#####################

sudo killall vpp_main
sudo killall pktgen
sudo rm $RTE_PKTGEN/*.pcap
BW=0.1

echo "disabling turbo boost"
echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo

####################BELL TRAFFIC##########################
sudo -E cp $WORKDIR/pktgen-ipv4-bell.c $RTE_PKTGEN/app/pktgen-ipv4.c
cd $RTE_PKTGEN
make

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
    echo -e "\n\n\\nPerforming experiment for Bandwidth limit $BW with bell traffic and no cpu turbo boost\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 2 $BW
    sudo -E $SCRIPTS/installvpp.sh
    echo -e "\n\n\nStarting VPP in l3 forwarding mode with $NAMELC1P0 (Receiving interface) and $NAMELC1P1 (Transmitting Interface)\n\n\n"
    sleep 3
    sudo -E $SCRIPTS/vpp_l3.sh &
    sleep 20
    sudo -E $SCRIPTS/ctl.sh
    echo -e "\n\n\nStarting Dpdk-Pktgen with $LC0P0 (Transmitting Interface) and $LC0P1 (Capturing Interface)\n\n\n"
    #screen -L 
    $SCRIPTS/pktgen_capture.sh
    sudo killall vpp_main
    mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_bell64_fifo_"$BW".pcap
    BW=$(python -c "print($BW+0.1)")
done

echo "captured 1second traces from VPP with BW limitations [0.1 - 1] implementing virtual fifo with bell traffic and no cpu turbo boost"

echo "capturing 1second trace of sent traffic (Bell-noturbo)"

#screen -L 
$SCRIPTS/pktgen_capture_sent.sh
mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_bell64_sent_fifo.pcap

sudo killall vpp_main
sudo killall pktgen
sudo rm $RTE_PKTGEN/*.pcap

BW=0.1
####################EXPONENTIAL TRAFFIC##########################
sudo -E cp $WORKDIR/pktgen-ipv4-exp.c $RTE_PKTGEN/app/pktgen-ipv4.c
cd $RTE_PKTGEN
make

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
    echo -e "\n\n\\nPerforming experiment for Bandwidth limit $BW with exponential traffic and no cpu turbo boost\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 2 $BW
    sudo -E $SCRIPTS/installvpp.sh
    echo -e "\n\n\nStarting VPP in l3 forwarding mode with $NAMELC1P0 (Receiving interface) and $NAMELC1P1 (Transmitting Interface)\n\n\n"
    sleep 3
    sudo -E $SCRIPTS/vpp_l3.sh &
    sleep 20
    sudo -E $SCRIPTS/ctl.sh
    echo -e "\n\n\nStarting Dpdk-Pktgen with $LC0P0 (Transmitting Interface) and $LC0P1 (Capturing Interface)\n\n\n"
    #screen -L 
    $SCRIPTS/pktgen_capture.sh
    sudo killall vpp_main
    mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_exponential64_fifo_"$BW".pcap
    BW=$(python -c "print($BW+0.1)")
done

echo "captured 1second traces from VPP with BW limitations [0.1 - 1] implementing fair-drop with exponential traffic and no cpu turbo boost"

echo "capturing 1second trace of sent traffic (Exponential-noturbo)"

#screen -L 
$SCRIPTS/pktgen_capture_sent.sh
mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_exponential64_sent_fifo.pcap


echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo -e "\n"
echo "################################"

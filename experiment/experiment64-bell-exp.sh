#################
#   Fair-drop   #
#   Experiment  #
################

WORKDIR="/home/vk/fair-drop_results/workdir"
SCRIPTS="/home/vk/scripts"
BW=0.1

sudo killall vpp_main
sudo killall pktgen
sudo rm $RTE_PKTGEN/*.pcap  #Removing all pcap files in pktgen folder since the captured pcap in the experiment are stored here by default
sudo -E $SCRIPTS/cpflow.sh  #Copying fair-drop code to vpp src

#CHECK DPDK-SETUP BEFORE RUNNING THE EXPERIMENT#

#####################################With turbo boost###############################
echo "enabling turbo boost"
echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo

####################BELL TRAFFIC##########################

#Compiling Pktgen with Bell Traffic#
sudo -E cp $WORKDIR/pktgen-ipv4-bell.c $RTE_PKTGEN/app/pktgen-ipv4.c
cd $RTE_PKTGEN
make

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
    echo -e "\n\n\\nPerforming experiment for Bandwidth limit $BW Bell Traffic with cpu turbo boost\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 1 $BW
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
    mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_bell64_turbo_"$BW".pcap
    BW=$(python -c "print($BW+0.1)")
done

echo "captured 1second traces from VPP with BW limitations [0.1 - 1] implementing fair-drop Bell Traffic with cpu turbo boost"

echo "capturing 1second trace of sent traffic (Bell-turbo)"

#screen -L 
$SCRIPTS/pktgen_capture_sent.sh
mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_bell64_sent_turbo.pcap


####################EXPONENTIAL TRAFFIC##########################
sudo killall vpp_main
sudo killall pktgen
sudo rm $RTE_PKTGEN/*.pcap
BW=0.1

#Compiling Pktgen with Exponential Traffic#
sudo -E cp $WORKDIR/pktgen-ipv4-exp.c $RTE_PKTGEN/app/pktgen-ipv4.c
cd $RTE_PKTGEN
make

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
    echo -e "\n\n\\nPerforming experiment for Bandwidth limit $BW Exponential traffic with cpu turbo boost\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 1 $BW
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
    mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_exponential64_turbo_"$BW".pcap
    BW=$(python -c "print($BW+0.1)")
done

echo "captured 1second traces from VPP with BW limitations [0.1 - 1] implementing fair-drop with exponential Traffic with cpu turbo boost"

echo "capturing 1second trace of sent traffic (exponential-turbo)"

#screen -L 
$SCRIPTS/pktgen_capture_sent.sh
mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_exponential64_sent_turbo.pcap


#####################################without turbo boost###############################

BW=0.1

sudo killall vpp_main
sudo killall pktgen
sudo rm $RTE_PKTGEN/*.pcap  #Removing all pcap files in pktgen folder since the captured pcap in the experiment are stored here by default#


echo "disabling turbo boost"
echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo

####################BELL TRAFFIC##########################

#Compiling Pktgen with Bell Traffic#
sudo -E cp $WORKDIR/pktgen-ipv4-bell.c $RTE_PKTGEN/app/pktgen-ipv4.c
cd $RTE_PKTGEN
make

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
    echo -e "\n\n\\nPerforming experiment for Bandwidth limit $BW Bell Traffic without cpu turbo boost\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 1 $BW
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
    mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_bell64_"$BW".pcap
    BW=$(python -c "print($BW+0.1)")
done

echo "captured 1second traces from VPP with BW limitations [0.1 - 1] implementing fair-drop with Bell Traffic without turbo boost"

echo "capturing 1second trace of sent traffic (Bell-noturbo)"

#screen -L 
$SCRIPTS/pktgen_capture_sent.sh
mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_bell64_sent.pcap

####################EXPONENTIAL TRAFFIC##########################
sudo killall vpp_main
sudo killall pktgen
sudo rm $RTE_PKTGEN/*.pcap
BW=0.1

#Compiling Pktgen with Exponential Traffic#
sudo -E cp $WORKDIR/pktgen-ipv4-exp.c $RTE_PKTGEN/app/pktgen-ipv4.c
cd $RTE_PKTGEN
make

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
    echo -e "\n\n\\nPerforming experiment for Bandwidth limit $BW Exponential traffic without cpu turbo boost\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 1 $BW
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
    mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_exponential64_"$BW".pcap
    BW=$(python -c "print($BW+0.1)")
done

echo "captured 1second traces from VPP with BW limitations [0.1 - 1] implementing fair-drop Exponential Traffic without turbo boost"

echo "capturing 1second trace of sent traffic (exponential-noturbo)"

#screen -L 
$SCRIPTS/pktgen_capture_sent.sh
mv $RTE_PKTGEN/*.pcap $WORKDIR/fair-drop_exponential64_sent.pcap






echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo -e "\n"
echo "################################"

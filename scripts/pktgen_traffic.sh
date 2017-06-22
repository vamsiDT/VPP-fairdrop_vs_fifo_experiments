#USAGE : pktgen_traffic.sh bell/exp
cd $RTE_PKTGEN
$SCRIPTS/change-pktgen-traffic.sh $1
cd $RTE_PKTGEN
make

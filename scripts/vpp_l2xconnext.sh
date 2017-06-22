sudo $VPP_ROOT/build-root/install-vpp-native/vpp/bin/vpp  cpu {main-core 28} api-segment {prefix vpp1} dpdk { dev $LC1P0  dev $LC1P1 socket-mem 4096,4096} plugin_path $VPP_ROOT/build-root/install-vpp-native/vpp/lib64/vpp_plugins
sudo $SFLAG vppctl -p vpp1 set int l2 xconnect $NAMELC1P0 $NAMELC1P1
sudo $SFLAG vppctl -p vpp1 set int l2 xconnect $NAMELC1P1 $NAMELC1P0
sudo $SFLAG vppctl -p vpp1 set interface promiscuous on $NAMELC1P1
sudo $SFLAG vppctl -p vpp1 set interface promiscuous on $NAMELC1P0
sudo $SFLAG vppctl -p vpp1 set interface state $NAMELC1P0 up
sudo $SFLAG vppctl -p vpp1 set interface state $NAMELC1P1 up
sudo $SFLAG vppctl -p vpp1

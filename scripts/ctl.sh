#sudo $VPP_ROOT/build-root/install-vpp-native/vpp/bin/vpp  unix {nodaemon} cpu {main-core 28} api-segment {prefix vpp1} dpdk { dev $LC1P0  dev $LC1P1 socket-mem 4096,4096} plugin_path $VPP_ROOT/build-root/install-vpp-native/vpp/lib64/vpp_plugins

sudo $SFLAG vppctl -p vpp1 set ip arp $NAMELC1P1 137.194.208.1 $MACLC0P1
sudo $SFLAG vppctl -p vpp1 ip route add 0.0.0.0/0 via 137.194.208.1
sudo $SFLAG vppctl -p vpp1 set interface promiscuous on $NAMELC1P1
sudo $SFLAG vppctl -p vpp1 set interface promiscuous on $NAMELC1P0
sudo $SFLAG vppctl -p vpp1 set int ip addr $NAMELC1P1 192.168.2.2/24
sudo $SFLAG vppctl -p vpp1 set int ip addr $NAMELC1P0 192.168.2.3/32
sudo $SFLAG vppctl -p vpp1 set interface state $NAMELC1P0 up
sudo $SFLAG vppctl -p vpp1 set interface state $NAMELC1P1 up
#sudo $SFLAG vppctl -p vpp1

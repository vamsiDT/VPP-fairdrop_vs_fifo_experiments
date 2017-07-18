sudo -E cp /home/vk/VPP_flow_table/node.c.default $VPP_ROOT/src/plugins/dpdk/device/node.c
#sudo -E cp $VPP_ROOT/ip4_forward.c $VPP_ROOT/src/vnet/ip/
sudo rm $VPP_ROOT/src/plugins/dpdk/device/flow_table*
#sudo rm $VPP_ROOT/src/vnet/ip/fifo*
sudo -E cp /home/vk/VPP_virtual_fifo/* $VPP_ROOT/src/vnet/ip/

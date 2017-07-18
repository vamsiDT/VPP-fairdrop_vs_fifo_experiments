#sudo -E cp $VPP_ROOT/ip4_input.c $VPP_ROOT/src/vnet/ip/
sudo -E cp /home/vk/VPP_virtual_fifo/ip4_forward.c.default $VPP_ROOT/src/vnet/ip/ip4_forward.c
#sudo rm $VPP_ROOT/src/vnet/ip/flow_table*
sudo rm $VPP_ROOT/src/vnet/ip/fifo*
sudo -E cp /home/vk/VPP_flow_table/* $VPP_ROOT/src/plugins/dpdk/device/

cd $RTE_PKTGEN
sudo -E app/app/x86_64-native-linuxapp-gcc/pktgen -l 12,13-20 --socket-mem 8192,8192 -n 4 -w $LC0P0 -w $LC1P0 -- -P -T -m "[13-14:15-16].0,[17-18:19-20].1" -f /home/vk/scripts/pktgen_capture.lua

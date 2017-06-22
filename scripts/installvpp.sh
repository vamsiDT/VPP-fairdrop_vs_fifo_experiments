#sudo rm /usr/lib/vpp_api_test_plugins/*
#sudo rm /usr/lib/vpp_plugins/*
cd $VPP_ROOT
sudo make rebuild-release
#sudo make pkg-deb
#sudo dpkg -i ./build-root/*.deb
#echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
#sudo $RTE_SDK/usertools/dpdk-devbind.py -b igb_uio 0b:00.0 0b:00.1 84:00.0 84:00.1

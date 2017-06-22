#how to use example: ./capture.sh filename   #filename without pcap extension
#DPDK-Pktgen is used to capture pcap files
#use -e options to output only the fields which are of interest.
# known options are frame.number,eth.src,eth.dst,ip.src,ip.dst,tcp.srcport,tcp.dstport,frame.len

tshark -r $1 -T fields -e frame.number -e ip.dst  > $2

#tshark -r $1.pcap -T fields -e frame.number -e eth.src -e eth.dst -e ip.src -e ip.dst -e frame.len > $1.csv

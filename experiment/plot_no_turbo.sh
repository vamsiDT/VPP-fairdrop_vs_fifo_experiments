BW=0.1
until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do
PACKETS_BELL=$(cat fair-drop_bell64_$BW.csv | wc -l)
PACKETS_BELL_FIFO=$(cat fair-drop_bell64_fifo_$BW.csv | wc -l)
PACKETS_EXP=$(cat fair-drop_exponential64_$BW.csv | wc -l)
PACKETS_EXP_FIFO=$(cat fair-drop_exponential64_fifo_$BW.csv | wc -l)

gnuplot -persist <<-EOFMarker
#set yrange [0:10000000]
f(x) = x/1000000
set xlabel "destination_ip_address/flow XXX.168.1.1"
set ylabel "Average Million Packets/sec "
set title "VPP Comparision between Virtual FIFO and Fairdrop module with $BW bandwidth limit"
set terminal png size 1920,1080
set output 'fair-drop_bell64_fairvsfifo_noturbo_$BW.png'
plot "fair-drop_bell64_$BW.dat" using (column(0)):(f(\$1)):xtic(2) with linespoints lw 2 pt 7 t "VPP with Fairdrop module. $PACKETS_BELL packets captured in 1 sec","fair-drop_bell64_fifo_$BW.dat" using (column(0)-1):(f(\$1)):xtic(2) with linespoints lw 2 pt 5 t "VPP with Virtual FIFO $PACKETS_BELL_FIFO packets captured in 1 sec"
EOFMarker

gnuplot -persist <<-EOFMarker
#set yrange [0:10000000]
f(x) = x/1000000
set xlabel "destination_ip_address/flow XXX.168.1.1"
set ylabel "Average Million Packets/sec "
set title "VPP Comparision between Virtual FIFO and Fairdrop module with $BW bandwidth limit"
set terminal png size 1920,1080
set output 'fair-drop_exponential64_fairvsfifo_noturbo_$BW.png'
plot "fair-drop_exponential64_$BW.dat" using (column(0)):(f(\$1)):xtic(2) with linespoints lw 2 pt 7 t "VPP with Fairdrop module. $PACKETS_EXP packets captured in 1 sec","fair-drop_exponential64_fifo_$BW.dat" using (column(0)-1):(f(\$1)):xtic(2) with linespoints lw 2 pt 5 t "VPP with Virtual FIFO $PACKETS_EXP_FIFO packets captured in 1 sec"
EOFMarker

BW=$(python -c "print($BW+0.1)")

done

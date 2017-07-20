DAT="/home/vamsi/VPP/VPP-fairdrop_vs_fifo_experiments/data/origdat"
SDAT="/home/vamsi/VPP/VPP-fairdrop_vs_fifo_experiments/data/sortdat"

for i in bell exponential
do
BW=0.1
until [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do

						#VSTATE#
	cat $DAT/fair-drop_$i""64_turbo_$BW.dat | sort -rn > $SDAT/fair-drop_$i""64_turbo_$BW.dat
						#FIFO#
	cat $DAT/fair-drop_$i""64_turbo_fifo_$BW.dat | sort -rn > $SDAT/fair-drop_$i""64_turbo_fifo_$BW.dat

	BW=$(python -c "print($BW+0.1)")
done

						#SENT#
	cat $DAT/fair-drop_$i""64_sent_turbo.dat | sort -rn > $SDAT/fair-drop_$i""64_sent_turbo.dat
	cat $DAT/fair-drop_$i""64_sent_turbo_fifo.dat | sort -rn > $SDAT/fair-drop_$i""64_sent_turbo_fifo.dat
done


for i in bell exponential
do
BW=0.1
until [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
do

						#VSTATE#
	cat $DAT/fair-drop_$i""64_$BW.dat | sort -rn > $SDAT/fair-drop_$i""64_$BW.dat
						#FIFO#
	cat $DAT/fair-drop_$i""64_fifo_$BW.dat | sort -rn > $SDAT/fair-drop_$i""64_fifo_$BW.dat

	BW=$(python -c "print($BW+0.1)")
done

						#SENT#
	cat $DAT/fair-drop_$i""64_sent.dat | sort -rn > $SDAT/fair-drop_$i""64_sent.dat
	cat $DAT/fair-drop_$i""64_sent_fifo.dat | sort -rn > $SDAT/fair-drop_$i""64_sent_fifo.dat
done

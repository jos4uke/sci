#!/bin/bash 

# custom script to use with own chromosome names 
# chromosome names are provided using first column in chrom.sizes file (`cut -f1,2 genome.fasta.fai >genome.chrom.sizes`)
infile=$1
chrom_names=($(cut -f1 $2))
outfile=$3
res=$4

# original
#for ((i=1;i<=22;i++)); do 
#	for ((j=$((i));j<=22;j++)); do 
#		c1=chr${i}
#		c2=chr${j}
#		java -jar ${JUICERTOOLS} dump observed NONE ${infile} chr${i} chr${j}  BP ${res} | awk -v c1=chr${i} -v c2=chr${j} -v res=${res} '{OFS="\t"}{print c1,$1,$1+res,c2,$2,$2+res,$3}' >> ${outfile};
#	done 
#done


#dump <observed/oe> <NONE/VC/VC_SQRT/KR> <hicFile(s)> <chr1>[:x1:x2] <chr2>[:y1:y2] <BP/FRAG> <binsize> [outfile]

# custom
for ((i=0;i<${#chrom_names[@]};i++)); do
	for ((j=$((i));j<${#chrom_names[@]};j++)); do
		c1=${chrom_names[$i]}
                c2=${chrom_names[$j]}
                java -jar ${JUICERTOOLS} dump observed NONE ${infile} ${c1} ${c2}  BP ${res} | awk -v c1=${c1} -v c2=${c2} -v res=${res} '{OFS="\t"}{print c1,$1,$1+res,c2,$2,$2+res,$3}' >> ${outfile};
        done
done

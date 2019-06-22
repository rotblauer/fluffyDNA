#!/bin/bash

rm ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf*
rm NC_012920.1.fasta
# download mitochondrial genotypes
wget "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf.gz.tbi"
wget "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf.gz"

#download mito reference -  revised Cambridge Reference Sequence (rCRS)

wget -O NC_012920.1.fasta 'https://www.ncbi.nlm.nih.gov/search/api/sequence/NC_012920.1/?report=fasta'

fasta=NC_012920.1.fasta
vcf=ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf.gz

#Update contig to match vcf
sed -i '' -e "s/>NC_012920.1 Homo sapiens mitochondrion, complete genome/>MT/g" $fasta


# split multiallelic sites
vcfSplit=ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.norm.split.vcf.gz
bcftools norm -m "-" "$vcf" |bgzip > $vcfSplit
tabix -p vcf $vcfSplit


# generate consensus seq for all samples
outDir=consensus/
mkdir -p $outDir
bcftools query -l $vcfSplit \
|parallel -j4 "bcftools consensus -s {} -f $fasta $vcf |sed 's/>MT/>{}.MT.consensus/g' " \
|bgzip --compress-level 9 > "$outDir/consensus.fa.gz"



# x-10-0-1-5:consensus Kitty$ zgrep ">" consensus.fa.gz |wc -l
#      662
# x-10-0-1-5:consensus Kitty$ dud
# 2.0M	.
# x-10-0-1-5:consensus Kitty$ 
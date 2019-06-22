#!/bin/bash


# download mitochondrial genotypes
wget "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf.gz.tbi"
wget "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf.gz"

#download mito reference -  revised Cambridge Reference Sequence (rCRS)

wget -O NC_012920.1.fasta 'https://www.ncbi.nlm.nih.gov/search/api/sequence/NC_012920.1/?report=fasta'

#Update contig to match vcf
sed -i '' -e "s/>NC_012920.1 Homo sapiens mitochondrion, complete genome/>MT/g" NC_012920.1.fasta

# split multiallelic sites
bcftools norm -multiallelics - $vcf |bgzip >ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.norm.split.vcf.gz
vcf=ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.norm.split.vcf.gz
tabix -p vcf $vcf 

fasta=NC_012920.1.fasta
vcf=ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf.gz
outDir=consensus/
mkdir -p $outDir


# generate consensus seq for all samples
bcftools query -l $vcf |parallel "bcftools consensus -s {} -f $fasta $vcf |bgzip > $outDir{}.fa.gz "

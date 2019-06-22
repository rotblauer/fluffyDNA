#!/bin/bash


# download mitochondrial genotypes
wget "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf.gz.tbi"
wget "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.vcf.gz"

#download mito reference -  revised Cambridge Reference Sequence (rCRS)

wget -O NC_012920.1.fasta 'https://www.ncbi.nlm.nih.gov/search/api/sequence/NC_012920.1/?report=fasta'
#!/usr/bin/env bash


vcfSplit=/Users/Kitty/git/fluffyDNA/prep/ALL.chrMT.phase3_callmom-v0_4.20130502.genotypes.norm.split.vcf.gz
mkdir haplogrep
cd haplogrep
wget https://github.com/seppinho/haplogrep-cmd/releases/download/v2.1.20/haplogrep-2.1.20.jar


java -jar haplogrep-2.1.20.jar --in $vcfSplit --format vcf --out haplogroups.txt
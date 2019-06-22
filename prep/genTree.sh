#!/bin/bash

fasta=./consensus/consensus.fa.gz 

#conda install -c etetoolkit ete3 ete_toolchain


# https://www.molecularecologist.com/2017/02/phylogenetic-trees-in-r-using-ggtree/
# library("ggtree")

ete3 build -C 4 -n $fasta -w soft_modeltest -o mtTree/
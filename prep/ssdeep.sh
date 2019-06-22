#!/usr/bin/env bash

outdir=./ssdeep/
mkdir -p $outdir


ssdeep -b ./consensus/*.txt >"$outdir"ssdeep.txt



ssdeep -b -m "$outdir"ssdeep.txt ./consensus/*.txt |gzip --best>"$outdir"ssdeep.match.txt.gz


# -g -t 90 
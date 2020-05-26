#!/usr/bin/env bash


sub=$1

# set up input and output directories.
dsroot=`pwd` # assume you are running from the root
codedir=$dsroot/code


# PART 3: Run MRIQC on subject

# make derivatives folder if it doesn't exist. 
# let's keep this out of bids for now
if [ ! -d $dsroot/derivatives/mriqc ]; then
	mkdir -p $dsroot/derivatives/mriqc
fi
scratchdir=/data/scratch/`whoami`
if [ ! -d $scratchdir ]; then
	mkdir -p $scratchdir
fi


singularity run --cleanenv \
-B $dsroot/bids:/data \
-B $dsroot/derivatives/mriqc:/out \
-B $scratchdir:/scratch \
/data/tools/mriqc-0.15.2.simg \
/data /out \
participant --participant_label $sub -w /scratch



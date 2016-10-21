#!/bin/sh
#
#
#PBS -N Demo
#PBS -o output/output.file
#PBS -e error/error.file
#PBS -m ae
#PBS -l walltime=02:30:00
#

module load R

#----------------------------------------------------#
# CHANGE YOUR VSC NUMBER HERE AND GOD WILL DO THE REST
vsc=
#----------------------------------------------------#


srcdir=/user/home/gent/vsc407/vsc40728/vsc"$vsc"
cd $srcdir

Rscript MainR.R ${PBS_ARRAYID} $vsc

echo "job finished"

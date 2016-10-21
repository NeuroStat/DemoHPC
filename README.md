# HPC and R
Small Script to demonstrate running R scripts in parallel on UGent HPC

The High Perfomance Computing environment is an excellent tool to accelerate computations.
Note, that you only gain time by running calculations in parallel. The HPC infrastructure is not a kind of supercomputer that runs faster than your regular PC!

In order to do this, we have a general workflow.

After setting up an account: 
[HPC](http://www.ugent.be/hpc/nl/toegang-beleid)

Getting your files onto the HPC:
[Copy Data](http://hpc.ugent.be/userwiki/index.php/User:VscCopy)

And login to the infrastructure:
[Login](http://hpc.ugent.be/userwiki/index.php/User:VscConnect)

It is time to go!

## Commands to remember
Some useful commands in bash are:
```bash
# To see where you are:
pwd

# To list the files in your current directory:
ls

# To navigate to a folder:
cd folder

# To navigate to folder above:
cd ..

# To create a new folder named output
mkdir output

# To create a new folder named error
mkdir error

# To execute a bash script K = 8 times (over K = 8 different cores, generates K IDs).
# You can chance this 1-8 to any number!
qsub -t 1-8 Bash.sh

# To track progress of running jobs:
qstat -ta
```

## Main Bash file
The first lines in this file are always needed:

```bash
#!/bin/sh
#
#
#PBS -N Demo
#PBS -o output/output.file
#PBS -e error/error.file
#PBS -m ae
#PBS -l walltime=02:30:00
#
```

The commands after _#PBS_ are options:
* _-N_ gives your job a name (useful)
* _-o_ sets directory where output that is being printed to a console can be saved
* _-e_ same, but outputs the error (if one occurs)
* _-m_ Send me an e-mail when:
  * _a_ ==> job gets aborted
  * _e_ ==> job is executed
* _-l_ the expected runtime (walltime) of your script
  * Important to have a decent walltime, any job exceeding this will be terminated!!!

> Jobs with a walltime larger than 12:00:00 will end up in a longer waiting queue, than jobs with a shorter walltime!

Then you will see a line with the modules that are needed
```bash
module load R
```

In this demo, we show how arguments can be given to a command. 
This is demonstrated in giving your vsc number so we can use this in **R** to output to your directory.

The main command is:
```bash
Rscript MainR.R ${PBS_ARRAYID} $vsc
```
This starts an R script called MainR.R. It has two arguments. The first `${PBS_ARRAYID}` is an ID obtained by executing `<qsub -t 1-8>`. It means that it will start 8 times the MainR.R script, with each time a number ranging from 1 to 8. The second argument is the _vsc_ number. 

## R script
When going to your **R** script, it is important to utilize this ID. As shown below, we get the ID and assign it to _K_:
```r
# activate input
input <- commandArgs(TRUE)
# Here we say, take the first argument from your input.
  # Hence this corresponds to PBS_ARRAYID in your bash script
K <- as.numeric(as.character(input)[1])

# You can give more arguments, e.g. here is your account number (second argument)
vsc <- as.numeric(as.character(args)[2])
```

If you run simulations or seperate analyses, make sure you use this _K_:
```r
# Seed based on K !!!
seed <- 50*K
set.seed(seed)
```

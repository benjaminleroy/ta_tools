# SLURM

Slurm is a job management system that allows prioritization and allocation of resources. On high performance computers slurm helps make sure jobs are run as rapidly as possible.

## Use in statistical computing

In `python`, `R`, `C++` (and probably `Fortran`) one can perform parallel computing through many different in-language packages. The most common use of parallelization when an analysis can be broken until into many subparts (e.g. parameter tuning, or data processing). In slurm, although we will mention some in-language approaches, it is common to do the parallization **outside** of the language and in slurm.

## General requirements for use:

To use slurm (with any time of parallization) you'll need to understand

1. the amount of time your job with take up (actually an over-estimate of such things)
2. (to a lesser extend) the amount of storage and RAM you will be using

# Basics of using SLURM

## Basic / commonly used commands

Because slurm is make decisions on when your code will run, what resources its using and more it's important to be able to examine how many jobs are running (and the total potential for running jobs), be able to cancel your jobs and know how to submit jobs to be run.

|Commmand|Description| Unix similarity |
|--------|-----------|-----------------|
|`squeue`| get all projects that are running on the system | `top` |
|`squeue -u leroy` | all jobs running for me | `top -u leroy` |
|`sinfo`| provide information about the state of each node (look for idle nodes) | |
|`scancel`| cancel jobs | slightly similar to `screen -XS _JobID__`
|
|`scancel -u leroy` | cancel all my jobs | |
|`scancel _JobID__`| cancel job with id: _JobID__| |
|`sbatch _bash_script__`| submit batch request | slightly similar to `screen` |
|`sbatch _` | submit your jobs

## Execution process (using `sbatch`)



### Job Arrays

https://slurm.schedmd.com/job_array.html
http://rcpedia.stanford.edu/topicGuides/jobArrayRExample.html


# `R` + `SLURM`

On the PSC `R` should already be installed for you. When you first install a package (from the terminal command line), it will ask if you'd like to install locally (which you should say YES to.). After that you'll have a `R/` folder on the server.


# `python` + `SLURM`

...

# Working with the Pittsburgh Super Computer

## Getting Access

To get access to the computing resources on the PSC you will need to

1. Have an NSF fellowship - then you can get allocations without any supervision
2. Have your Advisor request access...

## File moving

You can use scp and scp tools like cyberduck


# SLURM

## `R` + SLURM

```bash
#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --job-name="A long job"
#SBATCH --mem=5GB
#SBATCH --output=long-job.out
cd /path/where/to/start/the/job



set -x #echo some information out for each job (in a log)

Rscript --vanilla long-job-rscript.R
```

### Parallelization within `R`

https://rcc.uchicago.edu/docs/software/environments/R/index.html


## Job arrays

https://slurm.schedmd.com/job_array.html
http://rcpedia.stanford.edu/topicGuides/jobArrayRExample.html

# Other Links

[R and Slurm](https://cran.r-project.org/web/packages/slurmR/vignettes/working-with-slurm.html)


# can use scp through cyberduck


# Thanks
Thanks to Robin Dunn for help with the ideas behind the first draft (aka teaching Ben)

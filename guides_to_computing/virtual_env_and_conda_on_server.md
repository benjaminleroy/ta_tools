







# Conda
Though I used to not think Conda was worthwhile, here's how I set it up on an virtual env:

https://www.digitalocean.com/community/tutorials/how-to-install-the-anaconda-python-distribution-on-ubuntu-16-04

which has the steps:

1. `cd /tmp`
2. `curl -O https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh` where you substitute `5.0.1` with the most up-to-date version on https://www.continuum.io/downloads
3. Check the hash `sha256sum Anaconda3-5.0.1-Linux-x86_64.sh`, look here for hash you need to match: https://docs.continuum.io/anaconda/hashes/lin-3-64
4. Finally run `bash Anaconda3-5.0.1-Linux-x86_64.sh`

Then when installing:

a. First review license (ENTER)

b. Approve license terms (yes)

c. Accept location of creation (ENTER)

d. Say (yes) to use the `conda` command

e. then `source ~/.bashrc`

f. check `conda` is working with `conda list`

# Virtual Environments (with Conda)

see https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda/

Basically:

1. Create new environment (note that `base` is your standard environment)
`conda create -n yourenvname python=x.x anaconda`

2. Activate the environment with
`source activate yourenvname`

3. Install packages with
`conda install -n yourenvname [package]`
*Note: you have to tell it `youreenvname` else it will install on the base.*

4. Deactivate:
`source deactivate`

## My packages
```
(lots of packages loaded when you install condas)
conda install progressbar2 #for progressbar
conda install -c https://conda.anaconda.org/biocore scikit-bio #skbio (http://scikit-bio.org/)
```


# Old Information
Above I demonstrate how to use virtual environments with the conda framework. Below is information about virtual environments **without Conda**.
## Virtual Environments (without Conda)

Following:

https://realpython.com/python-virtual-environments-a-primer/


1. I create python-virtual-environments/ in my top directories
2. In that folder, either:
```{bash}
# Python 2:
$ virtualenv env

# Python 3
$ python3 -m venv env
```
where "env" is the new enviroment we will be using

Then in the shell do (in this directory):

```{bash}
$ source env/bin/activate
(env) $
```

when you wish to deactivate the enviroment just do:
```{bash}
(env) $ deactivate
$
```

## Note
For some reason I've had to `source ~/.bashrc` multiple times when I start a session

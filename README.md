# TA tools

This repository is an informal place for TAs to find useful tools to preform administrative tasks.


## Using a Google Sheets to track grades:

There are many reasons to use google docs to track students grades. **Just make sure to protect student privacy.** Google Sheets provide the ability to look back on grades, and provide a good way to allow undergrad graders a place to grade without having direct control over the student's grades. Google Sheets also provides the ability to have multiple people grade at the same time without any worry about loss of work. Additionally, as can be seen in our example [sheet](https://docs.google.com/spreadsheets/d/1g5OT_an6K2hQ__AAihSbMdMLT-iT4I0POn2384bPE9I/edit?usp=sharing), Google Sheets provide functions to combining comments to be copied into Canvas.

In the `google_sheet_tracking` folder we provide a basic `R` script to strip a Canvas grade sheet to make the 3 columns in our example sheet above.

## Compiling a group of Rscripts.

For a few coding classes (315 and 350?) it common for students to submit `.Rmd` files that need to be knitted. Instead of running all of these files by hand, the `rmd_rendering/render_hw.R` script provides a way to render all homework `.Rmd` files in a folder. Current implimentation looks for a few special bad lines of code, **ignores knitting if there is an html file already**, and opens zip files and goes inside to knit the `.Rmd` file if necessary.

## Visualizing group preferences.
The associated `R` file creates a visualization of the preferences of students as a interactive network. This was specifically designed for a class that collected student preferences using a google survey, where they were asked to select up to 3 other friends and up to 3 people they didn't wish to work with. We then piped these preferences into the script to create some visualization and the associated edges. Specifically used for 36-315 one semester.

# Guides to Computing at CMU Statistics:

1. Using `screen` on the server to allow for processes to run when you close the `ssh` session. This is actually in the `ssh.md` file, may add thoughts on `ssh`ing as well. Also note, `screen` is just 1 option. I know Nic Dalmasso uses another (assoicated with `python`).

2. Setting up virtual environments (for `python`) on the server. This is included in `virtual_env_and_conda_on_server.md`. Additionally this file also provides how to put `conda` on an virtual environment on the server.

3. Running a jupyter notebook (for `python`, but you can also do more to get `R` on a jupyter notebook) from the server. This is included in `jupyter_notebook_from_server.md`. Note this assumes you have a jupter notebook on the server, which I set up using a virtual env and conda (see \#2)
# TA tools

This repository is an informal place for TAs to find useful tools to preform administrative tasks.



## Using a Google Sheets to track grades:

There are many reasons to use google docs to track students grades. **Just make sure to protect student privacy.** Google Sheets provide the ability to look back on grades, and provide a good way to allow undergrad graders a place to grade without having direct control over the student's grades. Google Sheets also provides the ability to have multiple people grade at the same time without any worry about loss of work. Additionally, as can be seen in our example [sheet](https://docs.google.com/spreadsheets/d/1g5OT_an6K2hQ__AAihSbMdMLT-iT4I0POn2384bPE9I/edit?usp=sharing), Google Sheets provide functions to combining comments to be copied into Canvas.

In the `google_sheet_tracking` folder we provide a basic `R` script to strip a Canvas grade sheet to make the 3 columns in our example sheet above.

## Compiling a group of Rscripts.

For a few coding classes (315 and 350?) it common for students to submit `.Rmd` files that need to be knitted. Instead of running all of these files by hand, the `rmd_rendering/render_hw.R` script provides a way to render all homework `.Rmd` files in a folder. Current implimentation looks for a few special bad lines of code, **ignores knitting if there is an html file already**, and opens zip files and goes inside to knit the `.Rmd` file if necessary.


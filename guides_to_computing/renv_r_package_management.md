# R's `renv` (a package management tool)

Like `conda` in `python`, R has a package management tool (albeit less advanced), called [`renv`](https://rstudio.github.io/renv/).  I personally recommend having these for any package / set of tools you develop. I'm going to introduce it relative to a shiny app on shimmer^[In the future I can imagine someone extending to this commentary with commentary relative to a `R` package or at least a github repository - not just a set of files.].

## 1. Motivation

`renv` for `R` and `conda` for `python` are useful tools. They allow the user to more easily share code and not work about dependency issues for different people (recommended for consultant projects and group projects). Additionally, here at CMU Statistics and Data Science, if you're using the servers, you've probably experiences the server crash and remove all your `R` libraries (or you've updated `Rstudio` and a similar thing has occured). **Enter the `renv` package.** This package stores all your libraries, their versions and their dependences.

## 2. How to think about `renv` workflow

Below you'll see a **getting starte** example walk through. Something that may catch your eye is that the package updating and saving has similar structures and function names to `git` workflow (which you learned in Stat Computing).

## 3. Getting started

### 3.1 Example Directory:
Let's suppose you already have a set of files going, (for this example, a shiny app). Specifically, in my Shiny app repository `36-350_shiny_files` I have:

```
.
├── 36350
│   ├── 350_syllabus.pdf
│   ├── Homework
│   │   ├── hw_1-assign.Rmd
│   │   └── ...
│   ├── Labs
│   │   ├── lab_1-assign.Rmd
│   │   └── ...
│   └── Lectures
│       ├── 1.1_intro.Rmd
│       └── ...
└── app.R
```

### 3.2 `.renvignore` (Ignoring files)

Basically this is just a `shiny`-based file sharing app (don't ask why it exists). It contains `Rmd` files and an `app.R` file, but I really only want to make sure that I keep all my libraries need to make `app.R` run correctly. To hide these other files, I create a `.renvignore` file and make it look like the following.

```
36350/*
```

The syntax for this file is the exact same as a `.gitignore` file and if you don't make the `.renvignore` file it will just use a `.gitignore` file if you have one (see [Documenation of Ignoring files](https://rstudio.github.io/renv/reference/dependencies.html#ignoring-files) for more details).

### 3.3 `renv::init()`

Now, in the shiny app directory, we can run

```r
library(renv)
renv::init()
```

For our package this returned the following:
```r
> renv::init()
* Initializing project ...
* Discovering package dependencies ... Done!
* Copying packages into the cache ... Done!
The following package(s) will be updated in the lockfile:

# CRAN ===============================
- BH            [* -> 1.72.0-3]
- R6            [* -> 2.4.1]
- Rcpp          [* -> 1.0.5]
- assertthat    [* -> 0.2.1]
- cli           [* -> 2.0.2]
- crayon        [* -> 1.3.4]
- digest        [* -> 0.6.25]
- ellipsis      [* -> 0.3.1]
- fansi         [* -> 0.4.1]
- fastmap       [* -> 1.0.1]
- fs            [* -> 1.2.7]
- glue          [* -> 1.4.2]
- htmltools     [* -> 0.4.0]
- httpuv        [* -> 1.5.2]
- jsonlite      [* -> 1.6]
- later         [* -> 1.0.0]
- lifecycle     [* -> 0.2.0]
- magrittr      [* -> 1.5]
- mime          [* -> 0.6]
- pillar        [* -> 1.4.6]
- pkgconfig     [* -> 2.0.3]
- promises      [* -> 1.1.0]
- renv          [* -> 0.12.3]
- rlang         [* -> 0.4.7]
- shiny         [* -> 1.4.0]
- shinyFiles    [* -> 0.8.0]
- sourcetools   [* -> 0.1.7]
- tibble        [* -> 3.0.3]
- utf8          [* -> 1.1.4]
- vctrs         [* -> 0.3.4]
- xtable        [* -> 1.8-3]

* Lockfile written to '~/ShinyApps/36-350_files/renv.lock'.
* Project '~/ShinyApps/36-350_files' loaded. [renv 0.12.3]
* renv activated -- please restart the R session.
```

#### 3.3.4 Package locations (not only CRAN)

This shiny app's code is rather basic, but note that it captures dependences (like `magrittr` that I didn't actually call in the app.). Additionally, it's decided that all of these are from CRAN, but it can also **use packages that are not in CRAN** (see [Package Sources](https://rstudio.github.io/renv/articles/renv.html#package-sources-1) for options).

#### 3.3.5 How it stores this information

In the parent directory I also now have a file called `renv.lock`, this is a yaml file with all the package and R information, and looks like this:

```
{
  "R": {
    "Version": "3.6.0",
    "Repositories": [
      {
        "Name": "CRAN",
        "URL": "https://cloud.r-project.org"
      }
    ]
  },
  "Packages": {
    ...,
    "shiny": {
      "Package": "shiny",
      "Version": "1.4.0",
      "Source": "Repository",
      "Repository": "CRAN",
      "Hash": "6ca23724bb2c804c1d0b3db4862a39c7"
    },
    ...
  }

```


### 3.4 `installing` and understanding the `renv` structure

You should also note that you can see that I have `shiny`, version `1.4.0` defined in this intialization. At the time of writing this, `shiny`, version `1.5.0` is on CRAN. Let' suppose I wish to update, `shiny`, and run the following:

```r
install.package("shiny")
```

First, I'll ok up an R console in this directly, and it will state:

```
...

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

* Project '~/ShinyApps/36-350_files' loaded. [renv 0.12.3]
```
This final line tells me I do have an `renv` available and active. I'll run the installation file, and if I peek at the `renv.lock` file it still is telling me I care about `shiny`, version 1.4.0.

#### 3.5 `renv::status` checking which differences exist

Like `git` I can check which packages differ in my `renv` compared to the current packages loaded with `renv::status` (and the following appears). This shows that `withr`, `commonmark` and `base64enc` are new packages loaded by the update and `htmltools` was also updated when I updated `shiny`.

```r
> renv::status()
The following package(s) are installed but not recorded in the lockfile:
             _
  withr        [2.3.0]
  commonmark   [1.7]
  base64enc    [0.1-3]

Use `renv::snapshot()` to add these packages to your lockfile.

The following package(s) are out of sync:

   Package   Lockfile Version   Library Version
 htmltools              0.4.0             0.5.0
     shiny              1.4.0             1.5.0

Use `renv::snapshot()` to save the state of your library to the lockfile.
Use `renv::restore()` to restore your library from the lockfile.
```

#### 3.6 `renv::restore`

Suppose I really like version 1.4 instead of 1.5 for `shiny` (and my old snapshot). Then I can run:

```r
renv::restore()
```

This will ask me if I am sure I wish to revert, and then do so., getting me back to 1.4.0 for `shiny`:

```r
> utils::packageVersion("shiny")
[1] ‘1.4.0’
```

What's nice about this is that - `renv::restore` should also restore my `R` package environment (aka `renv` :P ), if the server crashes and removes all my packages.

#### 3.7 creating a new snapshot (`renv::snapshot`)

Let's instead imagine I did actually want to snapshot/update `shiny` for my environment. Then (after reinstalling `shiny` 1.5.0), I can instead do

```r
renv::snapshot()
```

which will again ask if I'm sure and then update the `renv.lock` file to include my new packages (so if I run `renv::status` I'll see the new package versions).

#### 3.8 smart `renv` tools

Every time you reopen your directory in `R` it will do a check to tell you if you have any packages that don't align with your `renv` - you can then correct that with a `renv::restore()` or `renv::snapshot()`.

## 4. Other resources

- [`Rstudio` on Reprodicible Environments](https://environments.rstudio.com/)
- [Miles McBain on `drake` workflow](https://www.milesmcbain.com/posts/the-drake-post/): probably more for data science pipelines than code you'll work on in grad school
- [Miles McBain on motivation for `packrat` (`renv` is the "2.0" of `packrat`)](https://www.milesmcbain.com/posts/packrat-lite/)


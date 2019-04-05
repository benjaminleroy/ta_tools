# Using Screen on the Server (can also use `nohup` instead)

Commonly used commands:

1. List screens open: `screen -list` 
2. open a new screen: `screen`
3. re-open a screen: `screen -r (session name)`
4. exiting screen: `Control-A D`
5. Killing a screen: `screen -XS (session name) quit`

reference: http://www.pixelbeat.org/lkdb/screen.html



# Question from Fellow Students (Feb, 2019 & April, 2019)

**Q: How to check if someone else is using server:**

Log into server and type `top` 

**Q: How do you keep something running when I log out?**

`Screen`  (see above)

**Q: How do you transfer files?**

I use Cyberduck (Mac) - but you can use `scp` as well


**Q: how do I open text files on the server?**

It sucks, but you can use `vim`


**Q: how do I run an R file on the server?**

`Rscript filename.R (parameters after)`


*To use parameters, in your `R` file you'll want to do something like the following in your code:*
```{r}
args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 0) {
  first_parameter <- args[1]
  second_parameter <- args[2]
  ...
}
```
*and run the code `Rscript filename.R first_parameter second_parameter ...` 

OR

`R CMD BATCH filename.R`

**Q: What servers can I use?**

see http://stat.cmu.edu/computing/computation

**Q: How do I get the server specs?**

Below is a quotation from Carl:

>  For linux, you can often find most of the information you need in the /proc directory.  For any particular server, you can run:
>
> cat /proc/meminfo
>
> cat /proc/cpuinfo

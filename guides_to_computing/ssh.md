# Using Screen on the Server

Commonly used commands:

1. List screens open: `screen -list` 
2. open a new screen: `screen`
3. re-open a screen: `screen -r (session name)`
4. exiting screen: `Control-A D`
5. Killing a screen: `screen -XS (session name) quit`
6. Kill all screens: `screen -X quit`

reference: http://www.pixelbeat.org/lkdb/screen.html



# Question from Lovely Fourth Year (Feb, 2019)

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

OR

`R CMD BATCH filename.R`

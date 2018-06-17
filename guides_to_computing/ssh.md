# Using Screen on the Server

Commonly used commands:

1. List screens open: `screen -list` 
2. open a new screen: `screen`
3. re-open a screen: `screen -r (session name)`
4. exiting screen: `Control-A C`
5. Killing a screen: `screen -X -S (session name) quit`
6. Kill all screens: `screen -X quit`

reference: http://www.pixelbeat.org/lkdb/screen.html
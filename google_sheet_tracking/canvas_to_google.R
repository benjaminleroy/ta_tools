# This script grabs desired information from canvas grades files and provide a 
# new csv with students' Last Name, First Name, and Andrew ID. There are 3 
# locations in this file that you should change (one is a boolean depending upon
# how Canvas is currently giving the name). 
#
# Created by Ben LeRoy, Updated 30 March 2018

library(tidyverse)
student_info <- read.csv("~/Desktop/2018-03-30T1634_Grades-46927.csv") 
## ^CHANGE ME ^##


head(student_info)

## check ------------
# See if the table looks something like:
#
# Student          | ID | SIS.Login.ID | Section | Homework.1..73412. | ...
#                  | NA |              |         |              Muted | ...
# Points Possible  | NA |              |         |               60.0 | ...
# Benjamin LeRoy   |  2 | bpleroy@.edu |   46927 |               61.0 | ...
# ...
#
# note: sometimes they switch between "Last, First" and "First Last".

last_first_order_bool = FALSE
## ^CHANGE ME if name is in the "Last, First" setup^##

student_info <- student_info[-c(1:2),]



student <- student_info %>% select(Student, SIS.Login.ID) %>%
  mutate(Student = as.character(Student),
         SIS.Login.ID = as.character(SIS.Login.ID))

if (last_first_order_bool) {#"Last, First"
student2 <- student %>% mutate(
         Last = 
           sapply(student$Student, 
                  function(x) strsplit(split = ", ", x)[[1]][1]),
         First =  
           sapply(student$Student, 
                  function(x) strsplit(split = ", ", x)[[1]][2]),
         Andrew_ID = 
           sapply(student$SIS.Login.ID, 
                  function(x) strsplit(split = "@", x)[[1]][1])
         )
} else {#"First Last"
  student2 <- student %>% mutate(
    Last = 
      sapply(student$Student, 
             function(x) {
               inner_step = strsplit(split = " ", x)[[1]]
               return(inner_step[length(inner_step)])
               }),
    First =  
      sapply(student$Student, 
             function(x) strsplit(split = " ", x)[[1]][1]),
    Andrew_ID = 
      sapply(student$SIS.Login.ID, 
             function(x) strsplit(split = "@", x)[[1]][1])
  )
}


data_out = student2[,c("Last","First","Andrew_ID")]
write.csv(data_out, file = "~/Desktop/cleaned_people.csv")
## ^CHANGE ME^ ##



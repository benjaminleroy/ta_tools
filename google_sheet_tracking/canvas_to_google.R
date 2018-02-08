library(tidyverse)
student_info<- read.csv("~/Downloads/23_Jan_17_56_Grades-46926.csv")


head(student_info)

student <- student_info %>% select(Student, SIS.Login.ID) %>%
  mutate(Student = as.character(Student),
         SIS.Login.ID = as.character(SIS.Login.ID))

student2 <- student %>% mutate(
         Last = 
           sapply(student$Student, 
                  function(x) strsplit(split = ", ",x)[[1]][1]),
         First =  
           sapply(student$Student, 
                  function(x) strsplit(split = ", ",x)[[1]][2]),
         Andrew_ID = 
           sapply(student$SIS.Login.ID, 
                  function(x) strsplit(split = "@",x)[[1]][1]),
         )


data_out = student2[,c("First","Last","Andrew_ID")]
write.csv(data_out,file = "~/Desktop/cleaned_people.csv")



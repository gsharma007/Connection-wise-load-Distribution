rawdata<- read.csv("1_5datascanbreak.csv",stringsAsFactors = FALSE)
newdata <- rawdata[ which(rawdata$mot=='E'), ]
newdata2<-subset(newdata,!is.na(newdata$cid))
df <- newdata2[ with(newdata2, order(newdata2$pid)), ]

library(stringr)
new_df = df[nchar(str_sub(df$pid))>5,]
new_df$scan_date<- substr(new_df$sd,start=14,stop=23)
new_df$scan_time<- substr(new_df$sd,start=25,stop=32)
new_df$scan_date <- as.Date(new_df$scan_date,"%Y-%m-%d")

library(dplyr)
aggregated_data <- new_df %>% select(wbn,sl,dest,scan_date) %>% group_by(scan_date,sl,dest) %>% summarise(num_packages = length(wbn))

write.csv(aggregated_data,file="Loads_data.csv")

library(readxl)
air_france <- read_excel("C:\\Users\\Tommaso\\Desktop\\Hult documents\\Introduction to R\\Excel datasets\\Air France Case Spreadsheet Supplement.xlsx",
                         sheet = 2)

library(dplyr)
## Click Charges based on keywords ##########################################
top_n(air_france, n=10, `Click Charges`) %>%
  ggplot(., aes(x=`Click Charges`, y=Keyword))+
  geom_bar(stat='identity') 

# Unite air france and [air france] from the original dataset. They mean the same thing
# Useful to put bar charts in ascending order with x = reorder

## Booking over keyworkds 
top_n(air_france, n=10, `Total Volume of Bookings`) %>%
  ggplot(., aes(x=Keyword, y=`Total Volume of Bookings`))+
  geom_bar(stat='identity')+ coord_flip()  

# I suggest to put x = category

##  ROA on top 12 Keywords  ######################################

library(ggplot2)
theme_set(theme_bw())
air_france %>% 
  top_n(12, ROA) %>% 
  ggplot( aes(x=Keyword, y=ROA)) + 
  geom_bar(stat="identity", width=.5, fill="tomato3") + coord_flip()  
labs(title="ROA On Keywords", 
     subtitle="Top 12 Keywords on ROA", 
     caption="source: mpg") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))
### Number of bookings based on the Publisher Names using Diverging Dot Plot #####


library(ggplot2)
theme_set(theme_bw())

ggplot(air_france, aes(x=`Publisher Name`, y=Clicks, label=Clicks)) + 
  geom_point(stat='identity', fill="black", size=18)  +
  geom_segment(aes(y = 0, 
                   x = `Publisher Name`, 
                   yend = Clicks, 
                   xend = `Publisher Name`), 
               color = "black") +
  geom_text(color="white", size=4) +
  labs(title="Majority  Clicks by Publisher", 
       subtitle="Google-Global,Overture-US,Google-US") + 
  ylim( 15000,34013) +
  coord_flip() 


# If possible try to look the documentation to put color into the charts. 
# Useful a line chart for Avg. Cost per Click and a bar chart for the Category.
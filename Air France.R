# Importing dataset
library(readxl)

# Publisher ID as chr, but contains numbers
# Keyworkd ID as chr, but is made of numbers
# Bid Strategy as chr, but contains numbers 

# opening dataset
air_france <- read_excel("C:\\Users\\Tommaso\\Desktop\\Hult documents\\Introduction to R\\Excel datasets\\Air France Case Spreadsheet Supplement.xlsx",
                         sheet = 2)
# General info on dataset
summary(air_france)

# MODIFYING DATA

# Checking unique values for every variable
library(dplyr)
# Storing unique values in matrix
unique_values <- matrix(sapply(air_france, n_distinct), nrow = 1, ncol = 23)
# name of columns in matrix
colnames(unique_values) <- c("Publisher ID", "Publisher Name", "Keyword ID", "Keyword", "Match Type", "Campaign", "Keyword Group",
                             "Category", "Bid Strategy", "Keyword Type", "Status", "Search Engine Bid", "Clicks", "Click Charges", 
                             "Avg. Cost per Click", "Impressions", "Engine Click Thru %", "Avg. Pos.", "Trans. Conv. %", "Total Cost/ Trans.",
                             "Amount", "Total Cost", "Total Volume of Bookings")

# Rounding continuous variables 
air_france$`Avg. Cost per Click` <- round(air_france$`Avg. Cost per Click`, digits = 3)
air_france$`Engine Click Thru %` <- round(air_france$`Engine Click Thru %`, digits = 3)
air_france$`Avg. Pos.` <- round(air_france$`Avg. Pos.`, digits = 3)
air_france$`Trans. Conv. %` <- round(air_france$`Trans. Conv. %`, digits = 3)
air_france$`Total Cost/ Trans.` <- round(air_france$`Total Cost/ Trans.`, digits = 3)

# Subsetting data frame without Publisher ID, Keyword Type (too many unique values)
air_france_red <- air_france[,-c(1,10)] 

# Checking missing values
missing_values <- colSums(is.na(air_france_red))

# Visualization distribution missing values
library(ggplot2)
library(naniar)
gg_miss_var(air_france_red) # visualization distribution missing values

# Categories in Bid Strategy (only one with missing values) 
table(air_france_red$`Bid Strategy`)

# Fixing typos in Bid Strategy
for (i in 1:nrow(air_france_red)) {
  if (is.na(air_france_red$`Bid Strategy`[i])) {
    air_france_red$`Bid Strategy`[i] == FALSE
  }
  else if (air_france_red$`Bid Strategy`[i] == "Position 1 -2 Target") {
    air_france_red$`Bid Strategy`[i] <- "Position 1-2 Target"
  }
  else if
    (air_france_red$`Bid Strategy`[i] == "Postiion 1-4 Bid Strategy") {
      air_france_red$`Bid Strategy`[i] <- "Position 1-4 Bid Strategy"
    }
}#closing i loop

# checking result for loop
table(air_france_red$`Bid Strategy`) 

# conversion bid strategy in numeric
# Subsetting for bid strategy
bid_strategy <- subset(air_france_red, select = "Bid Strategy", drop = FALSE)
# coverting in numeric values with gsub
bid_strategy$`Bid Strategy` <- gsub("Position 1-2 Target", "1", bid_strategy$`Bid Strategy`)         # 1-2 = 1
bid_strategy$`Bid Strategy` <- gsub("Position 1- 3", "2", bid_strategy$`Bid Strategy`)               # 1-3 = 2
bid_strategy$`Bid Strategy` <- gsub("Position 1-4 Bid Strategy", "3", bid_strategy$`Bid Strategy`)   # 1-4 = 3
bid_strategy$`Bid Strategy` <- gsub("Pos 3-6", "4", bid_strategy$`Bid Strategy`)                     # 3-6 = 4
bid_strategy$`Bid Strategy` <- gsub("Position 2-5 Bid Strategy", "5", bid_strategy$`Bid Strategy`)   # 2-5 = 5
bid_strategy$`Bid Strategy` <- gsub("Position 5-10 Bid Strategy", "6", bid_strategy$`Bid Strategy`)  # 5-10 = 6

# conversion Bid Strategy in numeric
bid_strategy$`Bid Strategy` <- as.numeric(bid_strategy$`Bid Strategy`)
table(bid_strategy$`Bid Strategy`)

# eliminating initial bid strategy, Keyword, Keyword Group from air_france_red
air_france_red <- air_france_red[,-c(3,6,8)]
# adding bid strategy fixed
air_france_red <- cbind(air_france_red, bid_strategy)
# eliminating bid strategy data frame
bid_strategy <- NULL

# listing different values in Category
table(air_france_red$Category)

# list of us cities in Category
us_cities <- list("boston", "chicago", "houston", "losangeles", "miami", "newyork")
# list of sites consulted by customers
airfare <- list("airfare", "airfaregeneral", "airgeneral", "airline", "airlinegeneral", "discount", "discountairfare", "discountgeneral",
                "flight", "flightgeneral", "fly", "franceairports", "internationalflight", "internationalgeneral")

# Modifying Category in numeric
for (i in 1:nrow(air_france_red)){
  if (air_france_red$Category[i] == "uncategorized")
    air_france_red$Category[i] <- "0"                                           # 0 = uncategorized
  else if (air_france_red$Category[i] == "airfrance")
    air_france_red$Category[i] <- "1"                                           # 1 = airfrance or airfrance website
  else if (air_france_red$Category[i] == "airfrancewebsite")
    air_france_red$Category[i] <- "1"
  else if (air_france_red$Category[i] == us_cities)
    air_france_red$Category[i] <- "2"                                           # 2 = cities of United States
  else if (air_france_red$Category[i] == airfare)
    air_france_red$Category[i] <- "3"                                           # 3 = airfare and researches to save 
  else
    air_france_red$Category[i] <- "4"                                           # 4 = cities of European market
}# closing loop

# converting Category in numeric
air_france_red$Category <- as.numeric(air_france_red$Category)
# checking result for loop
table(air_france_red$Category)

# Reducing Category to 0-1
air_france_red$Category_bin <- air_france_red$Category

for (i in 1:nrow(air_france_red)){
  if (air_france_red$Category_bin[i] == "1")
    air_france_red$Category_bin[i] <- "1"
  else
    air_france_red$Category_bin[i] <- "0"
}# closing i loop

# Reducing Publisher Name to 0-1
table(air_france_red$`Publisher Name`)

for (i in 1:nrow(air_france_red)){
  if (air_france_red$`Publisher Name`[i] == "Google - Global" | air_france_red$`Publisher Name`[i] == "Overture - Global" |
      air_france_red$`Publisher Name`[i] == "MSN - Global")
    air_france_red$`Publisher Name`[i] <- "0"
  else if (air_france_red$`Publisher Name`[i] == "Google - US" | air_france_red$`Publisher Name`[i] == "MSN - US" |
           air_france_red$`Publisher Name`[i] == "Overture - US" | air_france_red$`Publisher Name`[i] == "Yahoo - US")
    air_france_red$`Publisher Name`[i] <- "1"
}# closing loop

table(air_france_red$`Publisher Name`) 

# Converting Category_bin and Publisher Name to numeric
air_france_red$Category_bin <- as.numeric(air_france_red$Category_bin)
air_france_red$`Publisher Name` <- as.numeric(air_france_red$`Publisher Name`)

# Imputing 1224 missing values in Bid Strategy --- > PCA?
# numeric_variables <- as.data.frame(air_france_red[,-c(1,2,3,4,6,19)])

numeric_variables <- as.data.frame(air_france_red[,-c(2,3,4,6,19)]) 

normalize <- function(x){
  rescale <- (x - min(x)) / (max(x) - min(x))
  return(rescale)
}

# Clicks, click charges, amount, total cost, avg. cost per click
numeric_variables.cor <- (cor(numeric_variables))
numeric_variables.cor <- round(numeric_variables.cor, digits = 3)
heatmap(numeric_variables.cor) 

# Normalization Avg. Cost per Click
air_france_red$avg_cost_norm <- normalize(air_france_red$`Avg. Cost per Click`)

# Performing Linear Regression: is there a group of keyword more profitable?
air_france_data <- sample(1:nrow(air_france_red), size = 0.8*nrow(air_france_red))

air_france_train <- air_france_red[air_france_data,] # training data
air_france_test <- air_france_red[-air_france_data,] # testing data

first_model <- lm(`Publisher Name` ~ Category, data = air_france_train)
first_model$coefficients
summary(first_model) 

# Performing Logistic Regression
publisher_log <- glm(`Publisher Name` ~ Category + `Avg. Cost per Click` + `Engine Click Thru %` + `Search Engine Bid`,
                     data = air_france_train,
                     family = "binomial")
publisher_log$coefficients
summary(publisher_log) 

exp(-1.222118)-1 # Category_bin
exp(0.279486)-1 # Avg. Cost per Click
exp(0.028990)-1 # Engine Clich Thru % 

pred_train_af <- predict(publisher_log, air_france_train, type = "response")
pred_train_af

pred_test_af <- predict(publisher_log, air_france_test, type = "response")
pred_test_af

prediction <- prediction(pred_test_af, air_france_test$`Publisher Name`)
library(ROCR)

performance_af <- performance(prediction, "tpr", "fpr")
plot(performance_af) 

# Second model
category_log <- glm(Category_bin ~ `Publisher Name` + `Avg. Cost per Click` + `Engine Click Thru %` + `Search Engine Bid` +
                       `Total Volume of Bookings`,
                     data = air_france_train,
                     family = "binomial")
summary(category_log)
exp(-1.132372)-1 # Publisher Name
exp(-2.929876)-1 # Avg. Cost per Click
exp(-0.019189)-1 # Engine Click Thru %
exp(-0.058749)-1 # Search Engine Bid
exp(0.010927)-1 # Total Volume of Bookings

pred_train_af2 <- predict(category_log, air_france_train, type = "response")
pred_train_af2

pred_test_af2 <- predict(category_log, air_france_test, type = "response")
pred_test_af2

prediction2 <- prediction(pred_test_af2, air_france_test$`Category_bin`) 

performance_af2 <- performance(prediction2, "tpr", "fpr")
plot(performance_af2) 


########################## CONCLUSIONS #############################

# According to findings in category_log, where Category_bin = y
# 1 - The value related to Publishers like Google, Yahoo, etc. is reduced when the customers buy directly from Air france.
# For every customers who buy tickets directly from Air France the value related to Search Engine is reduced by 67%
# 2 - If the customers buy directly from Air France, the odds for business success related to Average Cost per Click is reduced by 94%.
# This means that if Air France increases the number of customers who buy tickets from their own channels, the expense for every single
# research in the search engines is drammatically reduced.
# 3 - Differently from the previous results, the Engine Click Thru maintains stability in relation to the odds of business success.
# In fact, even if the company augments the amount of customers who decide to buy tickets without intermediates the value related to the \
# exposition in the search engines is reduced only by 1%.
# A similar thing happens when we consider the bidding strategy in the search engines. The odds of business success are reduced only by 5%.
# Finally: the total volume of bookings. This is the most interesting finding in the analysis. In fact, for every additional customer that
# Air France is able to attract to its channels, the odds for more bookings increase only by 1%. 
# What does this means? It means that in this moment Air France is stuck with a certain number of customers. Consequently, if the strategy
# changes, shifting from search engines to its own website, Air France will probably not increase the amount of customers. Probably, the 
# company will reduce some costs, especially those related to the clicks and the bid strategy, but it will remain bound to the fidelity of its
# customers. If the company wants to move from here, it has to maximize the more independence given by this new strategy to invest in new 
# solutions to increase the number of customers.
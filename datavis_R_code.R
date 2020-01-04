############  Corrosive corruption  ################

# A correlation between corruption and development

# CPI - Transparency International's annual 'Corruption Perceptions Index''
# HDI - UN's 'Human Development Index'

 
# Comparing the corruption index with the UN's Human Development Index 
# i.e. A measure combining health, wealth and education
# It demonstrates an interesting connection.

# Norway, New Zealand, Singapore are the Least Corrupt Countries.
# Congo and Afghanistan are the most Corrupt Countries.

# Sub-Saharan Africa Region i.e. the African Countries majorly falls under the most Corrupt Countries Hood,...
# ...with Poor Human Development Index.
# Western Europe Region (EU W. EUROPE) have most of the countries with better correlation...
# ...between corruption and development, than the other Regions. (i.e better than others)


# Setting the working directory
setwd("C:/Users/DELL/Desktop/R_projects/data")

# Importing the ggplot2, data.table libraries and using fread to load the csv file into a dataframe. 

library(ggplot2)
library(data.table)

df <- fread("Economist_Assignment_Data.csv", drop=1)

head(df)

# Creating a scatter plot object, where x=CPI and y=HDI and color=Region as aesthetics.

plot.1 <- ggplot(df,aes(x= CPI, y= HDI, color= Region)) + geom_point()
plot.1

# Changing the points to be larger empty circles by  by adding shape and size arguments to geom_point().

plot.2 <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point(size=4,shape=1)
plot.2

# Adding geom_smooth(), to add a 'Trend line' i.e. geom_smooth(aes(group=1))

plot.3 <- plot.1 + geom_smooth(aes(group=1))
plot.3

# further editting this trend line.
# Adding the following arguments to geom_smooth (outside of aes):
# method = 'lm'
# formula = y ~ log(x)
# se = FALSE
# color = 'red'  

plot.4 <- plot.1 + geom_smooth(aes(group=1),method ='lm',formula = y~log(x),se=FALSE,color='red')
plot.4

# Adding labels, using geom_text() i.e. Add geom_text(aes(label=Country)) to plot.4

plot.5 <- plot.4 + geom_text(aes(label=Country))
plot.5

# Labeling a subset of countries and
# it would require manually selecting the subset of countries we want to label
# pointsToLabel - conatins the vector of countries that we want to label in the plot
# subsetting is done using data argumement within the aesthetics.
# i.e.  data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

plot.6 <- plot.4 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
plot.6

# Adding a theme to the plot, i.e theme_bw()

plot.7 <- plot.6 + theme_bw() 
plot.7

# Adding the default scale for continuous x, using scale_x_continuous().
# and set the following arguments:
# name =	The name of the scale.Used as the axis or legend title i.e. Same x axis as the Economist Plot
# limits = Pass a numeric vector of appropriate x limits
# breaks = 1:10

plot.8 <- plot.7 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                                limits = c(.9, 10.5),breaks=1:10) 
plot.8

# Adding the default scale for continuous y, using scale_y_continuous() to do similar operations to the y axis.

plot.9 <- plot.8 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                                limits = c(0.2, 1.0))
plot.9

# Using ggtitle() to add a string as a title. i.e. "Corruption and Human development"
plot.10 <- plot.9 + ggtitle("Corruption and Human development")
plot.10

#Using ggthemes: Styling plots similar to those in The Economist using theme_economist_white().
  
library(ggthemes)
plot.final <- plot.10 + theme_economist_white()
plot.final


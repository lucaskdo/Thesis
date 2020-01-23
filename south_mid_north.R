#install and set up necessary packages

install.packages("tidyverse")
install.packages("janitor")

library(tidyverse)
library(janitor)

#read in input file

ifile <- read.csv(file = "data/south_mid_north.csv", header = TRUE)

#choose scenario/normal to analyze, format data frame

scen <- "soy_4570"
yr <- c(2070:2099)

df <- data.frame(year = yr,
                 South = ifile[, paste(scen, "_south", sep = "")],
                 Mid = ifile[, paste(scen, "_mid", sep = "")],
                 North = ifile[, paste(scen, "_north", sep = "")])

df_long <- df %>%
  gather(Region, yield, -year)

df2 <- arrange(transform(df_long, Region=factor(Region,levels= c("South", "Mid", "North"))),Region)

#make a line graph comparing avg yield for each band in a crop/scenario combo
#can also add subtitle and caption in labs

ggplot(data = df2, aes(x = year, y = yield, color = Region)) +
  geom_line() +
  labs(title="Annual soybean yield by latitude band (2070-2099, RCP4.5)", y="Yield (Kg/Ha)", x="Year") +
  theme_classic() + 
  theme(plot.title = element_text(hjust = 0.5))

ggsave(paste("output/figures/lat_band_yield/latbands_", scen, ".png"), width = 8, height = 5)
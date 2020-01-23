#install and set up necessary packages

install.packages("tidyverse")
install.packages("janitor")

library(tidyverse)
library(janitor)


#import all data sets for mid (yield projections for each climate model)
#has to be run manually for each crop/scenario/normal combination (10 total)

yr <- c(2070:2099)

for (i in 1:5){
  
  mod <- switch(i, "gfdl", "hadgem", "ipsl", "miroc", "noresm")
  
  ifile <- paste("data/", mod, "/", mod, "_maize_mid_rcp85_2070-2099.dat", sep = "")
  
  t <- read.table(text = gsub("[\t]+", "\t", readLines(ifile), perl = TRUE),
                  sep="\t", header = TRUE, fill = TRUE) %>%
    clean_names() %>%
    filter(year >= yr[1]) %>%
    filter(year <= yr[30])
  
  
#subset all data sets to years and grid cells
  
t_subset_1 <- t %>%
  filter(lat == 39.25) %>%
  filter(lon == -90.25)

t_subset_2 <- t %>%
  filter(lat == 39.25) %>%
  filter(lon == -89.75)

t_subset_3 <- t %>%
  filter(lat == 39.25) %>%
  filter(lon == -89.25)

t_subset_4 <- t %>%
  filter(lat == 39.25) %>%
  filter(lon == -88.75)

t_subset_5 <- t %>%
  filter(lat == 39.25) %>%
  filter(lon == -88.25)

t_subset_6 <- t %>%
  filter(lat == 39.25) %>%
  filter(lon == -87.75)

t_subset_7 <- t %>%
  filter(lat == 39.75) %>%
  filter(lon == -91.25)

t_subset_8 <- t %>%
  filter(lat == 39.75) %>%
  filter(lon == -90.75)

t_subset_9 <- t %>%
  filter(lat == 39.75) %>%
  filter(lon == -90.25)

t_subset_10 <- t %>%
  filter(lat == 39.75) %>%
  filter(lon == -89.75)

t_subset_11 <- t %>%
  filter(lat == 39.75) %>%
  filter(lon == -89.25)

t_subset_12 <- t %>%
  filter(lat == 39.75) %>%
  filter(lon == -88.75)

t_subset_13 <- t %>%
  filter(lat == 39.75) %>%
  filter(lon == -88.25)

t_subset_14 <- t %>%
  filter(lat == 39.75) %>%
  filter(lon == -87.75)

t_subset_15 <- t %>%
  filter(lat == 40.25) %>%
  filter(lon == -91.25)

t_subset_16 <- t %>%
  filter(lat == 40.25) %>%
  filter(lon == -90.75)

t_subset_17 <- t %>%
  filter(lat == 40.25) %>%
  filter(lon == -90.25)

t_subset_18 <- t %>%
  filter(lat == 40.25) %>%
  filter(lon == -89.75)

t_subset_19 <- t %>%
  filter(lat == 40.25) %>%
  filter(lon == -89.25)

t_subset_20 <- t %>%
  filter(lat == 40.25) %>%
  filter(lon == -88.75)

t_subset_21 <- t %>%
  filter(lat == 40.25) %>%
  filter(lon == -88.25)

t_subset_22 <- t %>%
  filter(lat == 40.25) %>%
  filter(lon == -87.75)

t_subset_23 <- t %>%
  filter(lat == 40.75) %>%
  filter(lon == -90.75)

t_subset_24 <- t %>%
  filter(lat == 40.75) %>%
  filter(lon == -90.25)

t_subset_25 <- t %>%
  filter(lat == 40.75) %>%
  filter(lon == -89.75)

t_subset_26 <- t %>%
  filter(lat == 40.75) %>%
  filter(lon == -89.25)

t_subset_27 <- t %>%
  filter(lat == 40.75) %>%
  filter(lon == -88.75)

t_subset_28 <- t %>%
  filter(lat == 40.75) %>%
  filter(lon == -88.25)

t_subset_29 <- t %>%
  filter(lat == 40.75) %>%
  filter(lon == -87.75)

t_subset_whole <- bind_rows(t_subset_1,
                            t_subset_2,
                            t_subset_3,
                            t_subset_4,
                            t_subset_5,
                            t_subset_6,
                            t_subset_7,
                            t_subset_8,
                            t_subset_9,
                            t_subset_10,
                            t_subset_11,
                            t_subset_12,
                            t_subset_13,
                            t_subset_14,
                            t_subset_15,
                            t_subset_16,
                            t_subset_17,
                            t_subset_18,
                            t_subset_19,
                            t_subset_20,
                            t_subset_21,
                            t_subset_22,
                            t_subset_23,
                            t_subset_24,
                            t_subset_25,
                            t_subset_26,
                            t_subset_27,
                            t_subset_28,
                            t_subset_29)

#extract mean yearly wso (yield) value for each data set

out <- t_subset_whole %>%
  select(year, wso) %>%
  group_by(year) %>%
  summarize(mod = mean(wso)) %>%
  mutate(region = "mid")

ofile <- paste("output/", mod, "/", mod, "_m_m_85_70.csv", sep = "")

write.csv(out, file = ofile)

}
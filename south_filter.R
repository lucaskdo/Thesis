#install and set up necessary packages

install.packages("tidyverse")
install.packages("janitor")

library(tidyverse)
library(janitor)


#import all data sets for south (yield projections for each climate model)
#has to be run manually for each crop/scenario/normal combination (10 total)

yr <- c(1970:1999)

for (i in 1:5){

  mod <- switch(i, "gfdl", "hadgem", "ipsl", "miroc", "noresm")
  
  ifile <- paste("data/", mod, "/", mod, "_maize_south_hist_1970-1999.dat", sep = "")

  t <- read.table(text = gsub("[\t]+", "\t", readLines(ifile), perl = TRUE),
                  sep="\t", header = TRUE, fill = TRUE) %>%
    clean_names() %>%
    filter(year >= yr[1]) %>%
    filter(year <= yr[30])
  
  
#subset all data sets to years and grid cells

t_subset_1 <- t %>%
  filter(lat == 37.25) %>%
  filter(lon == -89.25)

t_subset_2 <- t %>%
  filter(lat == 37.25) %>%
  filter(lon == -88.75)

t_subset_3 <- t %>%
  filter(lat == 37.75) %>%
  filter(lon == -89.25)

t_subset_4 <- t %>%
  filter(lat == 37.75) %>%
  filter(lon == -88.75)

t_subset_5 <- t %>%
  filter(lat == 37.75) %>%
  filter(lon == -88.25)

t_subset_6 <- t %>%
  filter(lat == 38.25) %>%
  filter(lon == -90.25)

t_subset_7 <- t %>%
  filter(lat == 38.25) %>%
  filter(lon == -89.75)

t_subset_8 <- t %>%
  filter(lat == 38.25) %>%
  filter(lon == -89.25)

t_subset_9 <- t %>%
  filter(lat == 38.25) %>%
  filter(lon == -88.75) %>%
  mutate(coord = "i")

t_subset_10 <- t %>%
  filter(lat == 38.25) %>%
  filter(lon == -88.25)

t_subset_11 <- t %>%
  filter(lat == 38.75) %>%
  filter(lon == -89.75)

t_subset_12 <- t %>%
  filter(lat == 38.75) %>%
  filter(lon == -89.25)

t_subset_13 <- t %>%
  filter(lat == 38.75) %>%
  filter(lon == -88.75)

t_subset_14 <- t %>%
  filter(lat == 38.75) %>%
  filter(lon == -88.25)

t_subset_15 <- t %>%
  filter(lat == 38.75) %>%
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
          t_subset_15)


#extract mean yearly wso (yield) value for each data set

out <- t_subset_whole %>%
  select(year, wso) %>%
  group_by(year) %>%
  summarize(yield = mean(wso)) %>%
  mutate(region = "south")

ofile <- paste("output/", mod, "/", mod, "_m_s_h.csv", sep = "")

write.csv(out, file = ofile)

}
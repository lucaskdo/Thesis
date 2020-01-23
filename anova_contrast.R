#install and set up necessary packages

install.packages("tidyverse")
install.packages("janitor")

library(tidyverse)
library(janitor)


#read in input file

ifile <- read.csv(file = "data/soy_anova.csv", header = TRUE)

t4520 <- ifile %>%
  filter(SCENARIO != "rcp8.5", NORMAL != "2070-2099")

t8520 <- ifile %>%
  filter(SCENARIO != "rcp4.5", NORMAL != "2070-2099")

t4570 <- ifile %>%
  filter(SCENARIO != "rcp8.5", NORMAL != "2020-2049")

t8570 <- ifile %>%
  filter(SCENARIO != "rcp4.5", NORMAL != "2020-2049")


#v1 = aov(YIELD ~ NORMAL*SCENARIO, data = ifile)
#v2 = anova(lm(YIELD ~ NORMAL*SCENARIO, data = ifile))

soy_a1 <- anova(lm(YIELD ~ NORMAL*SCENARIO, data = ifile))
#output tables from ANOVAs saved as .pngs

t.test(YIELD~SCENARIO,data=t4520)
#output metric from contrast tests saved in spreadsheet

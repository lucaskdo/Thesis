#install and set up necessary packages

install.packages("tidyverse")
install.packages("janitor")

library(tidyverse)
library(janitor)

#read in input file

ifile <- read.csv(file = "data/scenario_comp.csv", header = TRUE)

#choose crop to analyze

df <- arrange(transform(ifile, Normal=factor(Normal,levels= c("Hist", "2020-2049", "2070-2099"))),Normal) %>%
  filter(Crop == "Maize")
df2 <- arrange(transform(df, Band=factor(Band,levels= c("South", "Mid", "North"))),Band)

#make a boxplot graph comparing avg yield for each band/scenario, facets comparing normals
#can also add subtitle and caption in labs

ggplot(data = df2, aes(x = Scenario, y = Yield, color = Band)) +
  geom_boxplot() +
  facet_grid(cols = vars(Normal), scales = "free", space = "free_x") +
  labs(title="Maize yield by scenario and time period",
       subtitle = "Time period",
       y="Yield (Kg/Ha)",
       x="Scenario") +
  theme_classic() + 
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggsave(paste("output/figures/scen_comp_yield/maize_scenarios.png"), width = 8, height = 5)
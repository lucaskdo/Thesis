install.packages("tidyverse")
install.packages("janitor")

library(tidyverse)
library(janitor)

#read in input file

ifile <- read.csv(file = "data/gcm_comp.csv", header = TRUE)
ifile <- arrange(transform(ifile, Model=factor(Model,levels= c("GFDL-ESM2M", 
                                                               "HadGEM2-es", 
                                                               "IPSL-CM5A-LR",
                                                               "MIROC-ESM",
                                                               "NorESM-M",
                                                               "Mean"))),Model)

#choose crop to analyze

df <- ifile %>%
  filter(Crop == "Maize")

#make a line graph showing the hist yield for each GCM, with the ensemble ave added as a bold line
#can also add subtitle and caption in labs

ggplot(data = df, aes(x = Year, y = Yield, color = Model, size = Model)) +
  geom_line() +
  scale_color_manual(values=c("red2", "springgreen3", "gold2", "deepskyblue1", "violetred3", "black"))+
  scale_size_manual(values=c(0.5, 0.5, 0.5, 0.5, 0.5, 2)) +
  labs(title="Average maize yield by GCM with ensemble mean (1970-1999)",
       y="Yield (Kg/Ha)",
       x="Year") +
  theme_classic() + 
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggsave(paste("output/figures/gcm_comp/maize_gcm_comp.png"), width = 8, height = 5)
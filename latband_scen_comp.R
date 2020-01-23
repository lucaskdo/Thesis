#install and set up necessary packages

install.packages("tidyverse")
install.packages("janitor")

library(tidyverse)
library(janitor)

#read in input file

ifile <- read.csv(file = "data/latband_scen_comp.csv", header = TRUE)

#choose crop to analyze

df <- arrange(transform(ifile, Band=factor(Band,levels= c("South", "Mid", "North"))),Band) %>%
  filter(Crop == "Soybean")

df <- arrange(transform(df, Scenario=factor(Scenario,levels= c("Hist", 
                                                               "2020-2049 (RCP4.5)",
                                                               "2070-2099 (RCP4.5)",
                                                               "2020-2049 (RCP8.5)",
                                                               "2070-2099 (RCP8.5)"))),Scenario)

#make a bar graph comparing avg yield for each color-coded scenario faceted by band
#can also add subtitle and caption in labs

ggplot(data = df, aes(x = Scenario, y = Yield, fill = Scenario)) +
  geom_bar(stat = "identity") +
  facet_grid(cols = vars(Band)) +
  scale_fill_manual(values = c("forestgreen", "royalblue1", "royalblue4", "orangered1", "orangered4")) +
  labs(title="Change in soybean yield by latitude band",
       y="Yield (Kg/Ha)",
       x="Latitude band") +
  theme_classic() + 
  theme(plot.title = element_text(hjust = 0.5), 
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

ggsave(paste("output/figures/latband_scen_comp/soybean_latband_comp.png"), width = 8, height = 5)
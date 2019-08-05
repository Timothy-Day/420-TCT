library(dplyr)
library(plotly)
library(tidyverse)
library(shinythemes)
# Pre-processing ####
df.000 <- read.csv('/Users/dayti/NYCDSA/Projects/C-ChemComp/Terpene-Profile-Parser-for-Cannabis-Strains-master/results.csv')

df.001 <-
  df.000 %>%
  group_by(., Sample.Name) %>%
  summarise_if(., is.numeric, mean, na.rm = TRUE) %>%
  .[rowSums(is.na(.)) != (ncol(.)-3), ] %>%
  select(.,-Provider,-Moisture.Content) %>%
  subset(., Sample.Name != 'Nerolidol')

# Aggregate all like isomers.  Note to self:  Run this by Debbie.

df.001$Nerolidol <- rowSums(df.001[, c('cis.Nerolidol','trans.Nerolidol','trans.Nerolidol.1','trans.Nerolidol.2')], na.rm = TRUE) *
  ifelse(rowSums(is.na(df.001[, c('cis.Nerolidol','trans.Nerolidol','trans.Nerolidol.1','trans.Nerolidol.2')])) == ncol(df.001[, c('cis.Nerolidol','trans.Nerolidol','trans.Nerolidol.1','trans.Nerolidol.2')]), NA, 1)

df.001$Caryophyllene <- rowSums(df.001[, c('Caryophyllene.Oxide','beta.Caryophyllene')], na.rm = TRUE) *
  ifelse(rowSums(is.na(df.001[, c('Caryophyllene.Oxide','beta.Caryophyllene')])) == ncol(df.001[, c('Caryophyllene.Oxide','beta.Caryophyllene')]), NA, 1)

df.001$CBG <- rowSums(df.001[,c('delta.9.CBG.A','delta.9.CBG')], na.rm = TRUE) *
  ifelse(rowSums(is.na(df.001[, c('delta.9.CBG.A','delta.9.CBG')])) == ncol(df.001[, c('delta.9.CBG.A','delta.9.CBG')]), NA, 1)

df.001$CBD <- rowSums(df.001[,c('CBD.A','CBD','CBDV','CBDV.A')], na.rm = TRUE) *
  ifelse(rowSums(is.na(df.001[, c('CBD.A','CBD','CBDV','CBDV.A')])) == ncol(df.001[, c('CBD.A','CBD','CBDV','CBDV.A')]), NA, 1)

df.001$Terpinolene <- rowSums(df.001[,c('Terpinolene','alpha.Terpinene','gamma.Terpinene')], na.rm = TRUE) *
  ifelse(rowSums(is.na(df.001[, c('Terpinolene','alpha.Terpinene','gamma.Terpinene')])) == ncol(df.001[, c('Terpinolene','alpha.Terpinene','gamma.Terpinene')]), NA, 1)


df.001$Ocimene <- rowSums(df.001[,c('trans.Ocimene','beta.Ocimene','Ocimene')], na.rm = TRUE) *
  ifelse(rowSums(is.na(df.001[, c('trans.Ocimene','beta.Ocimene','Ocimene')])) == ncol(df.001[, c('trans.Ocimene','beta.Ocimene','Ocimene')]), NA, 1)

df.001$Pinene <- rowSums(df.001[,c('alpha.Pinene','beta.Pinene')], na.rm = TRUE) *
  ifelse(rowSums(is.na(df.001[, c('alpha.Pinene','beta.Pinene')])) == ncol(df.001[, c('alpha.Pinene','beta.Pinene')]), NA, 1)

df.001$THC <- rowSums(df.001[,c('delta.9.THC.A','delta.9.THC','delta.8.THC','THC.A','THCV')], na.rm =
                        TRUE) *
  ifelse(rowSums(is.na(df.001[, c('delta.9.THC.A','delta.9.THC','delta.8.THC','THC.A','THCV')])) == ncol(df.001[, c('delta.9.THC.A','delta.9.THC','delta.8.THC','THC.A','THCV')]), NA, 1)



df.001$Cymene = df.001$p.Cymene 
df.001$Humulene=df.001$alpha.Humulene
df.001$Limonene=df.001$delta.Limonene
df.001$Myrcene=df.001$beta.Myrcene
df.001$Bisabolo=df.001$alpha.Bisabolol
df.001$Carene=df.001$X3.Carene


df.001 = 
  df.001 %>%
  select(.,-cis.Nerolidol,-trans.Nerolidol,-trans.Nerolidol.1,-trans.Nerolidol.2,
         -Caryophyllene.Oxide,-beta.Caryophyllene,
         -delta.9.CBG.A,-delta.9.CBG,
         -CBD.A,-CBDV,-CBDV.A,
         -alpha.Terpinene,-gamma.Terpinene,
         -trans.Ocimene,-beta.Ocimene,
         -alpha.Pinene,-beta.Pinene,
         -delta.9.THC.A,-delta.9.THC,-delta.8.THC,-THC.A,-THCV,
         -p.Cymene,
         -alpha.Humulene,
         -delta.Limonene,
         -beta.Myrcene,
         -alpha.Bisabolol,
         -X3.Carene)

df.001 <-
  df.001 %>% subset(., select=c("Sample.Name",
                                "THC",
                                "CBC",
                                "CBD",
                                "CBG",
                                "CBN",
                                "Bisabolo",
                                "Camphene",
                                "Carene",
                                "Caryophyllene",
                                "Cymene",
                                "Eucalyptol",
                                "Geraniol",
                                "Guaiol",
                                "Humulene",
                                "Isopulegol",
                                "Limonene",
                                "Linalool",
                                "Myrcene",
                                "Nerolidol",
                                "Ocimene",
                                "Pinene",
                                "Terpinolene"))


cols = colnames(df.001[,2:23])
chems = df.001[, 2:23]  
turpenes = df.001[7:23]

#Sample Size Table ####

chems_obs <-
  chems %>%
  gather(.,Compound)%>%
  group_by(., Compound) %>%
  summarise_all(., funs(Observations = sum(!is.na(.)),
                        Mean = mean(!is.na(.)),
                        Median = median(.,na.rm=TRUE),
                        Std.Dev = sd(!is.na(.)))
  ) %>% 
  arrange(desc(Observations)) %>%
  mutate_if(is.numeric, round, digits = 4)



#Sample Size Plot ####

chems_obs$Compound <-
  factor(chems_obs$Compound, levels = unique(chems_obs$Compound)[order(chems_obs$Observations, decreasing = TRUE)])






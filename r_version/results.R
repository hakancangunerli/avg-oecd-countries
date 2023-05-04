---
title: "results"
output: html_document
date: "2023-05-04"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

install.packages("tidyverse")
library(tidyverse)

```

```{r}
# load datasets  # nolint

df_gdp <- read.csv("../datasets/gdppc.csv")
head(df_gdp)

df_happiness <- read.csv("../datasets/happiness.csv")
head(df_happiness)

df_hdi <- read.csv("../datasets/hdi.csv")
head(df_hdi)

df_population <- read.csv("../datasets/population.csv")
head(df_population)

df_landmass <- read.csv("../datasets/landmass.csv")
head(df_landmass)

df_qol <- read.csv("../datasets/qol_2021.csv")
head(df_qol)

```

```{r}

oecd_countries <- c("Austria", "Australia", "Belgium", "Canada", "Chile", "Colombia", "Costa Rica", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel", "Italy", "Japan", "Korea, Rep.", "Latvia", "Lithuania", "Luxembourg", "Mexico", "Netherlands", "New Zealand", "Norway", "Poland", "Portugal", "Slovak Republic", "Slovenia", "Spain", "Sweden", "Switzerland", "Turkey", "United Kingdom", "United States")

```

```{r}
# we actually only need three columns, countryname ,2019 and 2020 
df_gdp <- select(df_gdp,Country.Name, X2019, X2020)


# Filter the rows based on the given condition
df_gdp <- subset(df_gdp, Country.Name %in% oecd_countries)

df_gdp["Combined"] = (df_gdp$X2019 + df_gdp$X2020)/2


round(df_gdp["Combined"], 2)


df_gdp <- df_gdp %>% select(Country.Name, Combined)


df_gdp <- df_gdp %>% arrange(desc(Combined))


# find the middle of the list, we add one bc R is 1 indexed, while py is 0th 
df_gdp[(nrow(df_gdp) %/% 2) + 1,]
```

```{r}

# for happiness index, we actually have to add different names to our OECD, 

oecd_countries <- c(oecd_countries, "South Korea", "United States", "Slovakia")


# find the elements in df_happiness 

df_happiness <- subset(df_happiness, country %in% oecd_countries)


df_happiness["Combined"] <- df_happiness$happiness2020 + df_happiness$happiness2021

round(df_happiness["Combined"],2) 



df_happiness <- df_happiness %>% select(country, Combined)


df_happiness <- df_happiness %>% arrange(desc(Combined))

# find the middle of the list, we add one bc R is 1 indexed, while py is 0th 
df_happiness[(nrow(df_happiness) %/% 2) + 1,]
```

```{r}

df_landmass <- select(df_landmass,Country.Name, X2020)


# Filter the rows based on the given condition
df_landmass <- subset(df_landmass, Country.Name %in% oecd_countries)


round(df_landmass$X2020, 2)


df_landmass <- df_landmass %>% select(Country.Name, X2020)


df_landmass <- df_landmass %>% arrange(desc(X2020))

# find the middle of the list, we add one bc R is 1 indexed, while py is 0th 
df_landmass[(nrow(df_landmass) %/% 2) + 1,]

```

```{r}
oecd_countries <- c(oecd_countries, "Republic of Korea", "United States")


df_population <- subset(df_population, Location %in% oecd_countries)


# only get 2021, Constant Fertility for each country 


df_population <- subset(df_population, Time==2021)

df_population <- subset(df_population, Variant=="Constant fertility")


df_population <- df_population %>% arrange(desc(PopTotal))

df_population$PopTotal <- as.integer(df_population$PopTotal)

# bc we have a perfectly divisible row # here, we just take the % 2 
df_population[(nrow(df_population) %/% 2),]
```

```{r}

# qol data
# only LIFE_SATISFACTION
df_qol <- df_qol[, c('Country', 'Indicator', 'Value', 'Inequality')]

oecd_countries <- c(oecd_countries, 'Korea')

df_qol <- df_qol[df_qol$Indicator == 'Life satisfaction', ]
df_qol <- df_qol[df_qol$Inequality == 'Total', ]

df_qol <- df_qol[order(-df_qol$Value), ]

df_qol <- df_qol[df_qol$Country %in% oecd_countries, ]

# TODO costa rica unfortunately does not exist in the dataset
df_qol_average <- df_qol[ceiling(nrow(df_qol) / 2), ]

df_qol_average
```

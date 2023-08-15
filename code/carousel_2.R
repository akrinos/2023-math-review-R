#' Code for completing the second carousel challenge during the
#' WHOI Summer Math Review session on R programming on
#' 16 August 2023.
#' 
#' I’ve been measuring the abundance of an invertebrate 
#' species in a local tidepool. 
#' I suspect the abundance might have an exponential distribution. 
#' My data are arranged as dates and abundance values.
#' How should I build an exponential model?
#' 
#' 
#' The data for this exercise is stored in `../data/carousel_2.csv`

seasonal_data=read.csv("data/carousel_2.csv")
## this includes 2 species...
summary(lm(Abundance~Date,data=seasonal_data))

summary(lm(Abundance~Date,
           data=seasonal_data[seasonal_data$Species=="SpeciesA",]))

## what could be wrong with our model?



seasonal_data$DateNormalized = as.Date(seasonal_data$Date,
                                       format="%Y-%m-%d")
plot(x=seasonal_data[seasonal_data$Species=="SpeciesA",
                     "DateNormalized"],
     y=seasonal_data[seasonal_data$Species=="SpeciesA",
                     "Abundance"],
     data=seasonal_data[seasonal_data$Species=="SpeciesA",],
     xlab="Date",ylab="Abundance")
summary(lm(Abundance~DateNormalized,data=seasonal_data))
summary(lm(Abundance~DateNormalized,data=seasonal_data[seasonal_data$Species=="SpeciesA",]))

## A really useful approach for making predictions
## from exponential time-series data.

# this approach takes into account seasonal variability and
# periodicity.
myts <- ts(c(1,2,4,4,8,16,33,66,123,256,513,1044,
             1,3,3,4,6,16,33,66,121,200,513,1044,
             1,2,5,6,8,14,33,40,123,256,513,2000), start=c(2020, 1), 
           end=c(2022, 12), frequency=12)
fit <- HoltWinters(myts, beta=FALSE, gamma=FALSE)
fit <- HoltWinters(myts)

plot(fit)

library(forecast)
accuracy(forecast(fit, 3))

forecast(fit, 3)
plot(forecast(fit, 12))


#' Code for completing the second carousel challenge during the
#' WHOI Summer Math Review session on R programming on
#' 16 August 2023.
#' 
#' I have some data where I have two True/False values: 
#' whether it rained on a given day and whether temperature 
#' exceeded 80F. 
#' I want to plot a bar plot of each distribution of values 
#' alongside a heatmap that shows the number of times these 
#' two events occurred simultaneously. How can I do this 
#' efficiently?
#' 
#' 
#' The data for this exercise is stored in `../data/carousel_2.csv`

carousel_3 = read.csv("data/carousel_3.csv")

head(carousel_3)

# `p_load` from `dplyr` allows to to simultaneously install.packages + library
pacman::p_load(dplyr)

carousel_3 |> group_by(Rained,TempAbove80) |> dplyr::tally()

pacman::p_load(ggplot2)

pdf("output/rain_bar.pdf")
barplot(formula=n~Rained,
        data=(carousel_3 |> group_by(Rained) |> dplyr::tally()))
dev.off()

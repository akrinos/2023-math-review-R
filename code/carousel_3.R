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

## how could we end up with grouped data the hard way?
categories=unique(carousel_3$Rained)
new_result_frame=data.frame()
for (category in categories) {
  new_result_frame=rbind(new_result_frame,data.frame("Rained"=category,
                                                     "Count"=nrow(carousel_3[carousel_3$Rained==category,])))
}

# `p_load` from `dplyr` allows to to simultaneously install.packages + library
pacman::p_load(dplyr,tidyverse)

carousel_3 |> group_by(Rained,TempAbove80) |> dplyr::tally()

pacman::p_load(ggplot2)

pdf("output/rain_bar.pdf")
barplot(formula=n~Rained,
        data=(carousel_3 |> group_by(Rained) |> dplyr::tally()))
dev.off()

for_heatmap = carousel_3 |> group_by(Rained,TempAbove80) |> dplyr::tally() |>
  tidyr::pivot_wider(names_from="Rained",id_cols="TempAbove80",values_from="n")
heatmap(as.matrix(for_heatmap |> tibble::column_to_rownames("TempAbove80")))

ggplot(carousel_3 |> group_by(Rained,TempAbove80) |> dplyr::tally()) + 
    geom_tile(aes(x=Rained,y=TempAbove80,fill=n))

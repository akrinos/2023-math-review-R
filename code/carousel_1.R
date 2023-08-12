#' Code for completing the first carousel challenge during the
#' WHOI Summer Math Review session on R programming on
#' 16 August 2023.
#' 
#' Prompt: 
#' 
#' I am an arborist interested in estimating the age of 3 different kinds of trees using their circumference. I know that I can approximate tree age using circumference times a species-specific growth factor. 
#' I’ve measured 3 different species of trees and I want to estimate their ages easily. How would you go about calculating this?
#' The growth factors are:
#'      4.5 for red maple
#'      4.0 for American elm
#'      7.0 for Dogwood
#'      
#' The data for this exercise is stored in `../data/carousel_1.csv`

tree_data = read.csv("data/carousel_1.csv")

### APPROACH 1: the hard way! writing code separately for each tree species

tree_data$GrowthFactor=0
tree_data$AgeEstimate=0
for (curr_ind in 1:length(tree_data$Species)) {
  if (tree_data$Species[curr_ind] == "Red maple") {
    tree_data$GrowthFactor[curr_ind]=4.5
    tree_data$AgeEstimate[curr_ind]=4.5*tree_data$Circumference_in[curr_ind]
  }
  else if (tree_data$Species[curr_ind] == "American elm") {
    tree_data$GrowthFactor[curr_ind]=4.0
    tree_data$AgeEstimate[curr_ind]=4.0*tree_data$Circumference_in[curr_ind]
  }
  else if (tree_data$Species[curr_ind] == "Dogwood") {
    tree_data$GrowthFactor[curr_ind]=7.0
    tree_data$AgeEstimate[curr_ind]=7.0*tree_data$Circumference_in[curr_ind]
  }
}

### APPROACH 2: writing code separately for each tree species
tree_data = read.csv("data/carousel_1.csv")

# we also can add the labels manually into the table
print(tree_data)
tree_data$GrowthFactor=c(4.5,4.5,4.0,4.0,4.5,7.0,4.5,4.0,7.0,4.5)
# then we can use vector operations to get our age estimate
tree_data$AgeEstimate=tree_data$GrowthFactor*tree_data$Circumference_in
# remember that element-wise operations are the default in R!

### APPROACH 3: using dplyr to assign growth factors & calculate age estimates
tree_data = read.csv("data/carousel_1.csv")

install.packages("dplyr")
library(dplyr)

tree_data=tree_data%>%
  dplyr::mutate(GrowthFactor=dplyr::case_when(Species=="Red maple"~4.5,
                                              Species=="American elm"~4.0,
                                              Species=="Dogwood"~7.0))%>%
  dplyr::mutate(AgeEstimate=GrowthFactor*Circumference_in)

### Using ggplot to plot our data!
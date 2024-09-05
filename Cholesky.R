# As part of an initiative by the Risk Department, you are asked to provide a model that allows the introduction of correlations in the simulation of two variables in order to carry out a stress test.

# 1.- Conceptualization of the model task: the model must allow the introduction of dependencies between the two variables for the simulation.
# 2.- Data collection: after research and eliciting input from business stakeholders, the time period used to run the simulation is selected based on economic structural and cyclical factors.
# 3.- Data preparation and wrangling: after selecting the time period, we have to make sure that there are no missing values, blanks, and that the two variables contain data points that are for the same periods. 
# 4.- Data exploration: we explore both variables using descriptive statistics, visualizations, economic theory and other tools. 
# 5.- Model building: After careful consideration and data exploration, we choose Cholesky decomposition as the technique to introduce correlation into the randomly generated data.


# For the purposes of this exercise, means and standard deviations are set manually. We assume that a thorough data exploration has been performed on the data and we will proceed directly to step 5.



# Use current time as seed for randomness
set.seed(Sys.time())  
n <- 100000


# After data exploration, we can assert that:
mean1 <- 1.5
sd1 <- 5.8
mean2 <- 7.5
sd2 <- 2.5
correlation <-.8


# Function to generate two correlated normal random variables with the mean and standard deviation provided above
generate_correlated_normals <- function(n, mean1, sd1, mean2, sd2, correlation) {
  # Generate standard normal variables
  z <- matrix(rnorm(2 * n), ncol = 2)
  
  # Generate correlated standard normal variables using Cholesky decomposition
  cor_matrix <- matrix(c(1, correlation, correlation, 1), ncol = 2)
  chol_matrix <- chol(cor_matrix)
  z_correlated <- z %*% chol_matrix
  
  # Convert to normal variables with specified mean and standard deviation
  x1 <- mean1 + sd1 * z_correlated[, 1]
  x2 <- mean2 + sd2 * z_correlated[, 2]
  
  return(list(x1 = x1, x2 = x2))
}


# Generate correlated normal variables
simulated_data <- generate_correlated_normals(n, mean1, sd1, mean2, sd2, correlation)
population <- as.data.frame(simulated_data)






# Plot the simulated data
par(mfrow = c(1, 2))
plot(density(simulated_data$x1, main ="Variable 1"))
plot(density(simulated_data$x2, main ="Variable 2"))



# Load packages
library(readr)
library(dplyr)
library(ggplot2)

# 1. Load data
df = read_csv("Documents/MonthlyPowerGeneration.csv")
df = df %>% mutate(Index = row_number())

# 2. 12-Month Centered Moving Average
moving_avg = rep(NA, nrow(df))
for (i in 7:(nrow(df) - 6)) {
  A1 = mean(df[(i - 6):(i + 5), 2][[1]])
  A2 = mean(df[(i - 5):(i + 6), 2][[1]])
  moving_avg[i] = (A1 + A2) / 2
}
df$`Moving Average` = moving_avg

# 3. Exponential Smoothing (α = 0.2)
alpha = 0.2
Tn = numeric(nrow(df))
Tn[1] = df$`sum of actual energy generated`[1]
for (i in 2:nrow(df)) {
  Tn[i] = alpha * df$`sum of actual energy generated`[i] + (1 - alpha) * Tn[i - 1]
}
df$Tn = Tn

# 4. Polynomial Regression (Quadratic Trend)
Y = as.matrix(as.numeric(df$`sum of actual energy generated`))
n = length(Y)
X = cbind(Intercept = rep(1, n), Time = 1:n, Time2 = (1:n)^2)
X = as.matrix(X)
beta_hat = solve(t(X) %*% X) %*% t(X) %*% Y
Y_hat = X %*% beta_hat
U_hat = Y - Y_hat
df$Quadratic_Trend = Y_hat

# Residual variance and covariance matrix
k = ncol(X)
RSS = t(U_hat) %*% U_hat
sigma_sq = RSS / (n - k)
Var = as.numeric(sigma_sq) * solve(t(X) %*% X)

# Show beta coefficients and variance-covariance matrix
print(beta_hat)
print(Var)

# 5. Final Plot: All Trends
ggplot(df, aes(x = Month)) +
  geom_line(aes(y = `sum of actual energy generated`, color = "Original", group = 1), linetype = "dashed") +
  geom_line(aes(y = `Moving Average`, color = "Moving Avg", group = 1), size = 1) +
  geom_line(aes(y = Tn, color = "Exp Smoothing", group = 1), size = 1) +
  geom_line(aes(y = Quadratic_Trend, color = "Quadratic Trend", group = 1), size = 1) +
  scale_color_manual(values = c("Original" = "blue", 
                                "Moving Avg" = "red", 
                                "Exp Smoothing" = "green", 
                                "Quadratic Trend" = "purple")) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Power Generation Trends (Moving Avg, Smoothing, Polynomial)", 
       x = "Month", y = "Power", color = "Legend")






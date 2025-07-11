# Load libraries
library(readr)
library(dplyr)
library(ggplot2)
library(forecast)
library(tseries)
library(TSA)

# 1. Load dataset
df = read_csv("Documents/MonthlyPowerGeneration.csv")
df$Index = 1:nrow(df)

# 2. Extract target series
y = df$`sum of actual energy generated`

# 3. STL Decomposition
stl_result = stl(ts(y, frequency = 12), s.window = "periodic")

# 4. Add decomposition components to dataframe
df$trend = stl_result$time.series[, "trend"]
df$seasonal = stl_result$time.series[, "seasonal"]
df$residual = stl_result$time.series[, "remainder"]

# 5. Deseasonalized Series (remove seasonal component)
deseasonalized = y - df$seasonal
half_period = 6
deseasonalized[1:half_period] = NA
deseasonalized[(length(y) - half_period + 1):length(y)] = NA
df$deseasonalized = deseasonalized

# 6. Plot Deseasonalized Series and Trend
ggplot(df, aes(x = Month)) +
  geom_line(aes(y = deseasonalized, color = "Deseasonalized"), linetype = "dashed") +
  geom_point(aes(y = deseasonalized)) +
  geom_line(aes(y = trend, color = "Trend"), size = 1) +
  scale_color_manual(values = c("Deseasonalized" = "blue", "Trend" = "red")) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Deseasonalized Series with Trend", x = "Month", y = "Power Generation", color = "Legend")

# 7. Augmented Dickey-Fuller (ADF) Test on Residuals
adf_result = adf.test(df$residual, alternative = "stationary")
cat("ADF Test Statistic:", adf_result$statistic, "\n")
cat("p-value:", adf_result$p.value, "\n")
if (adf_result$p.value <= 0.05) {
  cat("Conclusion: Reject the null hypothesis. Series is stationary.\n")
} else {
  cat("Conclusion: Fail to reject the null hypothesis. Series is non-stationary.\n")
}

# 8. Ljung-Box Test on Residuals
ljung_result = Box.test(df$residual, lag = 20, type = "Ljung-Box")
print(ljung_result)

# 9. Plot ACF of Residuals
acf(na.omit(df$residual), lag.max = 40, main = "ACF of Residuals")

# 10. PACF Test Statistics
pacf_vals = pacf(na.omit(df$residual), plot = FALSE)$acf
n = length(na.omit(df$residual))
test_stats = pacf_vals * sqrt(n)
critical_value = 1.96
pacf_test_df = data.frame(
  Lag = 1:length(pacf_vals),
  PACF = pacf_vals,
  TestStatistic = test_stats,
  Significant = abs(test_stats) > critical_value
)
print(pacf_test_df)


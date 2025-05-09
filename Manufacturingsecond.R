# --- Load Required Libraries ---
library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(tidyverse)

# ---------------------------------------------------------
# Step 1–2: Load & Visualize Employment
# ---------------------------------------------------------
employment_raw <- read_csv("manufacturing.csv")

employment_clean <- employment_raw %>%
  rename_all(tolower) %>%
  filter(grepl("M\\d{2}", period)) %>%
  mutate(
    month = as.integer(sub("M", "", period)),
    date = make_date(year, month, 1),
    employment = value * 1000  # Convert from thousands to actual job counts
  ) %>%
  select(year, month, date, employment)

# Visualize monthly employment trends
ggplot(employment_clean, aes(x = date, y = employment)) +
  geom_line(color = "#0072B2", linewidth = 1) +
  labs(
    title = "Manufacturing Employment (2012–2024)",
    y = "Employment (jobs)",
    x = "Date"
  ) +
  theme_minimal()

# ---------------------------------------------------------
# Step 3: Load & Clean Output Data
# ---------------------------------------------------------
output_raw <- read_csv("manufacturing_output.csv")

output_long <- output_raw %>%
  pivot_longer(
    cols = -1,
    names_to = "year",
    values_to = "output_millions"
  ) %>%
  mutate(
    year = as.integer(year),
    output = output_millions * 1e6  # Convert from millions to actual dollars
  ) %>%
  select(year, output)

# ---------------------------------------------------------
# Step 4: Aggregate & Compute Productivity
# ---------------------------------------------------------
# Aggregate to yearly average employment
employment_yearly <- employment_clean %>%
  group_by(year) %>%
  summarise(avg_employment = mean(employment, na.rm = TRUE)) %>%
  ungroup()

# Merge with output and compute productivity
industry_metrics <- left_join(employment_yearly, output_long, by = "year") %>%
  mutate(productivity = output / avg_employment)

# ---------------------------------------------------------
# Step 5: Visualize Productivity
# ---------------------------------------------------------
ggplot(industry_metrics, aes(x = year, y = productivity)) +
  geom_line(color = "#D55E00", size = 1.2) +
  labs(
    title = "Labor Productivity in Manufacturing (2012–2022)",
    x = "Year",
    y = "Output per Job (Real $)"
  ) +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal()

# ---------------------------------------------------------
# Step 6: Project Output (CAGR + Regression)
# ---------------------------------------------------------
# Method A: Compound Annual Growth Rate (CAGR)
start_year <- 2012
end_year <- 2022
start_output <- industry_metrics$output[industry_metrics$year == start_year]
end_output <- industry_metrics$output[industry_metrics$year == end_year]
cagr <- (end_output / start_output)^(1 / (end_year - start_year)) - 1
output_2023_cagr <- end_output * (1 + cagr)

# Method B: Linear Regression
output_model <- lm(output ~ year, data = output_long)
output_2023_lm <- predict(output_model, newdata = data.frame(year = 2023))

# Combine both projections
output_2023 <- mean(c(output_2023_cagr, output_2023_lm))

# Optional: Visualize output trend with 2023 projection
output_combined <- bind_rows(
  output_long,
  data.frame(year = 2023, output = output_2023)
)

ggplot(output_combined, aes(x = year, y = output)) +
  geom_line(color = "#009E73", size = 1.1) +
  labs(
    title = "Manufacturing Output Projection (2012–2023)",
    x = "Year",
    y = "Output (in dollars)"
  ) +
  theme_minimal()

# ---------------------------------------------------------
# Step 7: Predict Employment
# ---------------------------------------------------------
# Fit regression model: avg_employment ~ output + year
employment_model <- lm(avg_employment ~ output + year, data = industry_metrics)
summary(employment_model)

# Predict 2023 employment based on projected output
future_data <- data.frame(
  year = 2023,
  output = output_2023
)
predicted_employment <- predict(employment_model, newdata = future_data)
print(paste("Projected Manufacturing Employment in 2023:", round(predicted_employment)))

# ---------------------------------------------------------
# Step 8: Project Occupational Breakdown 
# ---------------------------------------------------------
# Example staffing pattern for manufacturing (replace with real data if available)
staffing_pattern <- data.frame(
  occupation = c(
    "Assemblers and Fabricators", 
    "Machinists", 
    "Industrial Engineers",
    "Production Supervisors",
    "Laborers and Freight Movers"
  ),
  percentage = c(0.075, 0.025, 0.015, 0.010, 0.020)
)

# Apply staffing pattern to projected employment
staffing_pattern <- staffing_pattern %>%
  mutate(
    projected_employment = round(predicted_employment * percentage)
  )

# Print projected occupational breakdown
print(staffing_pattern)

# Optional: Visualize breakdown
ggplot(staffing_pattern, aes(x = reorder(occupation, -projected_employment), y = projected_employment)) +
  geom_col(fill = "#0072B2") +
  labs(
    title = "Projected Occupational Employment in Manufacturing (2023)",
    x = "Occupation",
    y = "Jobs"
  ) +
  theme_minimal() +
  coord_flip()

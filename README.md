# Occupational-Employment-Projection

Disclaimer

This analysis is intended for educational and exploratory purposes. While it uses real data and forecasting techniques, it does not match the depth, rigor, or data granularity of official U.S. Bureau of Labor Statistics (BLS) labor market projections.

The occupational projections are based on a simplified staffing pattern and do not account for factors like demographic shifts, automation, policy changes, or industry-specific trends that are typically considered in BLS analyses.




Dataset Descriptions


1. manufacturing.csv
Source: U.S. Bureau of Labor Statistics or similar source.

Contents: Monthly employment figures in the manufacturing sector.

Important fields:

year, period: Timestamp fields

value: Employment in thousands

Processed fields:

employment: Employment converted to actual job counts (multiplied by 1,000)

date: Created from year and month

2. manufacturing_output.csv
Source: U.S. Federal Reserve or similar economic data provider.

Contents: Annual manufacturing output in millions of dollars.

Important fields:

Column 1: Industry identifier or name (not used in modeling)

Columns 2+: Output values for each year (e.g., 2012–2022)

Processed fields:

output: Output converted from millions to actual dollar values (×1,000,000)

Results & Insights
2023 Manufacturing Output: Forecasted using both CAGR and regression, then averaged.

2023 Employment: Predicted using a linear model with output and year as predictors.

Occupational Breakdown: Projected jobs by occupation, using a sample staffing distribution.


               Occupation      Share (%)        Projected Jobs
  Assemblers and Fabricators       7.5         957473
                  Machinists       2.5         319158
        Industrial Engineers       1.5         191495
      Production Supervisors       1.0         127663
 Laborers and Freight Movers       2.0         255326

Visualizations include:

Employment trends (2012–2024)

Productivity trends

Output forecast and employment forecast for 2023

Occupational employment bar chart for 2023


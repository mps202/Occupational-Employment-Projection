# Occupational-Employment-Projection

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

Occupation	                           % Share	                      Projected Jobs
Assemblers and Fabricators	             7.5%	                          Calculated
Machinists	                             2.5%                         	Calculated
Industrial Engineers	                   1.5%	                          Calculated
Production Supervisors	                 1.0%	                          Calculated
Laborers and Freight Movers	             2.0%	                          Calculated

Visualizations include:

Employment trends (2012–2024)

Productivity trends

Output forecast and employment forecast for 2023

Occupational employment bar chart for 2023


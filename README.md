# Coursera data cleaning course project
A course project for the Data Cleaning Coursera course
## Description and usage
Current project only uses one script - `run_analysis.R`, which performs all the analysis and doesn't use any libraries, so it can be run using just a command like `R < run_analysis.R`.

Unless file named `data.zip` already exists, it downloads it from the internet and performs all the analysis, saving the result in the filed names `result.txt`. If `data.zip` already exists, it will be used for analysis without redownloading it.

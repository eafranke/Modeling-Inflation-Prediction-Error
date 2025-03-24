# Modeling How Individual-Level Characteristics Impact Inflation Prediction Error

## About

This project explores the determinants of inflation prediction errors using data from the Survey of Consumer Expectations (SCE) from 2013 to 2023, combined with monthly national and annual state-level Personal Consumption Expenditures (PCE). The analysis involves data merging, variable creation, and regression modeling, all implemented in Stata.

## Repository Contents

### 1. `Stata data/`
Contains all `.dta` files used in the project:

- **Raw Data/** – Individual files used during the merging process in `Data Merging.do`
- **SCE 2013–2023 Merged Final.dta** – Cleaned and fully merged dataset used in `Models.do`

### 2. `Do/`
Includes all Stata scripts used throughout the workflow:

- **Data Merging.do** – Merges, restructures, and appends the raw datasets
- **Variable Creation.do** – Generates derived variables and transformations for modeling
- **Models.do** – Runs econometric models analyzing the determinants of inflation prediction error

### 3. Project Paper
- Erik Franke - Modeling Inflation Prediction Error.pdf**  
  Full research write-up, including:
  - Introduction & Background  
  - Literature Review  
  - Conceptual Framework & Hypotheses  
  - Data & Methodology  
  - Results & Analysis  
  - Conclusion & Policy Implications  
  - References & Appendices

## Usage Instructions

1. Open **Stata**.
2. Run `Data Merging.do` to generate the merged dataset (if starting from raw data).
3. Run `Variable Creation.do` to construct all necessary variables.
4. Run `Models.do` to execute regression analyses and produce output.
5. Refer to the PDF for detailed explanations, methodology, and interpretation of results.

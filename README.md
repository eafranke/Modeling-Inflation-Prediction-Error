Inflation Prediction Error Modeling

This project explores the determinants of inflation prediction errors using data from the Survey of Consumer Expectations (SCE) from 2013 to 2023 and monthly National and yearly State-level PCE. The analysis includes data merging, variable creation, and regression modeling implemented in Stata.
Contents

1. Stata data folder
Contains all .dta files used in the project:
• Raw Data: Individual files used during the merging process in Data Merging.do.
• SCE 2013-2023 Merged Final.dta: Cleaned and fully merged dataset used in Models.do.

2. Do folder
Includes all the Stata scripts used throughout the workflow:
• Data Merging.do: Merges, restructures, and appends the raw datasets.
• Variable Creation.do: Generates derived variables and necessary transformations for modeling.
• Models.do: Runs econometric models to analyze the determinants of inflation prediction error.

3. Project Paper
Erik Franke - Modeling Inflation Prediction Error.pdf contains a full write-up of the research, including:
• Introduction & Background
• Literature Review
• Conceptual Framework & Hypotheses
• Data & Methodology
• Results & Analysis
• Conclusion & Policy Implications
• References & Appendices

Usage Instructions
1. Open Stata.
2. Run Data Merging.do to create the merged dataset (if starting from raw data).
3. Run Variable Creation.do to generate required variables.
4. Run Models.do to execute all analyses and generate results.
5. Refer to the PDF for a detailed explanation of the methods and interpretation of the output.

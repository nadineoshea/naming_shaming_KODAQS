# Naming and Shaming of Rebel Groups by the United Nations Security Council  
Nadine O'Shea

**Note:** This is an illustrative example of a reproducible research workflow using Stata and Git/GitHub. It includes only a subset of the full research project and contains raw material on two example rebel groups. The original project covers all rebel groups active since 1989 but is not shared in full here.

Goal: Estimating the impact of naming and shaming rebel groups on rebel violence against civilians.

## Project Structure

This project explores how naming and shaming by the United Nations Security Council (UNSC), through resolutions and press releases, may affect the behavior of rebel groups, specifically regarding violence against civilians. 


## Data

### data/raw/
- Contains two folders, each named after a specific rebel group.
- Each folder includes:
  - UNSC resolutions and press release statements in which the rebel group is mentioned.
  - These materials are used to identify and code the degree of naming and shaming by the UNSC.
- These documents are the basis for the hand-coded dataset.

### data/processed/
- Contains a shortened version of the processed dataset.
- Includes coded data of rebel groups.
- Additional datasets used in the analysis (such as the UCDP dyadic conflict data) are loaded directly from GitHub in the analysis script.

## Documentation

### doc/codebook.md
- Provides documentation on how naming and shaming instances were coded.
- Includes variable definitions, coding categories, and examples.

## Scripts

### scripts/analysis.do
- The main Stata do-file that:
  1. Loads and processes the UCDP dyadic dataset from GitHub
  2. Loads the hand-coded naming and shaming data from the processed dataset
  3. Merges the two datasets on rebel group and time
  4. Filters for rebel groups that were both:
     - Part of an armed conflict
     - Named and shamed by the UNSC
  5. Saves the final merged dataset used in analysis.
     Note: The analysis was conducted using Stata version 15.

---

## Reproducibility

```bash
./run.sh


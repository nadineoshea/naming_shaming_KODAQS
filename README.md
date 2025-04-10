# Naming and Shaming of Rebel Groups by the United Nations Security Council  
Nadine O'Shea

**Note:** This is an illustrative example of a reproducible research workflow. It includes only a subset of the full research project and contains raw material on two example rebel groups. The original project covers all rebel groups active since 1989 but is not shared in full here.

Goal: Estimating the impact of naming and shaming rebel groups on rebel violence against civilians.

---

## Project Structure

This project explores how public condemnation by the United Nations Security Council (UNSC) — through resolutions and press releases — may affect the behavior of rebel groups, specifically regarding violence against civilians. The data and analysis are part of a reproducible research workflow using Stata and Git/GitHub.

The current version of this repository focuses on two example rebel groups, selected from a broader dataset that originally included all rebel groups active since 1989. These two cases are included to illustrate the coding of naming and shaming and to demonstrate the full reproducible pipeline.

---

## Data

### data/raw/
- Contains two folders, each named after a specific rebel group.
- Each folder includes:
  - UNSC resolutions and press release statements in which the rebel group is mentioned.
  - These materials are used to identify and code the degree of naming and shaming by the UNSC.
- These documents are the basis for the hand-coded dataset.

### data/processed/
- Contains a shortened and shareable version of the processed dataset.
- Includes cleaned and coded data for the two example rebel groups.
- Additional datasets used in the analysis (such as the UCDP dyadic conflict data) are loaded directly from GitHub in the analysis script.

---

## Documentation

### doc/codebook.md
- Provides detailed documentation on how naming and shaming instances were coded.
- Includes variable definitions, coding categories, and examples.
- This file allows users to interpret the processed dataset correctly and transparently.

---

## Scripts

### scripts/analysis.do
- The main Stata script that:
  1. Loads and processes the UCDP dyadic dataset from GitHub
  2. Loads the hand-coded naming and shaming data from the processed dataset
  3. Merges the two datasets on rebel group and time
  4. Filters for rebel groups that were both:
     - Part of an armed conflict
     - Named and shamed by the UNSC
  5. Saves the final merged dataset used in analysis.
  6. Note: The analysis was conducted using Stata version 15.

---

## Reproducibility

To reproduce the full analysis:

1. Clone this repository or download the contents  
2. Open a terminal in the project directory  
3. Run the following command:

```bash
./run.sh


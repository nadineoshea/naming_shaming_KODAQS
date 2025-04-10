#!/bin/bash
set -e

echo "Running Stata analysis..."

'/Applications/Stata/Neuer Ordner/StataSE.app/Contents/MacOS/StataSE' -b do scripts/analysis.do

echo "Analysis complete."

./run.sh

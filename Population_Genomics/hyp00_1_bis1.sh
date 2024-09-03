#!/bin/bash
#
#SBATCH --job-name=SumStat
#SBATCH --output=log_hyp00_1_bis1.txt
#SBATCH --partition=hmem
#
#SBATCH --time=15-00:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000

module load R

Rscript /home/pvderaa/scripts/hyp00_1_bis1.R

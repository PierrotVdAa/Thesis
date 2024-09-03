This folder contains the scripts used to extract the summary statistics from the DNA data produced by fastsimcoal.
Given that there was a lot of data to analyses, these summary statistics were made in batches on subsets of the data.

The folder contains the following files:

- `dxy_single_file.R`: to loop through the files one by one and delete the ones already explored to avoid problems linked to PopGenome leading to abortion of the R session.
- `merge_dxy.py`: a python script to merge together the idividual results from the analysis here above.
- `sum_stat_test.R`: an R script to analyse all the other summary statistics than the dxy.
- `hyp00_1_`: four example files to analyse the summary statistics on the batches of DNA data on the CECI cluster.

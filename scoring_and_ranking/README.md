# Scoring and Ranking

## Pipeline

### `01_evaluate.sh`
y
Run [GNINA](https://github.com/gnina/gnina) on CASF-2016 benchmark dataset for scoring and ranking. This step produces three scores `Affinity` (Vina-predicted affinity), `CNNscore` (CNN pose score) and `CNNaffinity` (CNN-predicted affinity).

[GNINA](https://github.com/gnina/gnina) log files are stored in the `logs` folder, for different pose-optimisations (first subfolder level) methods, and different CNN models (second subfolder level).
 
### `02_collect.sh`

Collect all [GNINA](https://github.com/gnina/gnina) scores, combining all the CASF-2016 systems into `.dat` file, with the appropriate format for the analysis with CASF-2016 scripts.

Scores for the different systems collected in `.dat` files are stored in the `results` folder, for different pose-optimisations (first subfolder level), and different CNN models and scores (file names).

### `03_analyse.sh`

Run CASF-2016 analysis scripts in order to compute the following metrics:
* Pearson's correlation coefficient (scoring)
* Spearman's correlation coefficient (ranking)
* Kendall's correlation coefficient (ranking)
* Predictive Index (ranking)

Analysis output files are stored in `analysis/outputs/` while analysis log files (containing the metrics of interest as well as R scripts for bootstrapping)  are stored in `analysis/logs/`, for different optimisation methods (first subfolder level), and for different models and scoring methods (file names).

### `04_bootstrap.sh`

Perform bootstrapping in [R](https://www.r-project.org/) to compute 90% confidence intervals.

The results of bootstrapping are stored in `analysis/outputs/`, for different power tests (scoring and ranking, first subfolder level), for different optimisation methods (second subfolder level), and for different models and scoring methods (file names).

### `05_reports.sh`

Generate reports by collecting all CASF-2016 metrics (for different optimisation methods and models) into a single `.csv` file for further analysis, visualization, and comparison with other methods.

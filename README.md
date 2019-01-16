# ML-architectural-analytics
A machine learning toolkit for the analysis of spatial cultures in architecture.

This repository stores the code for the work related to the use of Machine Learning for the analysis of architectural plans. The results related to such code were submitted to [CAAD Futures 2019](http://caadfutures2019.kaist.ac.kr/), with the full work now being evaluated].

**Table of Contents:**

1. [Replication of Results](#1-replication-of-results)
2. [Comments](#2-comments)
3. [Contributors](#3-contributors)


## 1 Replication of Results

The analysis is fully replicable. 
The files are numerated from 0. to 5. to indicate the progression of the analysis, which coincides with the progression the paper takes as well.

- 0.: Provides the code to read-in `.txt` output files from GrassHopper code into `pandas` Dataframes and `numpy` matrices for adjacency matrices (the whole folder in the Google Drive is ingested here). The output of that process is stored in `data/graph_dict_flnms_dfs_adjmats.pkl`, so it's not necessary to run the first portion. On top of this, some EDA is done on the single features for feature selection purposes;
- 1.: Provides the code for pair plots in R;
- 2.: Room Level Classification Results;
- 3.: Building Level Analysis;
- 4.: Creating the Gram Matrix from graphs adjaciency matrices;
- 5.: Performing Kernel SVM Implementations.


## 2 Comments
When necessary, code found elsewhere is acknowledged in line.
`pip_requirements.txt` reports the version of the main packages used - analysis was done in Python `2.7.10` and R version `3.4.3`, "Kite-Eating Tree".

This [Google Drive folder](https://drive.google.com/open?id=1_OVjXOzue_rNoSBZByl4HItWjew2fO3K) is the main repository for the architectural plans, including the processing code for the architectural plans in Grasshopper, which can be consulted for more information.

## 3 Contributors 
Code was written jointly by the following authors:
- Nic Dalmasso ([`Mr8ND`](https://github.com/Mr8ND))
- Cecilia Ferrando  ([`ceciliaferrando`](https://github.com/ceciliaferrando))

This repository is public and owned by Nic Dalmasso and Cecilia Ferrando, under the MIT License.
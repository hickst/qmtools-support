﻿# QMTools Support

This is a public code repository of the [Translational BioImaging Resource–MRI](https://research.arizona.edu/facilities/core-facilities/translational-bioimaging-resource-mri) core group at the [University of Arizona](https://www.arizona.edu/).

**Authors**: [Tom Hicks](https://github.com/hickst) and [Dianne Patterson](https://github.com/dkp)

**About**: This project provides scripts, sample files, and documentation to use the [QMTools Docker container](https://hub.docker.com/repository/docker/hickst/qmtools) of the [QMTools project](https://github.com/hickst/qmtools). The container implements several programs to visualize, compare, and review the image quality metrics (IQMs) produced by the [MRIQC program](https://github.com/poldracklab/mriqc). MRIQC extracts no-reference IQMs from structural (T1w and T2w) and functional (BOLD) MRI data.

## Using QMTools Support

This QMTools Support repository is designed to use the publicly available [QMTools Docker container](https://hub.docker.com/repository/docker/hickst/qmtools). Scripts, sample files, and documentation are provided to simplify this process. With this approach, the QMTools are located in the Docker container and are called by the run scripts to process data from input and output directories which the run scripts make available to the container. Since this approach requires only **Docker**, **git** and the **bash shell** to be installed on your local computer, it has a minimal "footprint".

To use the QMTools Support project:

### 1. Checkout the QMTools Support project (ONCE)

Git `clone` this project somewhere within your "home" area and enter the cloned project directory.

***Note**: As an alternative to cloning, you can download (and then unzip) the project from the project page at GitHub using the green `Code` button.*

To `clone` this project from GitHub:
```
  > cd /Users/janedoe/work
  > git clone https://github.com/hickst/qmtools-support.git qmtools
  > cd qmtools
  > pwd
  /Users/janedoe/work/qmtools
```

***Note**: hereafter, this directory will be called the "project directory".*

There are several directories which are made available to the QMTools Docker container when you run a tool. These are **inputs**, **reports**, **fetched**, and **queries**, all of which are children of the _project directory_.

The **inputs** directory will be used to hold at least one of your group data files: i.e., a `.tsv` file output from a prior run of the __MRIQC__ program.

The **fetched** directory will be used to hold IQM (Image Quality Metrics) data retrieved from an online database of previously collected quality metrics that is maintained by the MRIQC group. For more information, see the documentation for the [QMFetcher program](https://github.com/hickst/qmtools-support/blob/master/docs/QMFetcher.md).

The **reports** directory will be used to hold visualizations and reports generated by the QMTools. Repeated runs of the QMTools programs will generate different sub-directories within the main **reports** directory.

The **queries** directory will be used to hold _query parameters_ files: small files containing parameters for selectively fetching IQM records from the MRIQC server. The **samples** subdirectory contains several sample query parameters files that you can use as a starting point for your own parameterized queries. 

### 2. Run a QMTool through a Run Script

In general, you will utilize the QMTools by copying IQM data files (i.e., MRIQC group files) into the **inputs** directory and/or by fetching IQM data from the MRIQC database server into the **fetched** directory. For each tool, a Bash script is included which makes the required directories available to the container and then starts the container to run the tool. Reports produced by the QMTools will be output into a sub-directory of the **reports** directory.

[QMTraffic](https://github.com/hickst/qmtools-support/docs/QMTraffic.md) - Normalizes a set of MRIQC image quality metrics and creates a tabular HTML report visualizing how much each image's metrics deviate from the mean for all the images.

[QMFetcher](https://github.com/hickst/qmtools-support/docs/QMFetcher.md) - Queries the MRIQC database server to fetch image quality metrics for images previously processed by neuroimaging groups all over the world. A query may specify multiple image metadata parameters to filter the images whose metrics are returned. As query parameters may be read from user-created files, queries may be easily and consistently repeated.

[QMViolin](https://github.com/hickst/qmtools-support/docs/QMViolin.md) - Compares two sets of MRIQC image quality metrics and creates an HTML report visualizing how the groups compare for each IQM. The two data sets to be compared can both be user-generated OR both fetched from the MRIQC database OR one of each.

**Please see the individual tools documentation for instructions on running each tool.**
## Related Links

The source code for the [QMTools](https://github.com/hickst/qmtools) in GitHub.

The [QMTools project](https://github.com/hickst/qmtools) was inspired by a 2019 Neurohackademy project available [here](https://github.com/elizabethbeard/mriqception).

The [Swagger UI for the MRIQC web API](https://mriqc.nimh.nih.gov). Scroll down to the `Models` section, which documents the database schema (structure and field names) that can be queried with **QMFetcher**.

The source code for the [MRIQC web API](https://mriqc.nimh.nih.gov/), which provides the API that **QMFetcher** uses to query the MRIQC database.

Some old [Discussions and Jupyter notebooks](https://www.kaggle.com/chrisfilo/mriqc/code) which utilize the same MRIQC web API that this project uses.

## References

- Esteban O, Blair RW, Nielson DM, Varada JC, Marrett S, Thomas AG et al. (2019). Crowdsourced MRI quality metrics and expert quality annotations for training of humans and machines. Sci Data 6: 30.

- Esteban O, Birman D, Schaer M, Koyejo OO, Poldrack RA, Gorgolewski KJ (2017). MRIQC: Advancing the automatic prediction of image quality in MRI from unseen sites. PLoS ONE 12: 9.

## License

This software is licensed under Apache License Version 2.0.

Copyright (c) The University of Arizona, 2021. All rights reserved.

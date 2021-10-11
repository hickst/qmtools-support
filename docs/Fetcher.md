# QMTools Fetcher

This is a public code repository of the [Translational BioImaging Resource–MRI](https://research.arizona.edu/facilities/core-facilities/translational-bioimaging-resource-mri) core group at the [University of Arizona](https://www.arizona.edu/).

**Authors**: [Tom Hicks](https://github.com/hickst) and [Dianne Patterson](https://github.com/dkp)

**About**: This document describes the Fetcher tool of the [QMTools project](https://github.com/hickst/qmtools). Fetcher queries the MRIQC database server to fetch image quality metrics (IQMs) for images previously processed by neuroimaging groups all over the world. A query may specify multiple image metadata parameters to select the IQMs to be returned. As query parameters are read from user-created files, queries may be easily and consistently repeated.

The use of content-specific query parameters is a very powerful capability, potentially allowing insight into many of the factors which affect image quality. Using QMTools, in conjunction with the MRIQC server, allows image quality metrics to be queried and compared across a variety of BIDS metadata and provenance properties.

For a listing of the IQM, provenance, and BIDS metadata fields provided by the MRIQC database server, and queryable by the **qmfetcher** program, see the `Models` section of the [MRQCI Web API](https://mriqc.nimh.nih.gov/) page.

For more information on the use of query parameters files in Fetcher, please see the [Queries documentation](https://github.com/hickst/qmtools-support/blob/main/docs/Queries.md).
## Using the Fetcher Tool

### **Prerequisite**: Install the QMTools Support project

Follow the instructions on this project's [main page](https://github.com/hickst/qmtools-support) to install the project which the Fetcher script (**qmfetcher**) and this document are a part of.

### **Prerequisite**: Docker

You must have Docker installed and working on your machine to use this project. For instructions on how to install Docker see [this link](https://docs.docker.com/get-docker/).

### **Step 1**: Ensure the required input files are available

The Fetcher program retrieves a dataset of IQM records from an online database and, thus, does not require any data files as inputs. 

The Fetcher program does, however, allow complex queries using multiple metadata parameters, which are stored in *query parameters* files. These "canned" queries **must** be located within the `queries` subdirectory, as that directory is made available to the QMTools Docker container by the **qmfetcher** script. When you create your own query parameters files, please make sure that they reside somewhere within the `queries` directory tree.

### **Step 2**: Run the **qmfetcher** Script

Each tool includes an associated script which runs the tool within the QMTools Docker container and makes the appropriate subdirectories available to the container (via a Docker *bind mount*):

To retrieve a dataset from the MRIQC server, run the **qmfetcher** script at the command line, specifying the modality and optional arguments to control the query. Optional arguments allow naming the output file, specifying the number of records to fetch, selecting the oldest records, and using a *query parameters* file; which contains content-specific query parameters.

For a listing of the **qmfetcher** arguments, see the [Getting Usage Help](#Getting-Usage-Help) section below.

**Example 1**: Retrieve a dataset of the most recent 50 Bold IQM records:
```
  > qmfetcher -v bold
```

This example shows the very simplest invocation, using only the required modality argument. By default, Fetcher tries to return the 50 most recent IQM records for the given modality (omitting duplicates).

***Note**: It is highly recommended to use the **verbose mode flag** (`-v` or `--verbose`) to produce informational messages while processing, unless you have a specific reason not to do so (such as running a QMTools script embedded within another script).*

If no problems are encountered while running the program, you should see status messages, such as these:
```
  > qmfetcher -v bold

(qmfetcher): Querying MRIQC server with modality 'bold', for 50 records.
(qmfetcher): Fetched 50 records out of 964878.
(qmfetcher): Saved query results to 'fetched/bold_20211007_155417-540862.tsv'.
```

Note that, in Verbose mode, the path to the dataset (a file of fetched records) is displayed.

**Example 2**: Fetch a dataset of the 27 oldest T1w IQM records, saving them to a file named `T1w_oldies`:
```
  > qmfetcher -v T1w -n 27 --use-oldest -o T1w_oldies

(qmfetcher): Querying MRIQC server with modality 'T1w', for 27 records.
(qmfetcher): Fetched 27 records out of 1403171.
(qmfetcher): Saved query results to 'fetched/T1w1_oldies.tsv'.
```

In this example, `T1w` is specified as the modality, 27 unique records are desired (`-n` option), and the oldest such records in the database are requested. The optional output filename argument (`-o`) allows the naming of the file, within the `fetched` directory, where the fetched dataset file will be saved.

**Example 3**: Just show the query to fetch a dataset of the 27 oldest T1w IQM records:
```
  > qmfetcher -v T1w -n 27 --use-oldest --url-only

https://mriqc.nimh.nih.gov/api/v1/T1w?max_results=27&page=1
```

Using the `--url-only` flag causes **qmfetcher** to construct and display the query URL, which would have been used to fetch a dataset, but **no records are actually fetched**. This can be useful for creating and debugging a query parameters file. The displayed URL can also be used by other HTTP client programs (e.g., `curl`, `wget`) to perform the query and retrieve the corresponding records.

**Example 4**: Query for a dataset of recent Bold IQM records from Siemens 7T scanners:
```
  > qmfetcher -v bold -o Siemens7T.tsv -q queries/samples/siemens7.qp

(qmfetcher): Querying MRIQC server with modality 'bold', for 50 records.
(qmfetcher): Fetched 50 records out of 278.
(qmfetcher): Saved query results to 'fetched/Siemens7T.tsv'.
```

This example uses a *query parameters* file containing content-specific query parameters which select the records to be retrieved for the dataset. The file path to the query parameters file is specified to the **qmfetcher** program using the `-q` or `--query-file` option.

**Example 5**: Just show the query to fetch a dataset of recent Bold IQM records from Siemens 7T scanners:
```
  > qmfetcher -v bold -o Siemens7T.tsv -q queries/samples/siemens7.qp --url-only

https://mriqc.nimh.nih.gov/api/v1/bold?max_results=50&page=1&sort=-_created&where=bids_meta.Manufacturer=="Siemens"%20and%20bids_meta.MagneticFieldStrength>=6.5
```

Just as in **Example 3**, using the `--url-only` flag causes **qmfetcher** to construct and display the query URL, which would have been used to fetch a dataset, but **no records are actually fetched**. Note that the output filename argument (`-o`) has been included here but **it is ignored** when the `--url-only` flag is specified.

### Getting Usage Help for a Tool

To see a help (usage) message for a QMTool, call the tool script with the special ***help flag*** (`-h` or `--help`):
```
  > qmfetcher -h

usage: qmfetcher [-h] [-v] [-n NUM_RECS] [-o filename] [-q filepath] [--use-oldest] [--url-only] {bold,T1w,T2w}

Query the MRIQC server and save query results.

positional arguments:
  {bold,T1w,T2w}        Modality of the MRIQC IQM records to fetch. Must be one of: ['bold', 'T1w', 'T2w']

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Print informational messages during processing [default: False (non-verbose mode)].
  -n NUM_RECS, --num-recs NUM_RECS
                        Number of records to fetch (maximum) from a query [default: {SERVER_PAGE_SIZE}]
  -o filename, --output-filename filename
                        Optional name of file to hold query results in fetched directory [default: none].
  -q filepath, --query-file filepath
                        Path to a query parameters file in or below the run directory [no default]
  --use-oldest          Fetch oldest records [default: False (fetches most recent records)].
  --url-only            Generate the query URL and exit program [default: False].
```

### **Step 3**: Access the Fetched Datasets

When run in Verbose mode (using the `-v` or `--verbose` flag), QMTools which produce reports will show the path to the HTML report file, which can then be opened in a browser window. Tools which fetch or create data files will display the path to the directory containing those files.

All datasets retrieved by the **qmfetcher** program will be placed in the `fetched` directory. Fetched datasets can serve as inputs to the [Violin](https://github.com/hickst/qmtools-support/blob/main/docs/Violin.md) tool or can be manipulated by other programs which understand TSV files.

 A fetched dataset is a standard tab-separated file (`.tsv`) containing the quality metrics for one image in each row. However, in addition to the image quality metrics fields found in MRIQC-generated group files, the fetched datasets also contain many additional metadata columns. These additional columns include provenance information and BIDS metadata.

**Note**: For a listing of the IQM, provenance, and BIDS metadata fields provided by the MRIQC database server, and fetched by the **qmfetcher** program, see the `Models` section of the [MRQCI Web API](https://mriqc.nimh.nih.gov/) page.

**Example 1**: Open the dataset retrieved in **Example 1** above in your default spreadsheet program:
```
  > open fetched/bold_20211007_155417-540862.tsv
```

**Example 2**: Compare the dataset retrieved in **Example 2** above with an MRIQC-generated group file using the Violin tool:
```
  > qmviolin T1w fetched/T1w_oldies.tsv inputs/group_T1w.tsv
```

**Example 4**: Compare the latest Bold IQM records for Siemens 7T scanners, retrieved in **Example 4** above, to IQM records from your own Siemens 3T scanner:
```
  > qmviolin bold fetched/Siemens7T.tsv inputs/my_siemens_3T.tsv
```

## License

This software is licensed under Apache License Version 2.0.

Copyright (c) The University of Arizona, 2021. All rights reserved.

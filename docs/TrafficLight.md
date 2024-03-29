# QMTools TrafficLight

This is a public code repository of the [Translational BioImaging Resource–MRI](https://research.arizona.edu/facilities/core-facilities/translational-bioimaging-resource-mri) core group at the [University of Arizona](https://www.arizona.edu/).

**Author**: [Tom Hicks](https://github.com/hickst)

**About**: This document describes the TrafficLight tool of the [QMTools project](https://github.com/hickst/qmtools). TrafficLight normalizes a set of MRIQC image quality metrics and creates a tabular HTML report, visualizing how much each image's metrics deviate from the mean for all the images in that set.

## Using the TrafficLight Tool

### **Prerequisite**: Install the QMTools Support project

Follow the instructions on this project's [main page](https://github.com/hickst/qmtools-support) to install the project which the TrafficLight script (**qmtraffic**) and this document are a part of.

### **Prerequisite**: Docker or Apptainer

You must have Docker or Apptainer installed and working on your machine to use this project. For instructions on how to install Docker see [this link](https://docs.docker.com/get-docker/).

### **Step 1**: Ensure the required input file is available

The **qmtraffic** script reads a single *MRIQC group file*; a tab-separated (.tsv) file produced by running the MRIQC program at the group level. The group file must be present in the `inputs` directory, so that it is available to the QMTools container. Copy an MRIQC group file into the `inputs` directory before running the **qmtraffic** script.

****Example****: Copy the MRIQC-generated group file from the 'proj1' project to the QMTools `inputs` directory:
```
  > cp ~/work/proj1/derivatives/mriqc/group_bold.tsv ~/work/qmtools/inputs
```

### **Step 2**: Run the **qmtraffic** Script

Each tool includes an associated script which runs the tool within the QMTools container and makes the appropriate subdirectories available to the container (via a Docker or Apptainer *bind mount*):

To produce a TrafficLight report, run the **qmtraffic** script at the command line, specifying the modality and the relative path to the MRIQC group file.

The examples are all for Docker. If you are using Apptainer instead, then use the corresponding Apptainer scripts (the ones with the `*_hpc` suffix).

**Example 1**: Run the TrafficLight report for the previously copied MRIQC group file:
```
  > qmtraffic -v bold inputs/group_bold.tsv
```

***Note**: It is highly recommended to use the **verbose mode flag** (`-v` or `--verbose`) to produce informational messages while processing, unless you have a specific reason not to do so (such as running a QMTools script embedded within another script).*

If no problems are encountered while running the program, you should see status messages, such as these:
```
  > qmtraffic -v bold inputs/group_bold.tsv

(qmtraffic): Processing MRIQC group file 'inputs/group_bold.tsv' with modality 'bold'.
(qmtraffic): Produced reports in reports directory 'reports/bold_20211011_195416-871044'.
(qmtraffic): To see the report: open 'reports/bold_20211011_195416-871044/bold.html' in a browser.
```

**Example 2**: Run the TrafficLight report for the previously copied MRIQC group file, but save the report to a new `reports` subdirectory with the name `group9`:
```
  > qmtraffic -v bold inputs/group_bold.tsv -r group9

(qmtraffic): Processing MRIQC group file 'inputs/group_bold.tsv' with modality 'bold'.
(qmtraffic): Produced reports in reports directory 'reports/group9'.
(qmtraffic): To see the report: open 'reports/group9/bold.html' in a browser.
```

### Getting Usage Help

To see a help (usage) message for a QMTool, call the tool script with the special ***help flag*** (`-h` or `--help`):
```
  > qmtraffic -h

usage: qmtraffic [-h] [-v] [-r REPORT_DIR] {bold,T1w,T2w} group_file

Normalize an MRIQC group file and produce HTML reports.

positional arguments:
  {bold,T1w,T2w}  Modality of the MRIQC group file. Must be one of: ['bold', 'T1w', 'T2w']
  group_file      Path to an MRIQC group file (.tsv) to visualize.

optional arguments:
  -h, --help      show this help message and exit
  -v, --verbose   Print informational messages during processing [default: False (non-verbose mode)].
  -r REPORT_DIR, --report-dir REPORT_DIR
                  Optional name of report subdirectory in main reports directory [default: none].
```

### **Step 3**: View the Output Report

When run in Verbose mode (using the `-v` or `--verbose` flag), QMTools which produce reports will show the path to the HTML report file, which can then be opened in a browser window. Tools which fetch or create data files will display the path to the directory containing those files.

The TrafficLight program produces its report in a subdirectory of the `reports` directory. If you do not explicitly specify a subdirectory name (using the `-r` or `--report-dir` option) then a timestamped directory name is generated. (e.g., `bold_20211011_195416-871044` in **Example 1** above). The report may then be displayed in a browser by opening the HTML file named with the modality that was specified when creating the reports (i.e, 'bold.html', 't1w.html', or 't2w.html').

**Example 1**: View the TrafficLight report created in **Example 1** above:
```
  > open reports/bold_20211011_195416-871044/bold.html
```

**Example 2**: View the TrafficLight report created in **Example 2** above:
```
  > open reports/group9/bold.html
```

## License

This software is licensed under Apache License Version 2.0.

Copyright (c) The University of Arizona, 2021. All rights reserved.

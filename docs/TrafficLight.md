# QMTools TrafficLight Tool

This is a public code repository of the [Translational BioImaging Resource–MRI](https://research.arizona.edu/facilities/core-facilities/translational-bioimaging-resource-mri) core group at the [University of Arizona](https://www.arizona.edu/).

**Authors**: [Tom Hicks](https://github.com/hickst) and [Dianne Patterson](https://github.com/dkp)

**About**: This document describes the TrafficLight tool of the [QMTools project](https://github.com/hickst/qmtools). TrafficLight normalizes a set of MRIQC image quality metrics and creates a tabular HTML report, visualizing how much each image's metrics deviate from the mean for all the images in that set.

## Using the TrafficLight Tool

### **Prerequisite**: Install the QMTools Support project

Follow the instructions on this project's [main page](https://github.com/hickst/qmtools-support) to install the project which the TrafficLight script (**qmtraffic**) and this document are a part of.

### **Prerequisite**: Docker

You must have Docker installed and working on your machine to use this project. For instructions on how to install Docker see [this link](https://docs.docker.com/get-docker/).

### **Step 1**: Ensure the required input file is available in the `inputs` directory.

The **qmtraffic** script reads a single *MRIQC group file*; a tab-separated (.tsv) file produced by running the MRIQC program at the group level. The group file must be present in the `inputs` directory, so that it is available to the QMTools Docker container. Copy an MRIQC group file into the `inputs` directory before running the **qmtraffic** script.

****Example****: Copy the MRIQC-generated group file from the 'proj1' project to the QMTools `inputs` directory:
```
  > cp ~/work/proj1/derivatives/mriqc/group_bold.tsv ~/work/qmtools/inputs
```

### **Step 2**: Run the **qmtraffic** Script

Each tool includes an associated script which runs the tool within the QMTools Docker container, and makes the appropriate subdirectories available to the container (via a Docker `bind mount`):

To produce a TrafficLight report, run the **qmtraffic** script at the command line, specifying the modality and the relative path to the MRIQC group file.

**Example**: Run the TrafficLight report for the previously copied MRIQC group file:
```
  > qmtraffic -v bold inputs/group_bold.tsv
```
***Note**: It is highly recommended to use the **verbose mode flag** (`-v` or `--verbose`) to produce informational messages while processing, unless you have a specific reason not to do so (such as running a QMTools script embedded within another script).*

If no problems are encountered while running the program, you should see status messages, such as these:
```
  > qmtraffic -v bold inputs/group_bold.tsv
(qmtraffic): Processing MRIQC group file 'inputs/group_bold.tsv' with modality 'bold'.
(qmtraffic): Produced reports in reports directory 'reports'.
(qmtraffic): To see the report: open 'reports/bold.html' in a browser.
```

### Getting Usage Help for a Tool

To see a help (usage) message for a QMTool, call the tool script with the special ***help flag*** (`-h` or `--help`):
```
  > qmtraffic -h

usage: qmtraffic [-h] [-v] {bold,T1w,T2w} group_file

Normalize an MRIQC group file and produce HTML reports.

positional arguments:
  {bold,T1w,T2w}  Modality of the MRIQC group file. Must be one of: ['bold', 'T1w', 'T2w']
  group_file      Path to an MRIQC group file (.tsv) to visualize.

optional arguments:
  -h, --help      show this help message and exit
  -v, --verbose   Print informational messages during processing [default: False (non-verbose mode)].
```

### **Step 3**: View the Output Data and/or Reports

When run in Verbose mode (using the `-v` or `--verbose` flag), QMTools which produce reports will show the path to the HTML report file, which can then be opened in a browser window. Tools which fetch or create data files will display the path to the directory containing those files.

The TrafficLight program produces its report in the `reports` subdirectory. The report may then be displayed in a browser by opening the HTML file named with the modality that was specified when creating the reports (i.e, 'bold.html', 't1w.html', or 't2w.html').

**Example**: View the TrafficLight report generated in Step 2 above:
```
  > open reports/bold.html
```

***Note!: Each time you run a TrafficLight report with the same modality, it overwrites any previous report with the same modality.** Be sure to copy (or move) the HTML and supporting files (.html, .png, and .tsv) for any reports you wish to save before re-running the TrafficLight report with the same modality.*

## License

This software is licensed under Apache License Version 2.0.

Copyright (c) The University of Arizona, 2021. All rights reserved.

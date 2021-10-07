# QMTools Query Parameters Files

**Authors**: [Tom Hicks](https://github.com/hickst) and [Dianne Patterson](https://github.com/dkp)

**About**: This document describes the *query parameters* files used by the [Fetcher](https://github.com/hickst/qmtools-support/blob/main/docs/Fetcher.md) tool of the [QMTools project](https://github.com/hickst/qmtools). Fetcher queries the MRIQC database server to fetch image quality metrics (IQMs) for images previously processed by neuroimaging groups all over the world. To make a content-specific query, Fetcher reads the query parameters from a query parameters file, located within the `queries` subdirectory. Criteria within the query parameters file may specify multiple provenance and image metadata parameters to filter the IQMs to be returned. Because Fetcher reads query parameters from user-created query parameters files, queries may be easily and consistently repeated.

The use of content-specific query parameters is a very powerful capability, potentially allowing insight into many of the factors which affect image quality. Using QMTools, in conjunction with the MRIQC server, allows image quality metrics to be queried and compared across a variety of BIDS metadata and provenance properties.

For more information about the IQM, provenance, and metadata fields provided by the MRIQC database server, and queryable by the **qmfetcher** program, see the `Models` section of the [MRQCI Web API](https://mriqc.nimh.nih.gov/) page.

## Query Parameters Files

### *TBD: To be completed soon. (claimed on 10/7/21 :)*

## License

This software is licensed under Apache License Version 2.0.

Copyright (c) The University of Arizona, 2021. All rights reserved.

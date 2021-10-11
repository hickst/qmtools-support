# QMTools Query Parameters Files

**Authors**: [Tom Hicks](https://github.com/hickst) and [Dianne Patterson](https://github.com/dkp)

**About**: This document describes the *query parameters* files used by the [Fetcher](https://github.com/hickst/qmtools-support/blob/main/docs/Fetcher.md) tool of the [QMTools project](https://github.com/hickst/qmtools). Fetcher queries the MRIQC database server to fetch image quality metrics (IQMs) for images previously processed by neuroimaging groups all over the world. To make a content-specific query, Fetcher reads query parameters from a query parameters file, located within the `queries` subdirectory. Criteria within the query parameters file may specify multiple provenance and image metadata parameters to filter the IQMs to be returned. Because Fetcher reads query parameters from user-created query parameters files, queries may be easily and consistently repeated.

The use of content-specific query parameters is a very powerful capability, potentially allowing insight into many of the factors which affect image quality. Using QMTools, in conjunction with the MRIQC server, allows image quality metrics to be queried and compared across a variety of IQM types, BIDS metadata, and provenance properties.

For a listing of the IQM, provenance, and BIDS metadata fields provided by the MRIQC database server, and queryable by the **qmfetcher** program, see the `Models` section of the [MRQCI Web API](https://mriqc.nimh.nih.gov/) page.

## Query Parameters Files

Without query parameters files, the [Fetcher](https://github.com/hickst/qmtools-support/blob/main/docs/Fetcher.md) program is limited to querying for a user-specified number of records with a given modality ('bold', 'T1w', or 'T2w'). The use of a query parameters file allows the user to specify an additional set of content-specific criteria that an IQM record must meet in order to be retrieved. The criteria in a query parameters file can select records based on the values of over 90 image quality metric fields, provenance fields, and BIDS metadata fields.

For a listing of the IQM, provenance, and BIDS metadata fields provided by the MRIQC database server, and queryable by the **qmfetcher** program, see the `Models` section of the [MRQCI Web API](https://mriqc.nimh.nih.gov/) page.

For an IQM record to be selected by a query, **it must meet all of the criteria** specified in a query parameters file (i.e., the criteria are logically *ANDed* together). While this restriction does limit the power of a query, it still allows many complex and interesting queries to be specified.

## Structure of a Query Parameters File

A query parameters file is a text file consisting of query criteria with one criterion per line. Blank lines and comment lines are allowed for readability but are ignored. Any line beginning with a number sign (#) is considered to be a comment line.

Each criterion consists of 3 fields: a keyword, a comparison operator, and a value. Each of these fields is separated by at least one space.

For example, here is a query parameters file containing two comments, a blank line, and two criteria:
```
# Two sample criteria, one per line, each with
# a space-separated keyword, operator, and value

snr <= 5.0
bids_meta.ManufacturersModelName == "Skyra"
```

### Criterion Keywords

The criterion keyword must be the name of an IQM metric field, or a provenance field, or a BIDS metadata field. All IQM field names are lower cased **and vary by modality** (see next paragraph). Provenance fields are also lower cased. However, **BIDS metadata field names are mixed cased** so they must be specified exactly as they are listed.

***Note**: As MRIQC metrics vary by modality, the IQM metric fields allowed in a query will be dependant on the modality of the query. Any query parameters file which contains a criterion based on an IQM should be considered modality-specific; used only in a query of that modality.*

To know what metadata fields are usable within a criterion, you should consult the `Models` section of the [MRQCI Web API](https://mriqc.nimh.nih.gov/) page. Click the right arrows, next to the modality you are interested in, to view the schema used by the database. Notice that `bids_meta`, `provenance`, and `provenance.settings` will need further expansion (using the right arrows) to view the nested schema fields. (Note: please ignore the `rating` fields: Fetcher is not able to query on them).

As you can see in the online schema, all BIDS metadata and provenance fields are *nested* within one or more parent fields (while IQM fields are not). When querying for these nested fields, **you must include the parent field names as prefixes, conjoined with a period**. For example, BIDS metadata fields are nested within a parent field called `bids_meta`. To specify a repetition time criterion, the keyword must be specified as `bids_meta.RepetitionTime`. Similarly, provenance fields are also nested (some of them two deep!) so you must also use a prefix path to specify them. For example: `provenance.md5sum` or `provenance.settings.fd_thres`

 ***Remember:** You must include `bids_meta.` as a prefix when querying for a BIDS metadata field and use the same case for the field name (keyword) as is given in the schema.*

### Criterion Operators

The valid comparison operators in a criterion are:
```
==   equals
!=   not equals
<    less than
<=   less than or equal to
>    greater than
>=   greater than or equal to
```

### Criterion Values

The third field of a criterion is the value (of the keyword-named field) to be queried for in the IQM records. As the database schema shows, these values are almost always strings, integers, or floats. For integers and floats, simple enter the value. **For strings, you must enclose the value within double quotes. Spaces and letter case in a quoted string are significant!** Remember to separate all values (quoted or not) from the operator by at least one space (outside any double quotes).

### Note on Contradictory Queries

**Warning**: Since the criteria of a query parameters file are logically *ANDed* together, it is possible to write queries with contradictory criteria, which will never select any IQM records. For example:
```
aor > 1
aor < 1
```
or, another example:
```
bids_meta.Manufacturer == "Siemens"
bids_meta.Manufacturer == "GE"
```

## License

This software is licensed under Apache License Version 2.0.

Copyright (c) The University of Arizona, 2021. All rights reserved.

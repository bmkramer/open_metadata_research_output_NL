# Coverage and quality of open metadata for Dutch research output
SQL code accompanying report **'Coverage and quality of open metadata for Dutch research output'**

These SQL scripts were used to select research outputs and collect relevant metadata.  
Not yet added are SQL scripts to calculate aggregated data underlying individual figures and tables in the report.

Report: https://doi.org/10.5281/zenodo.10629457  
Dataset: https://doi.org/10.5281/zenodo.11360571

The repository contains 2 SQL scripts:
* openalex_works_20231223_rpo_nl_2022.sql
* openaire_products_20240116_rpo_nl_2022.sql

These scripts are used to collect record-level data of research putput retrieved from OpenAlex and OpenAIRE, respectively, for all Dutch research performing organizations (RPOs) in scope of the pilot (UNL/NFU, NWO-i, KNAW, VH) for publication year 2022.

The pilot has made use of [Curtin Open Knowledge Initiative (COKI)](https://openknowledge.community/) infrastructure, which is documented on GitHub: https://github.com/The-Academic-Observatory. Here, a number of open data sources (including Crossref, OpenAlex and OpenAIRE) are ingested into a Google Big Query environment, which can then be queried via SQL.

In particular,the scripts use the following data sources:
- OpenAlex (data snapshot 2023-12-23), provided by OurResearch via Amazon AWS (see https://docs.openalex.org/download-all-data/openalex-snapshot), ingested by COKI in Google Big Query
- OpenAIRE (data snapshot 2024-01-16), provided by OpenAIRE via [Zenodo](https://doi.org/10.5281/zenodo.10488385) , ingested by COKI in Google Big QUery
- list of identifiers (ROR ID, OpenAlex ID, OpenAIRE ID) of Dutch research performing organisations - included in [project dataset](https://doi.org/10.5281/zenodo.11360571)


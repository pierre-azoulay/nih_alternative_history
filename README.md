# What if the NIH had been 40% smaller? An Alternative History — Replication Package

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17065831.svg)](https://doi.org/10.5281/zenodo.17065831)
[![Release](https://img.shields.io/badge/release-v0.0.1-blue)](https://github.com/pierre-azoulay/nih_alternative_history/releases/tag/v0.0.1)
[![Language](https://img.shields.io/badge/language-Stata-1f7a8c)](https://www.stata.com/)
[![License (data/text)](https://img.shields.io/badge/license-CC%20BY%204.0-lightgrey)](https://creativecommons.org/licenses/by/4.0/)
[![Code License](https://img.shields.io/badge/code%20license-MIT-brightgreen)](https://opensource.org/licenses/MIT)

**Authors:** Pierre Azoulay (MIT & NBER) [ORCID: 0000-0001-6511-4824](https://orcid.org/0000-0001-6511-4824), Matthew Clancy (Open Philanthropy) [ORCID: 0000-0001-7177-1038](https://orcid.org/0000-0001-7177-1038), Danielle Li (MIT & NBER), Bhaven N. Sampat (Johns Hopkins University & NBER) [ORCID: 0000-0001-7387-6706](https://orcid.org/0000-0001-7387-6706)

**Repository:** [https://github.com/pierre-azoulay/nih\_alternative\_history](https://github.com/pierre-azoulay/nih_alternative_history)

**First archived release:** v0.0.1 (alpha) — [https://github.com/pierre-azoulay/nih\_alternative\_history/releases/tag/v0.0.1](https://github.com/pierre-azoulay/nih_alternative_history/releases/tag/v0.0.1)

**Zenodo record:** [https://doi.org/10.5281/zenodo.17065831](https://doi.org/10.5281/zenodo.17065831)

---

## Overview

This repository contains the materials to reproduce the quantitative results for the article **“What if the NIH had been 40% smaller? An Alternative History.”** It includes the main Stata do-file and accompanying `.dta` files required to replicate the analysis and sensitivity checks.

> **Status:** This is an **alpha** replication package intended for early testers. Please open an Issue if you encounter problems.

---

## Contents

```
/ (repo root)
├── alternative_history.do              # Main Stata script to reproduce results (tables/graphs)
├── budget_cut_sensitivity_analysis.dta # Input data: sensitivity analysis
├── sustained_rdm.dta                   # Input data: sustained RDM analysis
├── README.md                           # (this file)
├── tables/                             # ✳️ Created by the .do file; tables written here
└── graphs/                             # ✳️ Created by the .do file; figures written here
```

---

## Quick start (Stata)

1. **Clone or download** this repository and unzip it.
2. **Open Stata 19.5** on **Windows 11** (the environment we tested).
3. **Set the working directory** to the repository root by declaring the Stata global macro F9, e.g.:

   ```stata
   global F9 "path/to/nih_alternative_history/replication/"
   ```
4. **Run the master script**:

   ```stata
   do alternative_history.do
   ```
5. Outputs (tables/figures) will be written to `./tables` and `./graphs`.

> Typical runtime: **< 30 secons** on a standard desktop.

---

## What the code produces

The master do-file generates replication outputs corresponding to the main manuscript tables and figures.

| Publication item                 | Where produced                                | Output location |
| -------------------------------- | --------------------------------------------- | --------------- |
| Table 1                          | `alternative_history.do` (main specification) | `tables/`       |
| Table 2                          | `alternative_history.do` (main specification) | `tables/`       |
| Figure S1                        | `alternative_history.do` (relevant sections)  | `graphs/`       |
| Figure S2                        | `alternative_history.do` (relevant sections)  | `graphs/`       |
| Figure S3                        | `alternative_history.do` (relevant sections)  | `graphs/`       |

> File names are determined within the do-file.

---

## Software & package requirements

* **Stata**: **19.5** (tested).
* **Operating system**: **Windows 11** (tested).
* **Ado-packages**: **None required** beyond base Stata (no third‑party ado packages used).

---

## Data

This package includes two Stata datasets used by the analysis:

* `budget_cut_sensitivity_analysis.dta` — main analysis file.
* `sustained_rdm.dta` — generates Figure S3 (budget cut sensitivity analysis).

> **IMPORTANT NOTE:**
> NIH priority scores are NOT public information, and were provided to one of the authors under a confidentiality agreement. The scores provided in these data are random draws from the empirical distribution of actual scores, they are not actual scores. As a result, the data and Stata code below can be used to replicate the numbers in Tables 1 & 2 in the main manuscript, but they cannot and should not be used to identify which specific drug would be affected by an hypothetical NIH budget cut. Because the scores are randomly generated, the results differ slightly from those that can be observed in Tables 1 and 2, but are qualitatively similar.

### Data dictionary (variables in supplied `.dta` files)

| Variable                          | Label                                                                             | Provenance |
| --------------------------------- | --------------------------------------------------------------------------------- | ---------- |
| nb\_linked\_patents               | Number of Linked Pre-approval Patents                                             | USPTO PatentsView, IMPACII, Ouellette & Sampat (2024)        |
| nb\_linked\_rdm\_ffctd\_patents   | Number of Linked & Affected Pre-approval Patents                                  | USPTO PatentsView, IMPACII, Ouelette & Sampat (2024)        |
| nb\_patents\_ttl                  | Number of Pre-approval Patents                                                    | FDA Orange Book        |
| frac\_linked\_patents             | Fraction of Pre-approval Patents Linked                                           | USPTO PatentsView, IMPACII, Ouellette & Sampat (2024)        |
| frac\_linked\_rdm\_ffctd\_patents | Fraction of Pre-approval Patents Linked & Affected                                | USPTO PatentsView, IMPACII, Ouellette & Sampat (2024)        |
| priority                          | Priority Review                                                                   | FDA Orange Book        |
| standard                          | Standard Review                                                                   | FDA Orange Book        |
| kpss\_drct                        | KPSS Patent Value (in \$ millions, direct linkages)                               | Kogan et al. (2017) extended to 2023         |
| kpss\_ndrct                       | KPSS Patent Value (in \$ millions, indirect linkages)                             | Kogan et al. (2017) extended to 2023        |
| direct\_link                      | Directly Linked (at least one grant)                                              | USPTO PatentsView, IMPACII, Ouellette & Sampat (2024)        |
| indirect\_link                    | Indirectly Linked (at least one grant)                                            | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| nb\_linked\_rdm\_ffctd\_projects  | Nb. of Supporting Affected Grants, direct linkages                                | USPTO PatentsView, IMPACII, Ouellette & Sampat (2024)         |
| nb\_sprtng\_grants\_drct          | Nb. of Supporting NIH grants (direct linkages)                                    | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| sprtng\_grant\_amount\_drct       | Supporting Grant Amounts (in \$ Millions, direct linkages)                        | USPTO PatentsView, IMPACII, Ouellette & Sampat (2024)        |
| nb\_sprtng\_grants\_ndrct         | Nb. of Supporting NIH grants (Indirect linkages)                                  | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| sprtng\_grant\_amount\_ndrct      | Supporting Grant Amounts (in \$ Millions, Indirect linkages)                      | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| approval\_yr                      | Approval Year                                                                     | FDA Orange Book        |
| nb\_pubs\_ttl                     | Nb. of Cited Publications                                                         | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| nb\_pubs\_nlnkd                   | Nb. of Unlinked Cited Publications                                                | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| nb\_pubs\_ylnkd                   | Nb. of NIH-Linked Cited Publications                                              | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| nb\_linked\_rdm\_ffctd\_pubs      | Nb. of NIH-Linked Counterfactually Cut Publications                               | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| actv\_ngrdnt                      | Active Ingredient                                                                 | FDA Orange Book        |
| trade\_name                       | Brand Name                                                                        | FDA Orange Book        |
| affctd\_drct                      | Counterfactually Cut \[Direct Linkage]                                            | USPTO PatentsView, IMPACII, Ouellette & Sampat (2024)        |
| affctd\_ndrct                     | Counterfactually Cut \[Indirect Linkage]                                          | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| affctd\_ndrct25                   | Counterfactually Cut \[Indirect Linkage, >25%]                                    | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| frac\_any\_nih                    | % of publications acknowledging NIH support                                       | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| frac\_linked\_rdm\_ffctd\_pubs    | Fraction of counterfactually cut publications (denom. is NIH-linked publications) | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |
| frac\_ttl\_rdm\_ffctd\_pubs       | Fraction of counterfactually cut publications (denom. is all cited publications)  | USPTO PatentsView, IMPACII, Marx & Fuegi (2022)        |

---

## Reproducibility notes

* **Randomness / seeds:** If any step relies on randomization or bootstrapping, the do-file sets a deterministic seed (*TBD*).
* **Run time:** **< 1 minute** on a standard desktop.
* **Order of execution:** `alternative_history.do` is a self-contained master script; it loads the included `.dta` files and writes outputs to `tables/` and `graphs/`.
* **Directories:** Ensure `tables/` and `graphs/` exist before execution (see Quick start).

---

## How to cite

Please cite **both** the manuscript and this replication package:

**Manuscript**
Azoulay, Pierre; Matthew Clancy; Danielle Li; Bhaven N. Sampat (2025). *What if the NIH had been 40% smaller? An Alternative History*. Manuscript under review at **Science**.

**Replication package**
Azoulay, Pierre; Clancy, Matthew; Li, Danielle; Sampat, Bhaven N. (2025). *Replication package for “What if the NIH had been 40% smaller? An Alternative History”*. Zenodo. [https://doi.org/10.5281/zenodo.17065831](https://doi.org/10.5281/zenodo.17065831)

**BibTeX (replication package):**

```bibtex
@software{azoulay2025nih_alt_history_replication,
  author    = {Azoulay, Pierre and Clancy, Matthew and Li, Danielle and Sampat, Bhaven N.},
  title     = {Replication package for "What if the NIH had been 40% smaller? An Alternative History"},
  year      = {2025},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.17065831},
  url       = {https://doi.org/10.5281/zenodo.17065831}
}
```

---

## License

* **Data and text** in this repository are released under **Creative Commons Attribution 4.0 International (CC BY 4.0)**.
* **Code** is released under the **MIT License**.

See [https://creativecommons.org/licenses/by/4.0/](https://creativecommons.org/licenses/by/4.0/) for CC BY 4.0 terms and [https://opensource.org/licenses/MIT](https://opensource.org/licenses/MIT) for MIT terms.

---

## Contributing & support

* Please use **GitHub Issues** for bug reports or replication questions.
* For direct correspondence (corresponding author): **[pazoulay@mit.edu](mailto:pazoulay@mit.edu)**.

---

## Versioning & provenance

* Current version: **v0.0.1 (alpha)**.
* Archived at Zenodo with DOI badge above; Software Heritage archival link is recorded in the Zenodo metadata.
* A full **changelog** will be maintained in `CHANGELOG.md` as releases progress to v1.0 on publication.

---

## Acknowledgments

No external funding or data provider acknowledgments to report.

---

## Checklist (for replicators)

* [ ] Stata 19.5 installed on Windows 11 (or compatible version/OS).
* [ ] No third‑party ado-packages required.
* [ ] Repository cloned and working directory set to repo root.
* [ ] `tables/` and `graphs/` directories exist (or created via Stata commands in Quick start).
* [ ] `do alternative_history.do` completes without error in < 1 minute.
* [ ] Outputs appear under `tables/` and `graphs/` and match the manuscript tables/figures.

---

## Frequently asked questions (FAQ)

**Q:** I get `command reghdfe is unrecognized`.

**A:** Install the ado from SSC: `ssc install reghdfe, replace`, restart Stata, and re-run the script.

**Q:** Where are the raw data?
**A:** This package includes the processed analysis datasets (`.dta`). If raw data or construction code is needed for transparency, we will add them under `/data_raw` and `/code/data_prep` with documentation.

**Q:** Can I reuse these materials?
**A:** Yes, under the CC BY 4.0 terms for data/text. Code license is specified above (once finalized).

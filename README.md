# RNAseq_R_Analysis
A NCBI-GEO reproduction study of differential gene expression analysis using R on GEO datasets to identify highly dysregulated genes between case and control samples.
# RNA-seq Differential Expression Analysis Pipeline (DESeq2)

Dataset analyzed:

* GEO Accession: GSE253495
* Data type: RNA-seq count matrix
* Analysis framework: DESeq2

---

## Objectives

The primary objectives of this workflow are:

* Import and process RNA-seq count data
* Remove lowly expressed genes
* Normalize count data
* Identify differentially expressed genes (DEGs)
* Visualize expression patterns and sample clustering
* Export reproducible results for downstream biological interpretation

---

## Workflow

### 1. Data Import

* Download raw RNA-seq count matrix from GEO
* Download gene annotation information
* Construct expression matrix (genes × samples)
* Verify sample integrity

### 2. Metadata Preparation

* Define experimental groups
* Create sample information table
* Match sample metadata to count matrix

### 3. Gene Filtering

* Remove low-expression genes
* Retain genes with sufficient read support for statistical analysis

### 4. Differential Expression Analysis

* Create DESeqDataSet object
* Estimate size factors and dispersions
* Fit negative binomial model
* Perform Wald statistical testing
* Apply False Discovery Rate (FDR) correction

### 5. Visualization

Generated figures include:

* Dispersion plot
* Adjusted p-value distribution
* MD plot
* UMAP sample clustering

### 6. Export Results

The workflow exports:

* Top differentially expressed genes
* Normalized count matrix
* Quality control plots
* Session information for reproducibility

---
## Software and Packages

* R (≥ 4.2)
* DESeq2
* data.table
* ggplot2
* umap

---

<div align="center">
  <img src="https://github.com/amamina/GeneExpression_RNAseq_Analysis/blob/280f18e9aab5d8c345cfa2bbce9fd5e637ae1d38/Results/plots/box_and_whisker_plot.png?raw=true" width="700">
  <br>
  <b>Pathogenicity score threshold</b>
</div>


<div align="center">
  <img src="https://github.com/amamina/GeneExpression_RNAseq_Analysis/blob/280f18e9aab5d8c345cfa2bbce9fd5e637ae1d38/Results/plots/dispersion_plot.png?raw=true" width="700">
  <br>
  <b>Pathogenicity score threshold</b>
</div>

---

## Outputs

### Differential Expression Results

The main output is a ranked list of genes containing:

* Gene ID
* Log2 Fold Change
* Adjusted P-value (FDR)
* Base Mean Expression
* Statistical Test Results
* Gene Annotation

### Quality Control

Quality control analyses assess:

* Expression distribution
* Dispersion estimates
* Sample clustering patterns
* Potential outliers

---


## Reproducibility

All analyses were performed using a scripted workflow in R. Package versions and session information are provided to facilitate reproducibility.

---

## Author
Reproduced, documented, and interpreted by Amina Ayub.

## Reference:
	
López-Navarro B, Simón-Fuentes M, Ríos I, Schiaffino MT et al. Macrophage re-programming by JAK inhibitors relies on MAFB. Cell Mol Life Sci 2024 Mar 25;81(1):152. PMID: 38528207


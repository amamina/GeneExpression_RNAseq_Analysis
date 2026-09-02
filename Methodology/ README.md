Raw gene-level count data were obtained from the Gene Expression Omnibus (GEO) dataset GSE253495, using the NCBI-generated raw counts matrix aligned to the GRCh38.p13 reference genome, together with the corresponding gene annotation table. Data import and matrix construction were performed in R (v4.2 or later) using the data.table package.

Samples were assigned to experimental groups (case vs. control) according to a predefined group-encoding scheme. Prior to differential expression testing, low-abundance genes were removed by requiring a minimum count of 10 reads in at least as many samples as the size of the smallest group, reducing technical noise and improving the reliability of dispersion estimation.

Differential gene expression analysis was performed using DESeq2 (v1.x, Bioconductor). A DESeqDataSet object was constructed from the filtered count matrix and sample metadata, with group membership specified as the sole factor in the design formula (~ Group). Size factors were estimated using the "poscount" method, appropriate for count matrices containing genes with zero counts in some samples, and dispersions were estimated using DESeq2's default parametric fit. Statistical significance was assessed using the Wald test, and raw p-values were adjusted for multiple testing using the Benjamini-Hochberg (FDR) procedure at a significance threshold of α = 0.05. Differential expression results (log2 fold-change, mean expression, p-value, and adjusted p-value) were extracted for the case-vs-control contrast, ranked by adjusted p-value, and annotated with gene symbols and descriptions from the platform annotation file. The top 250 differentially expressed genes were exported for downstream interpretation.

Quality control of the model fit was assessed via dispersion plots (raw and fitted gene-wise dispersion estimates) and histograms of adjusted p-values. Global patterns of differential expression were visualized using volcano plots (log2 fold-change vs. −log10 adjusted p-value) and MA plots (log2 fold-change vs. log10 mean expression), with genes meeting a dual threshold of adjusted p < 0.05 and |log2 fold-change| > 1 highlighted as significantly differentially expressed.

To assess global sample-level clustering, normalized counts (variance-stabilized via log10(counts + 1) transformation of DESeq2-normalized values) were subjected to dimensionality reduction using Uniform Manifold Approximation and Projection (UMAP, default parameters), and samples were visualized in two-dimensional embedding space colored by experimental group.

All normalized count matrices, differential expression tables, and session information (package versions, R version) were saved for reproducibility, and a fixed random seed (123) was set at the start of the analysis.




























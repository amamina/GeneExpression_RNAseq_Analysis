.R
############################################################
# RNA-seq Differential Expression Pipeline (DESeq2)
# Dataset: GSE253495 (GEO)
# Language: R (>=4.2)
############################################################

############################
# 0. SETUP
############################

# Install packages only if missing (safe reproducibility block)
packages <- c("DESeq2", "data.table", "ggplot2", "umap", "BiocManager")

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# Load libraries
library(DESeq2)
library(data.table)
library(ggplot2)
library(umap)

# Set reproducibility seed
set.seed(123)

# Create output folders
dir.create("results", showWarnings = FALSE)
dir.create("figures", showWarnings = FALSE)

############################
# 1. LOAD DATA FROM GEO
############################

cat("\nLoading RNA-seq count data...\n")

urld <- "https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts"

counts_path <- paste(
  urld,
  "acc=GSE253495",
  "file=GSE253495_raw_counts_GRCh38.p13_NCBI.tsv.gz",
  sep="&"
)

tbl <- as.matrix(
  fread(counts_path, header = TRUE, data.table = FALSE),
  rownames = "GeneID"
)

cat("Counts matrix loaded: ", dim(tbl), "\n")

############################
# 2. LOAD ANNOTATION
############################

annot_path <- paste(
  urld,
  "type=rnaseq_counts",
  "file=Human.GRCh38.p13.annot.tsv.gz",
  sep="&"
)

annot <- fread(annot_path, header = TRUE, data.table = FALSE)
rownames(annot) <- annot$GeneID

cat("Annotation loaded: ", dim(annot), "\n")

############################
# 3. DEFINE SAMPLE GROUPS
############################

# Example encoding string (YOU MUST MODIFY based on dataset)
# 1 = case, 0 = control
gsms <- "101010"
sml <- strsplit(gsms, "")[[1]]

gs <- factor(sml)
groups <- make.names(c("control", "case"))
levels(gs) <- groups

sample_info <- data.frame(
  Group = gs,
  row.names = colnames(tbl)
)

cat("Groups defined:\n")
print(table(gs))

############################
# 4. FILTER LOW EXPRESSION GENES
############################

cat("\nFiltering low-expression genes...\n")

keep <- rowSums(tbl >= 10) >= min(table(gs))
tbl <- tbl[keep, ]

cat("Genes after filtering:", nrow(tbl), "\n")

############################
# 5. CREATE DESEQ2 OBJECT
############################

dds <- DESeqDataSetFromMatrix(
  countData = tbl,
  colData = sample_info,
  design = ~ Group
)

############################
# 6. RUN DESEQ2 MODEL
############################

cat("\nRunning DESeq2...\n")

dds <- DESeq(dds, test = "Wald", sfType = "poscount")

############################
# 7. EXTRACT RESULTS
############################

cat("\nExtracting results...\n")

res <- results(
  dds,
  contrast = c("Group", "case", "control"),
  alpha = 0.05,
  pAdjustMethod = "fdr"
)

res <- res[order(res$padj), ]

# Merge annotation
res_df <- as.data.frame(res)
res_df$GeneID <- rownames(res_df)

res_annot <- merge(res_df, annot, by = "GeneID", all.x = TRUE)

# Select top genes
top_genes <- head(res_annot, 250)

write.csv(top_genes, "results/top_DE_genes.csv", row.names = FALSE)

cat("Top DE genes saved.\n")

############################
# 8. QC PLOTS
############################

cat("\nGenerating QC plots...\n")

# Dispersion plot
pdf("figures/dispersion_plot.pdf")
plotDispEsts(dds, main = "Dispersion Estimates")
dev.off()

# Histogram of adjusted p-values
pdf("figures/padj_histogram.pdf")
hist(res$padj,
     breaks = seq(0, 1, length = 20),
     col = "grey",
     main = "Adjusted P-value Distribution",
     xlab = "padj")
dev.off()

############################
# 9. VOLCANO PLOT
############################

cat("\nCreating volcano plot...\n")

pdf("figures/volcano_plot.pdf")

plot(
  res$log2FoldChange,
  -log10(res$padj),
  pch = 20,
  cex = 0.5,
  main = "Volcano Plot",
  xlab = "Log2 Fold Change",
  ylab = "-log10 Adjusted P-value"
)

sig <- which(res$padj < 0.05 & abs(res$log2FoldChange) > 1)

points(
  res$log2FoldChange[sig],
  -log10(res$padj[sig]),
  col = "red",
  pch = 20,
  cex = 0.7
)

abline(h = -log10(0.05), col = "blue", lty = 2)

dev.off()

############################
# 10. MA PLOT
############################

cat("\nCreating MA plot...\n")

pdf("figures/MA_plot.pdf")

plot(
  log10(res$baseMean),
  res$log2FoldChange,
  pch = 20,
  cex = 0.5,
  main = "MA Plot",
  xlab = "Log10 Mean Expression",
  ylab = "Log2 Fold Change"
)

points(
  log10(res$baseMean[sig]),
  res$log2FoldChange[sig],
  col = "red",
  pch = 20,
  cex = 0.7
)

abline(h = 0)

dev.off()

############################
# 11. UMAP ANALYSIS
############################

cat("\nRunning UMAP...\n")

norm_counts <- log10(counts(dds, normalized = TRUE) + 1)

ump <- umap(t(norm_counts))

pdf("figures/UMAP_plot.pdf")

plot(
  ump$layout,
  col = gs,
  pch = 20,
  main = "UMAP Sample Clustering"
)

legend("topright", legend = levels(gs), col = 1:length(levels(gs)), pch = 20)

dev.off()

############################
# 12. EXPORT NORMALIZED MATRIX
############################

cat("\nSaving normalized counts...\n")

write.csv(
  norm_counts,
  "results/normalized_counts.csv"
)

############################
# 13. SESSION INFO 
############################

writeLines(capture.output(sessionInfo()),
           "results/sessionInfo.txt")

cat("\nPipeline completed successfully!\n")
```

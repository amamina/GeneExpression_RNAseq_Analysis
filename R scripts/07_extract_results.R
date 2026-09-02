# EXTRACT RESULTS


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


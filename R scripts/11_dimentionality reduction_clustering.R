# UMAP ANALYSIS

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



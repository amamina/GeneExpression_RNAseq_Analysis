# VOLCANO PLOT


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


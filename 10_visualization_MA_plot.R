# MA PLOT

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


# QC PLOTS


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


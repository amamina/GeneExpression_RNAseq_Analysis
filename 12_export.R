# EXPORT NORMALIZED MATRIX

cat("\nSaving normalized counts...\n")

write.csv(
  norm_counts,
  "results/normalized_counts.csv"
)


# FILTER LOW EXPRESSION GENES


cat("\nFiltering low-expression genes...\n")

keep <- rowSums(tbl >= 10) >= min(table(gs))
tbl <- tbl[keep, ]

cat("Genes after filtering:", nrow(tbl), "\n")


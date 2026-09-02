# 3. DEFINE SAMPLE GROUPS


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


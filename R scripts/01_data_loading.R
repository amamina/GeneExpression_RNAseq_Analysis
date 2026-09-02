
# 1. LOAD DATA FROM GEO


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

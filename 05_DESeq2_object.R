
# CREATE DESEQ2 OBJECT

dds <- DESeqDataSetFromMatrix(
  countData = tbl,
  colData = sample_info,
  design = ~ Group
)


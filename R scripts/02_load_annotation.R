
# 2. LOAD ANNOTATION


annot_path <- paste(
  urld,
  "type=rnaseq_counts",
  "file=Human.GRCh38.p13.annot.tsv.gz",
  sep="&"
)

annot <- fread(annot_path, header = TRUE, data.table = FALSE)
rownames(annot) <- annot$GeneID

cat("Annotation loaded: ", dim(annot), "\n")


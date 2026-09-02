# RUN DESEQ2 MODEL


cat("\nRunning DESeq2...\n")

dds <- DESeq(dds, test = "Wald", sfType = "poscount")


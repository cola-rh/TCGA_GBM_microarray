setwd("/omics/groups/OE0246/internal/guz/cola_hc/examples/TCGA_GBM_microarray")
library(cola)

library(RColorBrewer)

m = read.table("https://jokergoo.github.io/cola_examples/TCGA_GBM/unifiedScaled.txt", header = TRUE, row.names = 1, check.names = FALSE)
m = as.matrix(m)

subtype = read.table("https://jokergoo.github.io/cola_examples/TCGA_GBM/TCGA_unified_CORE_ClaNC840.txt", sep = "\t", header = TRUE, 
    check.names = FALSE, stringsAsFactors = FALSE)
subtype = structure(unlist(subtype[1, -(1:2)]), names = colnames(subtype)[-(1:2)])
subtype_col = structure(seq_len(4), names = unique(subtype))

m = m[, names(subtype)]
m = adjust_matrix(m)


library(preprocessCore)
cn = colnames(m)
rn = rownames(m)
m = normalize.quantiles(m)
colnames(m) = cn
rownames(m) = rn

rh = hierarchical_partition(m, cores = 4, anno = subtype, anno_col = subtype_col)
saveRDS(rh, file = "TCGA_GBM_microarray_cola_rh.rds")


cola_report(rh, output = "TCGA_GBM_microarray_cola_rh_report", title = "cola Report for Hierarchical Partitioning - 'TCGA_GBM_microarray'")

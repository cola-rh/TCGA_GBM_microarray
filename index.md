
## Hierarchical consensus partitioning analysis on dataset 'TCGA_GBM_microarray'

Runnable code:

```r
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
```

[The HTML report is here.](https://cola-rh.github.io/TCGA_GBM_microarray/TCGA_GBM_microarray_cola_rh_report/cola_hc.html) (generated by __cola__ version 2.0.0, R 4.1.0.)

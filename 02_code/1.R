<<<<<<< HEAD
maf <- read.maf("H:/20240322-WN-WES-MOLM13-MV4-11-OCI-AML2-VENE/03.Result_X101SC24030727-Z02-J001_cancer/03.Result_X101SC24030727-Z02-J001_cancer/result/Maf/Somatic_mutation.maf")
library("maftools")
View(maf)
maf
write.mafSummary(maf, basename = 'wn')

#样本注释
getClinicalData(maf)
#查看每个样品的总结情况
getSampleSummary(maf)
#查看基因情况
getGeneSummary(maf)
#查看可用信息
getFields(maf)

plotmafSummary(maf,rmOutlier = TRUE,addStat = "median",dashboard = TRUE,titvRaw = FALSE)


#oncoplot for top ten mutated genes.
oncoplot(maf = maf, top = 50,showTumorSampleBarcodes = TRUE,barcode_mar=8,gene_mar=10)

clinicalData <- read.table("H:/Rstudio/20240327_wn_wes/wn_clinicalData.txt",header = T,sep = "\t")
View(clinicalData)
clinicalData <- clinicalData[,-2]
maf <- read.maf("H:/20240322-WN-WES-MOLM13-MV4-11-OCI-AML2-VENE/03.Result_X101SC24030727-Z02-J001_cancer/03.Result_X101SC24030727-Z02-J001_cancer/result/Maf/Somatic_mutation.maf",
                clinicalData = clinicalData)

#Extract data for samples 'TCGA.AB.3009' and 'TCGA.AB.2933' (Printing just 5 rows for display convenience)
MOLM13_cas_2w_2 <- subsetMaf(maf, tsb = c("MOLM13_cas_2w_2"), mafObj = FALSE)
write.mafSummary(MOLM13_cas_2w_2, basename = "MOLM13_cas_2w_2")

MOLM13_cas_2w_2




plotmafSummary(maf,rmOutlier = TRUE,addStat = "median",dashboard = TRUE,titvRaw = FALSE,showBarcodes = TRUE)



dev.off()
pdf(file = "plot.pdf",
    height = 10,
    width = 10
)

plotmafSummary(maf,rmOutlier = TRUE,addStat = "median",dashboard = TRUE,titvRaw = FALSE,showBarcodes = TRUE)

dev.off()

dev.off()
pdf(file = "MOLM13-oncoplot.pdf",
    height = 10,
    width = 10
)
#oncoplot for top ten mutated genes.
oncoplot(maf = maf, top = 50
         ,sampleOrder = c("MOLM13_cas_2w_2","MOLM13_cas_2w_3","MOLM13_cas_6w_1","MOLM13_cas_6w_3","MOLM13_cas_6w_2","MOLM13_VR_cas9",
                          "OCI_M2_cas_2w_2","OCI_M2_cas_2w_3","OCI_M2_cas_2w_1","OCI_M2_cas_4w_2","OCI_M2_cas_6w_3",
                          "OCI_M2_cas_6w_1","OCI_M2_cas_6w_2","MV4_11_cas_2w_3","MV4_11_cas_2w_1","MV4_11_cas_2w_2","MV4_11_cas_6w_3","MV4_11_cas_6w_1","MV4_11_cas_6w_2"),
         barcode_mar=8,gene_mar=10,showTumorSampleBarcodes = TRUE)
dev.off()

#Using longer transcript NM_000546 for now.
lollipopPlot(maf, gene ="TP53", AACol = "AAchange",showMutationRate = TRUE)

names(maf)

#oncostrip(maf, genes = c("TP53","smarca4","arid2","atm","birc3","card11","traf2","notch1","notch2"))


rainfallPlot(maf, detectChangePoints = TRUE, pointSize = 0.6)


Interact <- somaticInteractions(maf, top = 50,pvalue = c(0.05, 0.1))
OncogenicPathways(maf)
OncogenicPathways(maf)




MOLM13_cas <- subsetMaf(maf, tsb = c("MOLM13_cas_2w_2","MOLM13_cas_2w_3","MOLM13_cas_6w_1","MOLM13_cas_6w_3","MOLM13_cas_6w_2","MOLM13_VR_cas9"), mafObj = FALSE)
write.mafSummary(MOLM13_cas, basename = "MOLM13_cas")











=======
maf <- read.maf("H:/20240322-WN-WES-MOLM13-MV4-11-OCI-AML2-VENE/03.Result_X101SC24030727-Z02-J001_cancer/03.Result_X101SC24030727-Z02-J001_cancer/result/Maf/Somatic_mutation.maf")
library("maftools")
View(maf)
maf
write.mafSummary(maf, basename = 'wn')

#样本注释
getClinicalData(maf)
#查看每个样品的总结情况
getSampleSummary(maf)
#查看基因情况
getGeneSummary(maf)
#查看可用信息
getFields(maf)

plotmafSummary(maf,rmOutlier = TRUE,addStat = "median",dashboard = TRUE,titvRaw = FALSE)


#oncoplot for top ten mutated genes.
oncoplot(maf = maf, top = 50,showTumorSampleBarcodes = TRUE,barcode_mar=8,gene_mar=10)

clinicalData <- read.table("H:/Rstudio/20240327_wn_wes/wn_clinicalData.txt",header = T,sep = "\t")
View(clinicalData)
clinicalData <- clinicalData[,-2]
maf <- read.maf("H:/20240322-WN-WES-MOLM13-MV4-11-OCI-AML2-VENE/03.Result_X101SC24030727-Z02-J001_cancer/03.Result_X101SC24030727-Z02-J001_cancer/result/Maf/Somatic_mutation.maf",
                clinicalData = clinicalData)

#Extract data for samples 'TCGA.AB.3009' and 'TCGA.AB.2933' (Printing just 5 rows for display convenience)
MOLM13_cas_2w_2 <- subsetMaf(maf, tsb = c("MOLM13_cas_2w_2"), mafObj = FALSE)
write.mafSummary(MOLM13_cas_2w_2, basename = "MOLM13_cas_2w_2")

MOLM13_cas_2w_2




plotmafSummary(maf,rmOutlier = TRUE,addStat = "median",dashboard = TRUE,titvRaw = FALSE,showBarcodes = TRUE)



dev.off()
pdf(file = "plot.pdf",
    height = 10,
    width = 10
)

plotmafSummary(maf,rmOutlier = TRUE,addStat = "median",dashboard = TRUE,titvRaw = FALSE,showBarcodes = TRUE)

dev.off()

dev.off()
pdf(file = "MOLM13-oncoplot.pdf",
    height = 10,
    width = 10
)
#oncoplot for top ten mutated genes.
oncoplot(maf = maf, top = 50
         ,sampleOrder = c("MOLM13_cas_2w_2","MOLM13_cas_2w_3","MOLM13_cas_6w_1","MOLM13_cas_6w_3","MOLM13_cas_6w_2","MOLM13_VR_cas9",
                          "OCI_M2_cas_2w_2","OCI_M2_cas_2w_3","OCI_M2_cas_2w_1","OCI_M2_cas_4w_2","OCI_M2_cas_6w_3",
                          "OCI_M2_cas_6w_1","OCI_M2_cas_6w_2","MV4_11_cas_2w_3","MV4_11_cas_2w_1","MV4_11_cas_2w_2","MV4_11_cas_6w_3","MV4_11_cas_6w_1","MV4_11_cas_6w_2"),
         barcode_mar=8,gene_mar=10,showTumorSampleBarcodes = TRUE)
dev.off()

#Using longer transcript NM_000546 for now.
lollipopPlot(maf, gene ="TP53", AACol = "AAchange",showMutationRate = TRUE)

names(maf)

#oncostrip(maf, genes = c("TP53","smarca4","arid2","atm","birc3","card11","traf2","notch1","notch2"))


rainfallPlot(maf, detectChangePoints = TRUE, pointSize = 0.6)


Interact <- somaticInteractions(maf, top = 50,pvalue = c(0.05, 0.1))
OncogenicPathways(maf)
OncogenicPathways(maf)




MOLM13_cas <- subsetMaf(maf, tsb = c("MOLM13_cas_2w_2","MOLM13_cas_2w_3","MOLM13_cas_6w_1","MOLM13_cas_6w_3","MOLM13_cas_6w_2","MOLM13_VR_cas9"), mafObj = FALSE)
write.mafSummary(MOLM13_cas, basename = "MOLM13_cas")











>>>>>>> 80855322ed9fbc71c46a0a4d3cbbd80330870682

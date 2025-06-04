
# Packages ----
library(maftools)

# Data input ----
maf <- read.maf("./01_data/Somatic_mutation.maf")
write.mafSummary(maf, basename = './01_data/Venetoclax Resistance')

#样本注释
getClinicalData(maf)
#查看每个样品的总结情况
getSampleSummary(maf)
#查看基因情况
getGeneSummary(maf)
#查看可用信息
getFields(maf)

# Group input ----
clinicalData <- read.table("01_data/Venetoclax Resistance_clinicalData.txt",header = T,sep = "\t")
maf <- read.maf("01_data/Somatic_mutation.maf",clinicalData = clinicalData)

# 过滤不需要信息
samples_to_remove <- c("MOLM13_VR_cas9")   # 要移除的样本
maf_clean <- subsetMaf(maf = maf,                    
                       tsb = samples_to_remove,      # Tumor Sample Barcode
                       include = FALSE,              # 表示从数据中排除该样本
                       mafObj = TRUE)                # 返回MAF 对象

getSampleSummary(maf_clean)


# MAF Summary ----
pdf(file = "03_result/Maf Summary.pdf", height = 6.7, width = 9.6)
plotmafSummary(maf, rmOutlier = TRUE, addStat = "median",
               dashboard = TRUE, titvRaw = FALSE,
               showBarcodes = TRUE, textSize = 0.5)
dev.off()

# Oncoplot top 30 ----
pdf('03_result/oncoplot_top30.pdf', width = 9.35, height = 7.45)
oncoplot(maf = maf,
         top = 30, # 绘制前 30 个变异
         fontSize=0.5,
         sampleOrder = maf@clinical.data$Tumor_Sample_Barcode, # 样本的排序顺序
         showTumorSampleBarcodes = T,                          # 显示肿瘤样本的名称
         barcodeSrt = 45, barcode_mar=8, gene_mar=10,)
dev.off()

# Lollipoplot ----
pdf("03_result/TP53_lollipoplot.pdf", width = 6, height = 5)
lollipopPlot(maf, gene ="TP53",          # 默认使用最长的转录本
             AACol = "AAchange",         # 显示的氨基酸改变信息的列
             showMutationRate = TRUE,
             labelPos = 'all')
dev.off()

# VAF plot ----
library(ggplot2)
library(dplyr)
library(ggrepel) # 避免标签重叠

# 提取 TP53 的突变记录
tp53_mut <- subset(maf@data, Hugo_Symbol == "TP53")
tp53_mut$Tumor_Sample_Barcode <- gsub("cas_", "" ,tp53_mut$Tumor_Sample_Barcode)

# 查看结果
head(tp53_mut[, c("Tumor_Sample_Barcode", "Hugo_Symbol", "t_alt_count", "t_ref_count", "t_AF")])

# 按 VAF 排序样本
tp53_mut <- tp53_mut %>%
  arrange(desc(t_AF)) %>%
  mutate(Tumor_Sample_Barcode = factor(Tumor_Sample_Barcode, levels = unique(Tumor_Sample_Barcode)))

## spot plot ----
pdf("03_result/TP53_VAF_Spotplot.pdf", width = 6, height = 5)
ggplot(tp53_mut, aes(x = Tumor_Sample_Barcode, y = t_AF, color = Variant_Classification)) +
  geom_point(size = 3, alpha = 1) +
  geom_text_repel(aes(label = round(t_AF, 2)), size = 3, show.legend = FALSE) +
  scale_y_continuous(limits = c(0, 1), expand = c(0, 0.05)) +
  #scale_color_brewer(palette = "Set5") +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(hjust = 0.5, family = "sans" , face = "bold"),
        aspect.ratio = 1.2,
        axis.text.x = element_text(angle = 45, hjust = 1),
        # 图例标题 
        legend.title = element_text(
          family = "serif",        # 字体类型（如serif衬线体）
          size = 10,               # 字体大小
          face = "bold",           # 加粗
          color = "#333333",       # 深灰色
          margin = margin(b = 5)   # 标题与标签的间距
        ),
        
        # 图例标签 
        legend.text = element_text(
          family = "sans",         # 无衬线字体（如Arial）
          size = 9,               
          color = "#666666",       # 中灰色
          margin = margin(r = 10)))+ # 标签右侧间距
        #panel.grid.major.x = element_blank()) 
  labs(title = "TP53 Mutation VAF",
       x = NULL,
       y = "Variant Allele Frequency",
       color = "Mutation Type")
dev.off()

## bar plot ----
ggplot(tp53_mut, aes(x = Tumor_Sample_Barcode, y = t_AF, fill = Variant_Classification)) +
  geom_col(width = 0.6) +
  scale_fill_brewer(palette = "Set1") +
  theme_minimal(base_size = 12) +
  labs(title = "TP53 Mutation VAF per Sample",
       x = NULL,
       y = "VAF") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## lollipop plot ----
ggplot(tp53_mut, aes(x = Tumor_Sample_Barcode, y = t_AF, color = Variant_Classification)) +
  geom_segment(aes(xend = Tumor_Sample_Barcode, y = 0, yend = t_AF), size = 1) +
  geom_point(size = 3) +
  scale_y_continuous(limits = c(0, 1), expand = c(0, 0.05)) +
  theme_minimal(base_size = 12) +
  labs(title = "TP53 Mutation VAF",
       x = NULL,
       y = "Variant Allele Frequency",
       color = "Mutation Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


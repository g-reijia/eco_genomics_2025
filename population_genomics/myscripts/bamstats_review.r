# Reviewing our bam stats

getwd()
setwd ("population_genomics/myresults/")

stats <- read.table("2100.stats.txt", header=TRUE, sep= "")

View(stats)

stats$pctPaired = stats$Num_Paired/stats$Num_reads


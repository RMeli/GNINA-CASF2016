
rm(list=ls());
require(boot);
data_all<-read.table("analysis/outputs/ranking/amberopt/default_CNNaffinity_Spearman.results",header=FALSE);
data<-as.matrix(data_all[,2]);
mymean<-function(x,indices) sum(x[indices])/57;
data.boot<-boot(data,mymean,R=10000,stype="i",sim="ordinary");
sink("analysis/outputs/ranking/amberopt/default_CNNaffinity_Spearman-ci.results");
a<-boot.ci(data.boot,conf=0.9,type=c("bca"));
print(a);
sink();

=========================================================================

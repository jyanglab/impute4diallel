
setwd("~/Documents/PyCodes/impute4diallel")
### testing 
python impute4diallel_v1.1.py -h

######
info <- read.table("/mnt/02/yangjl/DBcenter/VariationDB/merged/snp_merged_chr10.info", header=T)
dsf <- read.table("/mnt/02/yangjl/DBcenter/VariationDB/merged/snp_merged_chr10.dsf", header=T)

test <- merge(info, dsf[,-2:-3], by="snpid")
test1k <- test[1:1000,]
write.table(test1k, "~/Documents/PyCodes/impute4diallel/test1000.dsf8", sep="\t",
            row.names=FALSE, quote=FALSE)

python impute4diallel_v1.1.py -d ped_nam.txt -i test1000.dsf8 -o snptest.out -s 9 \
-e 35 --header no -m 2


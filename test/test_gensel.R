# Jinliang Yang
# 7/12/2014
# test code for impute4diallel.py



### testing 
python impute4diallel_v0.3.py -h
python impute4diallel_v0.3.py -d ped.txt -i test1000_samid.dsf -o test.out -s 6 -e 385 --header yes -m 0

######
test <- read.table("~/Documents/PyCodes/impute4diallel/test.out", header=TRUE)
test <- as.data.frame(t(test))
nm <- as.vector(test[1,])
names(test) <- nm
test <- test[-1,]

#### F1 imputation using R
dsf <- read.table("~/Documents/PyCodes/impute4diallel/test1000_samid.dsf", header=T)
ped <- read.table("~/Documents/PyCodes/impute4diallel/ped.txt", header=T)

f1 <- impute(ped=ped, row=2)
f1t <- merge(f1, test, by.x="snpid", by.y="row.names")
f1t$SAM18xSAM27 <- as.numeric(as.character(f1t$SAM18xSAM27))
f1t$comp <- f1t$F1!=f1t$SAM18xSAM27
subset(f1t, comp == TRUE)
sum(f1t$F1!=f1t$SAM18xSAM27)

### PASSED test!!!!


impute <- function(ped=ped, row=1){
  p1 <- ped$p1[row]
  p2 <- ped$p2[row]
  mydsf <- dsf[, c("snpid", "major", "minor", p1, p2)]
  # major=10, minor=-10 and missing, heter=0
  mydsf$F1 <- -9
  for(i in 1:nrow(mydsf)){
    snp1 = mydsf[i, 4];
    snp2 = mydsf[i, 5];
    major = mydsf[i, "major"];
    minor = mydsf[i, "minor"]
    if(snp1 == major & snp2 == major){
      mydsf$F1[i] = 10
    }else if(snp1 == major & snp2 == minor){
      mydsf$F1[i] = 0
    }else if(snp1 == major & snp2 == "N"){
      mydsf$F1[i] = 5
    }else if(snp1 == minor & snp2 == major){
      mydsf$F1[i] = 0
    }else if(snp1 == minor & snp2 == minor){
      mydsf$F1[i] = -10
    }else if(snp1 == minor & snp2 == "N"){
      mydsf$F1[i] = -5
    }else if(snp1 == "N" & snp2 == major){
      mydsf$F1[i] = 5
    }else if(snp1 == "N" & snp2 == minor){
      mydsf$F1[i] = -5
    }else if(snp1 == "N" & snp2 == "N"){
      mydsf$F1[i] = 0
    }else{
      stop("wrong genotypeing!")
    }
    message(i)
  }
  return(mydsf)
}










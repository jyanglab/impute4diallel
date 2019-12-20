# Jinliang Yang
# 7/12/2014
# test code for impute4diallel.py
## test with dominant model


### testing 
python impute4diallel_v1.2.py -h
python impute4diallel_v1.2.py -d ped.txt -i test1000_nam.dsf5 -o test.out -s 9 -e 35 --header yes -m 4

######
test <- read.table("~/Documents/PyCodes/impute4diallel/test.out", header=TRUE)
test <- as.data.frame(t(test))
nm <- as.vector(test[1,])
names(test) <- nm
test <- test[-1,]

#### F1 imputation using R
dsf <- read.table("~/Documents/PyCodes/impute4diallel/test1000_nam.dsf5", header=T)
ped <- read.table("~/Documents/PyCodes/impute4diallel/ped.txt", header=T)

#####
f1 <- impute(ped=ped, row=2, dsf=dsf)
test_comp(res1=f1, res2=test, row=2)

f1 <- impute(ped=ped, row=1, dsf=dsf)
test_comp(res1=f1, res2=test, row=1)

### PASSED test!!!!


######################
test_comp <- function(res1=f1, res2=test, row=2){
  
  row.names(res2) <- gsub("X","", row.names(res2))
  idx <- grep("_a", row.names(res2))
  add <- res2[idx,]
  row.names(add) <- gsub("_a", "", row.names(add) )
  dom <- res2[-idx,]
  row.names(dom) <- gsub("_d", "", row.names(dom))
  
  add <- cbind(add, res1)
  add[,row] <- as.numeric(add[, row])
  add$comp1 <- add[,row] - add$F1a
  message(sprintf("[ %s ] different add imputations", nrow(subset(add, comp1 != 0)) )) 
  
  dom <- cbind(dom, res1)
  dom[,row] <- as.numeric(dom[, row])
  dom$comp2 <- dom[,row] - dom$F1d
  message(sprintf("[ %s ] different add imputations", nrow(subset(dom, comp2 != 0)) )) 
  
}

##########################
impute <- function(ped=ped, dsf=dsf, row=1){
  p1 <- ped$p1[row]
  p2 <- ped$p2[row]
  mydsf <- dsf[, c("snpid", "major", "minor", p1, p2)]
  # major=10, minor=-10 and missing, heter=0
  mydsf$F1a <- -9
  mydsf$F2d < -9
  for(i in 1:nrow(mydsf)){
    snp1 = mydsf[i, 4];
    snp2 = mydsf[i, 5];
    major = mydsf[i, "major"];
    minor = mydsf[i, "minor"]
    if(snp1 == major & snp2 == major){
      mydsf$F1a[i] = 10
      mydsf$F1d[i] = -10
    }else if(snp1 == major & snp2 == minor){
      mydsf$F1a[i] = 0
      mydsf$F1d[i] = 0
    }else if(snp1 == major & snp2 == "N"){
      mydsf$F1a[i] = 5
      mydsf$F1d[i] = -5
    }else if(snp1 == minor & snp2 == major){
      mydsf$F1a[i] = 0
      mydsf$F1d[i] = 0
    }else if(snp1 == minor & snp2 == minor){
      mydsf$F1a[i] = -10
      mydsf$F1d[i] = -10
    }else if(snp1 == minor & snp2 == "N"){
      mydsf$F1a[i] = -5
      mydsf$F1d[i] = -5
    }else if(snp1 == "N" & snp2 == major){
      mydsf$F1a[i] = 5
      mydsf$F1d[i] = -5
    }else if(snp1 == "N" & snp2 == minor){
      mydsf$F1a[i] = -5
      mydsf$F1d[i] = -5
    }else if(snp1 == "N" & snp2 == "N"){
      mydsf$F1a[i] = 0
      mydsf$F1d[i] = 0
    }else{
      stop("wrong genotypeing!")
    }
    message(i)
  }
  return(mydsf)
}










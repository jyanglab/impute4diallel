# impute4diallel

usage: impute4diallel_v1.2.py [-h] [-p [PATH]] [-d DIALLEL] [-i DSF]
                              [-s START] [-e END] [--header {yes,no}]
                              [-o OUTPUT] [-m {0,1,2,3,4}]

################################################################################
 impute4diallel version 1.0
 Jinliang Yang
 updated: Sep.12.2014
 changes: 1.R codes tested for GenSel add, dom, SNPTEST  output!
	  2.input changed to sdf5
 --------------------------------

 SNP Imputation for diallel!
################################################################################

optional arguments:
  -h, --help            show this help message and exit
  -p [PATH], --path [PATH]
                        the path of the input files
  -d DIALLEL, --diallel DIALLEL
                        pedigree of the diallels (p1 p2 F1)
  -i DSF, --dsf DSF     path of the density SNP format file
  -s START, --start START
                        start cols (1-based) of the genotype [defult:
                        --start=4]
  -e END, --end END     end cols (1-based) of the genotype [defult: --end=31]
  --header {yes,no}     print header or not [default: --header=no]
  -o OUTPUT, --output OUTPUT
                        output files, like chr1_merged
  -m {0,1,2,3,4}, --mode {0,1,2,3,4}
                        [default --mode=0]; 0, for GenSel; 1, for PLINK; 2,
                        for SNPTEST; need chr pos in the dsf file! 3, for raw;
                        4, for GenSel dominant model.

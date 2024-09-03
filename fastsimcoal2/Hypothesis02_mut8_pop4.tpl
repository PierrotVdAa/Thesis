//Parameters for the coalescence simulation program : fsimcoal2
4 samples to simulate :
//Population effective sizes (number of genes)
ALPES
VOSGES
PYRENEES
MASSIFC
//Samples sizes and samples age 
90 //69 in total
10
22
16
//Growth rates	: negative growth implies population expansion
0
0
0
0
//Number of migration matrices : 0 implies no migration between demes
0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
13     historical event
Bottlestart 0 0 0 Aresize1 0 0 //size reduction aka end of the glacial era
Bottlestart 1 1 0 Mresize1 0 0 //size reduction aka end of the glacial era
Bottlestart 2 2 0 Presize1 0 0 //size reduction aka end of the glacial era
Bottlestart 3 3 0 Vresize1 0 0 //size reduction aka end of the glacial era
Bottleend 0 0 0 Aresize2 0 0 //size increase aka beginning of the glacial era
Bottleend 1 1 0 Mresize2 0 0 //size increase aka beginning of the glacial era
Bottleend 2 2 0 Presize2 0 0 //size increase aka beginning of the glacial era
Bottleend 3 3 0 Vresize2 0 0 //size increase aka beginning of the glacial era
Timediv 1 0 1 1 0 0 //move to one panmictic population after a while
Timediv 2 0 1 1 0 0 //move to one panmictic population after a while
Timediv 3 0 1 1 0 0 //move to one panmictic population after a while
Timediv 0 0 0 AresizeANC 0 0 //set size of the panmictic population
ANCresizeTime 0 0 0 ANCresizeInt 0 0 //shrinking to allow coalescence
//Number of independent loci [chromosome] 
20000 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block: data type, num loci, rec. rate and mut rate + optional parameters
DNA 10 0 2.1e-7 0.33

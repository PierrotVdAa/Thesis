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
9     historical event
Allreco 1 1 0 intbotVos 0 0 instbot //pioneer effect aka the end of the glaciation era
Allreco 2 2 0 intbotPyr 0 0 instbot //pioneer effect aka the end of the glaciation era
Allreco 3 3 0 intbotMC 0 0 instbot //pioneer effect aka the end of the glaciation era
Allreco 1 0 1 1 0 0 //back to a single panmictic population
Allreco 2 0 1 1 0 0 //back to a single panmictic population
Allreco 3 0 1 1 0 0 //back to a single panmictic population
Allreco 0 0 0 intbotA 0 0 instbot //pioneer effect aka the end of the glaciation era
Allreco 0 0 0 Aresize 0 0 //increase in size for the peripheral refuge
ANCresizeTime 0 0 0 ANCresizeInt 0 0 //shrinking to allow coalescence
//Number of independent loci [chromosome] 
20000 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block: data type, num loci, rec. rate and mut rate + optional parameters
DNA 10 0 2.1e-7 0.33

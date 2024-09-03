#Load libraries
library("PopGenome")

#Set the working directory
path <- "/home/pierrot/Documents/data/hyp01_1"
setwd(path)

#Path is different for each analysis
files <- list.files(path = path, pattern = ".vcf.gz")

#Loop through the compressed VCF files in the folder
for(file in files){
  
  #skip the index files ending in .tbi
  if(substr(file, nchar(file)-3+1, nchar(file))=="tbi"){
    
  }else{
    print(file)
    
    #Load the data with PopGenome
    GENOME.class <- readVCF(filename = file,
                            numcols = 20000,
                            tid = "Loci_1",
                            frompos = 1,
                            topos = 20000)
    
    #Assign populations to samples
    pop1 <- get.individuals(GENOME.class)[[1]][1:90]
    pop2 <- get.individuals(GENOME.class)[[1]][91:100]
    pop3 <- get.individuals(GENOME.class)[[1]][101:122]
    pop4 <- get.individuals(GENOME.class)[[1]][123:138]
    GENOME.class <- set.populations(GENOME.class, list(c(pop1),c(pop2),c(pop3),c(pop4)), diploid=T)
    
    #Calculate the Dxy
    GENOME.class <- diversity.stats(GENOME.class, pi = TRUE)
    GENOME.class <- F_ST.stats(GENOME.class, mode = "nucleotide")
    dxy <- get.diversity(GENOME.class, between = T)[[2]]/100000
    
    #Concatenate all the results in one named vector
    pool <- c(filename=file, 
              dxy_Pop1_2=dxy[[1]],
              dxy_Pop1_3=dxy[[2]],
              dxy_Pop1_4=dxy[[3]],
              dxy_Pop2_3=dxy[[4]],
              dxy_Pop2_4=dxy[[5]],
              dxy_Pop3_4=dxy[[6]]
    )
    #Create the result matrix
    res_temp <- t(data.frame(pool)) 
      
    #Write the result as a csv table
    output <- paste("/home/pierrot/Documents/data/output_dxy/hyp01_1/", file, "_dxy.csv", sep = "")
    write.csv(res_temp, output)
    tbi <- paste(file,".tbi", sep = "")
    file.remove(file)
    file.remove(tbi)
  }

}

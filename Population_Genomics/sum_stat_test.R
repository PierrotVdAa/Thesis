#Load libraries
library("dartR")
library("vcfR")
library("adegenet")
library("hierfstat")
library("mmod")

#Set the working directory
path <- "/home/pierrot/Documents/data/sample_life"
setwd(path)

#Path is different for each analysis
files <- list.files(path = path, pattern = ".vcf")

i <- 0

#Loop through the VCF files in the folder
for(file in files){
  
  print(file)
  
  #Load and convert the data with vcfR
  data <- read.vcfR(file) #vcfR
  x <- vcfR2genlight(data) #vcfR

  
  #Assign population names and set ploidy
  pop <- as.factor(c("Pop1", "Pop2", "Pop3", "Pop4"))
  populations <- c(rep(c("Pop1","Pop2","Pop3","Pop4"),times=c(45,5,11,8)))
  pop(x) <- populations
  ploidy(x) <- 2
  
  #Conversion to other formats
  x_genind <- gl2gi(x, probar = FALSE)
  x_hierf <- genind2hierfstat(x_genind, pop=populations)
  
  #Split the gening object into four seperate populations with adegenet
  split <- seppop(x_genind)
  pop1 <- split$Pop1
  pop2 <- split$Pop2
  pop3 <- split$Pop3
  pop4 <- split$Pop4
  
  #Analyses with vcfR
  nei_diff <- genetic_diff(data, pops = pop, method = 'nei')
  nei_diff <- round(colMeans(nei_diff[,c(3:7,12:15)], na.rm = TRUE), digits = 3)
  jost_diff <- genetic_diff(data, pops = pop, method = 'jost')
  jost_diff <- round(colMeans(jost_diff[,c(7:9)], na.rm = TRUE), digits = 3)
  
  #Analysis with mmod
  diff <- diff_stats(x_genind, phi_st = T)
  
  #Analyses with Hierfstat
  fst_fis <- wc(x_hierf)
  stats <- basic.stats(data = x_hierf)$overall
  dosage <- beta.dosage(x_genind,inb=TRUE,Mb=TRUE,MATCHING=FALSE)$MB
  
  #Genetic distances with Hierfstat
  distance_Dch <- genet.dist(x_genind, method="Dch")
  distances_Dch <- c(dist_Dch_Pop1_2=distance_Dch[1],
                     dist_Dch_Pop1_3=distance_Dch[2],
                     dist_Dch_Pop1_4=distance_Dch[3],
                     dist_Dch_Pop2_3=distance_Dch[4],
                     dist_Dch_Pop2_4=distance_Dch[5],
                     dist_Dch_Pop3_4=distance_Dch[6])
  distance_Da <- genet.dist(x_genind, method="Da")
  distances_Da <- c(dist_Da_Pop1_2=distance_Da[1],
                    dist_Da_Pop1_3=distance_Da[2],
                    dist_Da_Pop1_4=distance_Da[3],
                    dist_Da_Pop2_3=distance_Da[4],
                    dist_Da_Pop2_4=distance_Da[5],
                    dist_Da_Pop3_4=distance_Da[6])
  distance_Ds <- genet.dist(x_genind, method="Ds")
  distances_Ds <- c(dist_Ds_Pop1_2=distance_Ds[1],
                    dist_Ds_Pop1_3=distance_Ds[2],
                    dist_Ds_Pop1_4=distance_Ds[3],
                    dist_Ds_Pop2_3=distance_Ds[4],
                    dist_Ds_Pop2_4=distance_Ds[5],
                    dist_Ds_Pop3_4=distance_Ds[6])
  
  #Pairwise analyses with Hierfstat
  beta <- pairwise.betas(x_genind)
  betas <- c(beta_Pop1_2=beta["Pop1","Pop2"],
             beta_Pop1_3=beta["Pop1","Pop3"],
             beta_Pop1_4=beta["Pop1","Pop4"],
             beta_Pop2_3=beta["Pop2","Pop3"],
             beta_Pop2_4=beta["Pop2","Pop4"],
             beta_Pop3_4=beta["Pop3","Pop4"])
  neifst <- pairwise.neifst(x_genind,diploid=TRUE)
  neifsts <- c(neifst_Pop1_2=neifst["Pop1","Pop2"],
               neifst_Pop1_3=neifst["Pop1","Pop3"],
               neifst_Pop1_4=neifst["Pop1","Pop4"],
               neifst_Pop2_3=neifst["Pop2","Pop3"],
               neifst_Pop2_4=neifst["Pop2","Pop4"],
               neifst_Pop3_4=neifst["Pop3","Pop4"])
  WCfst <- pairwise.WCfst(x_genind,diploid=TRUE)
  WCfsts <- c(WCfst_Pop1_2=WCfst["Pop1","Pop2"],
              WCfst_Pop1_3=WCfst["Pop1","Pop3"],
              WCfst_Pop1_4=WCfst["Pop1","Pop4"],
              WCfst_Pop2_3=WCfst["Pop2","Pop3"],
              WCfst_Pop2_4=WCfst["Pop2","Pop4"],
              WCfst_Pop3_4=WCfst["Pop3","Pop4"])
  
  #More analyses with Hierfstat
  pi <- pi.dosage(x_genind)
  TajimaD <- TajimaD.dosage(x_genind)
  theta <- theta.Watt.dosage(x_genind)
  
  #Analyses on a single population level with Hierfstat
  pi_pop1 <- pi.dosage(pop1)
  pi_pop2 <- pi.dosage(pop2)
  pi_pop3 <- pi.dosage(pop3)
  pi_pop4 <- pi.dosage(pop4)
  TajimaD_pop1 <- TajimaD.dosage(pop1)
  TajimaD_pop2 <- TajimaD.dosage(pop2)
  TajimaD_pop3 <- TajimaD.dosage(pop3)
  TajimaD_pop4 <- TajimaD.dosage(pop4)
  
  #Concatenate all the results in one named vector
  pool <- c(file,
            nei_diff, jost_diff, #vcfR
            diff$global, #mmod
            Fst=fst_fis$FST, Fis=fst_fis$FIS, stats, Mean_kinship=dosage,distances_Dch, distances_Da, distances_Ds, 
            betas, neifsts, WCfsts, pi= pi, TajimaD=TajimaD,theta=theta, 
            pi_pop1=pi_pop1, pi_pop2=pi_pop2, pi_pop3=pi_pop3, pi_pop4=pi_pop4, 
            TajimaD_pop1=TajimaD_pop1, TajimaD_pop2=TajimaD_pop2, TajimaD_pop3=TajimaD_pop3, TajimaD_pop4=TajimaD_pop4 #Hierfstat
            )
  #Create the result matrix
  if(i==0){
    res_temp <- pool 
    i <- 1
  } else {
    #Add this vector to the result matrix
    res_temp <- rbind(res_temp, pool)
  }
}

#Tranform the result matrix into a dataframe
res_all <- data.frame(res_temp)

#Write the result as a csv table
write.csv(res_all, "/home/pierrot/Documents/data/sample_life/Summary_statistics.csv")
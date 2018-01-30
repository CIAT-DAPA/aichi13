##########################################   Start Functions    ###############################################
# This function takes a list of countries, selects those species from the file
# "WEP_taxonkey_distribution.csv" and then runs the calc_indicator.R function, which in turn
# calculates the proportion of species in different categories (HP, MP, LP, SC).
# The output is returned as a data.frame.
# @param (string) iso_list: vector with list of country ISOs
# @param (string) opt: which field(s) to calculate indicator for (min, max, mean)
# @param (string) config_file: path to config file
# @return (data.frame): This function returns a data frame proportions of spp in each category,
#                       and with final indicator aggregated for the selected country
select_spp_indicator <- function(iso_list="ALL", opt=c("min","max","mean"), config_file) {
  #load list of species-by-country
  wep_list <- read.csv(paste(wd,"/indicator/WEP_taxonkey_distribution.csv",sep=""),sep="\t",header=T)
  
  #select species following given filter
  if (toupper(iso_list) == "ALL") {
    spp_list <- unique(paste(wep_list$taxonkey))
  } else {
    spp_list <- wep_list[which(wep_list$countrycode %in% toupper(iso_list)),]
    spp_list <- unique(paste(spp_list$taxonkey))
  }
  
  #filter above list of species following those that have fcs_combined.csv
  spp_exist <- lapply(spp_list, FUN=function(x) {file.exists(paste(wd,"/gap_analysis/",x,"/",version,"/gap_analysis/combined/fcs_combined.csv",sep=""))})
  spp_exist <- unlist(unlist(spp_exist))
  spp_list <- spp_list[which(spp_exist)]
  
  if (length(spp_list) == 0) {
    indic_df <- NA
  } else {
    #create filename
    fname <- paste(paste(c("indicator",iso_list),collapse="_"),".csv",sep="")
    
    #calculate indicator for species list
    indic_df <- calc_indicator(spp_list, opt, config_file=NULL, fname)
  }
  
  #return object
  return(indic_df)
}

#testing function
#wd <- "~/nfs/workspace_cluster_9/Aichi13" #change to reading from config file
#version <- "v1"
#iso_list <- c("CN")
#indic_iso <- select_spp_indicator(iso_list="CN", opt=c("min","max","mean"), config_file)
#Maria Victoria Diaz
#CIAT, 2018

# This function makes the main directories which will be used in each step of the analysis.
# @param (logical) dirs: TRUE by default.
# @param (logical) cleaning: FALSE by default. TRUE when the 0_STEP: CLEANING is executed.
# @param (logical) modeling: FALSE by default. TRUE when the 1_STEP: MODELING is executed. 
# @param (logical) exsitu: FALSE by default. TRUE when the 2.1_STEP:EXSITU GAP ANALYSIS is executed.
# @param (logical) insitu: FALSE by default. TRUE when the 2.2_STEP:INSITU GAP ANALYSIS is executed.
# @param (logical) premodeling: FALSE by default. TRUE before the 1_STEP: MODELING is executed.
# @return (dir): This function return the directories which will be used in all master code development.

#NOTE: base_dir will have to be specified in the master code

config <- function(dirs=T, cleaning=F, insitu=F, exsitu=F, modeling=F, premodeling=F) {
  #version
  run_version <<- "v1"
  
  #load packages
  require(raster)
  
  ###FOLDERS FOR RUNNING##
  if (dirs) {
    root <<- paste(base_dir,"/workspace_cluster_9/Aichi13",sep="")
    gap_dir <<- paste0(root, "/gap_analysis_201802");if(!file.exists(gap_dir)){dir.create(gap_dir)}
    par_dir <<- paste0(root, "/parameters_201802");if(!file.exists(par_dir)){dir.create(par_dir)}
    occ_dir <<- paste0(par_dir,"/","occurrences");if(!file.exists(occ_dir)){dir.create(occ_dir)}
  }
  
  ####################################### 0.CLEANING ################################################
  # used by functions: clean_sea.R  and split_occs_srs.R #####
  if (cleaning) {
    ##INPUT FILES TO CLEAN SEA##
    folderin_raw <<- paste0(occ_dir, "/raw")
    
    ##COUNTRIES SHAPEFILES##
    #countries_sh <<- countries_sh
    
    ##OUTPUT FOLDER IN clean_sea FUNCTION, AND INPUT IN split_occs_srs FUNCTION##
    folder_nosea <<- paste0(occ_dir,"/","no_sea")
    if(!file.exists(folder_nosea)){dir.create(folder_nosea)}
  }
  
  
  ####################################### PRE MODELING ################################################
  #used by nat_area_mask.R and  nat_area_shp.R  functions
  
  if (premodeling) {
    clim_dir <<- paste0(par_dir, "/biolayer_2.5/raster")
    biolayers <<- stack(paste(clim_dir, "/", list.files(clim_dir, pattern = '\\.tif$'), sep=""))
    countries_sh <<- countries_sh
    layer_name <<- "gadm28ISO"
    tkdist <<- read.csv(paste0(par_dir,"/WEP/WEP_taxonkey_distribution_ISO3.csv"), sep="\t", header=T)
    global_mask <<- raster(paste0(par_dir,"/world_mask/raster/mask.tif"))
  }
  
  ####################################### 1. MODELING ################################################
  #used by functions: modeling_approach.R
  
  if(modeling){
    rst_dir <<- paste0(par_dir, "/biolayer_2.5/raster")
    #bio <<- list.files(bio_dir)
    #elev <- raster(paste0(par_dir,"/biolayer_2.5/raster/",bio))
    msk_global <<- raster(paste0(par_dir,"/world_mask/raster/mask.tif"))
  }
  
  ####################################### 2. GAP ANALYSIS ################################################
  
  ######## EX SITU #######
  #used by functions: CropMask.R, buffer_points.R, grs.R, ers.R
  if (exsitu) {
    clim_dir <<- paste0(par_dir, "/biolayer_2.5/raster") 
    msk_global <<- raster(paste0(par_dir,"/world_mask/raster/mask.tif"))
    global_area <<- raster(paste0(par_dir,"/world_mask/raster/area.tif")) 
  }
  
  ######## IN SITU #######
  #used by functions: ers.R , grs.R and fcs.R
  
  if (insitu) {
    #GLOBAL CONFIGURATION
    #rasterOptions(tmpdir = "D:/TEMP/hsotelo")
    species.glob.dir <<- gap_dir
    
    # "a" is global factor to limit the goal of conservation to a fraction of total
    # for GRS calculation, 0 <= a <= 1
    a_insitu <<- 1.0;
    
    #PATH TO PROTECTED AREAS RASTER
    pa.path <<- paste0(par_dir, "/protected_areas/raster/wdpa_reclass.tif")
    pa.raster <<- raster(pa.path)
    
    #LOAD THE MASK OF THE WORLD
    world.area.path <<- paste0(par_dir,"/world_mask/raster/area.tif")
    world.area <<- raster(world.area.path)
  }
  
  ######## BOTH IN-SITU AND EX-SITU #######
  if (insitu | exsitu) {
    #PATH TO WWF WORLD ECOREGIONS
    eco.path <<-paste0(par_dir, "/ecosystems/raster/wwf_eco_terr_geo.tif")
    eco.raster <<- raster(eco.path)
  }
}

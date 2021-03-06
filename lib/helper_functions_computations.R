
# Obtain coordinates of different states
states_coordinates <- function(states) {
  
  # Extract coordinates of each states from downloaded shape file
  coords_list <- list()
  for (i in 1:52) {
    coords_list[[i]]<- slot(states@polygons[[i]]@Polygons[[1]],"coords")
  }
  
  # calculate the mean of lat and long in order to find the center of each states
  f <- function(x){apply(x,2,mean)}
  mean_coords_list <- lapply(coords_list,f)
  name <- as.character(states$STUSPS)
  long <- c()
  lat <-c()
  for (i in 1:52) {
    long[i]<- mean_coords_list[[i]][1]
    lat[i]<- mean_coords_list[[i]][2]
  }
  
  # Form the data frame that contains the name and center coordinates of each states
  df <- data.frame(name,long,lat)
  
  # Some of the center coordinates are incorrect and need to adjust
  df[df$name=="AK",c(2,3)] <- c(-150,66) #change AK coordinates
  df[df$name=="WA",c(2,3)] <- c(-120,47.2) #change WA coordinates
  df[df$name=="CA",c(2,3)] <- c(-118.4541,37) #change CA coordinates
  df[df$name=="WI",c(2,3)] <- c(-88.5,44) #change WI coordinates
  df[df$name=="FL",c(2,3)] <- c(-82,28) #change FL coordinates
  df[df$name=="OH",c(2,3)] <- c(-82.5,40.5) #change OH coordinates
  df[df$name=="NY",c(2,3)] <- c(-74.5,42.59) #change OH coordinates
  df[df$name=="LA",c(2,3)] <- c(-91,30) #change LA coordinates
  df[df$name=="MS",c(2,3)] <- c(-89.5,32.5) #change MS coordinates
  df[df$name=="AL",c(2,3)] <- c(-86.5,32.5) #change AL coordinates
  
  return(df)
}

# Merge and subset columns from Consumption files
consumption_subset <- function(df1, df2){
  df2$DisplayOrder <- NULL
  df2$SubMeasureID <- NULL
  
  consumption_states <- rbind(df1,df2)
  
  consumption_states$TopicType <- NULL
  consumption_states$DataSource <- NULL
  consumption_states$StratificationID1 <- NULL
  consumption_states$StratificationID2 <- NULL
  consumption_states$StratificationID3 <- NULL
  consumption_states$StratificationID4 <- NULL
  consumption_states$TopicTypeId <- NULL
  consumption_states$TopicId <- NULL
  consumption_states$MeasureId <- NULL
  consumption_states$GeoLocation <- NULL
  consumption_states$Sample_Size <- NULL
  consumption_states$High_Confidence_Limit <- NULL
  consumption_states$Low_Confidence_Limit <- NULL
  consumption_states$Data_Value_Std_Err <- NULL
  
  return(consumption_states)
}

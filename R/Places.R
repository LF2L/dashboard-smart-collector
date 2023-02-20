# Establishing the places
Places <- 
   tribble(~Place, ~lat, ~long, ~Type,
           "Green Fablab", 48.69354778372888, 6.199223427009557, "Home", 
           "ENSGSI", 48.69508092375094, 6.194086052304349, "Education",
           "EEIGM",  48.695897093034866, 6.193120953312192, "Education",
           "MJC Bazin", 48.69739157499988, 6.194576095053032, "Association",
           "SNN", 48.693487765703644, 6.2016121881502375, "Sport",
           "Curves", 48.69812957589187, 6.2005961050660385, "Sport",
           "VNF", 48.69199572042067, 6.1951544736381745, "Enterprise",
           "MAIF", 48.693154051864724, 6.196146452736703, "Enterprise"
   )


# Reading data from Cristian
library(readxl)
onglet <- excel_sheets(path = "data/KPIs-database.xlsx")
data <- 
   read_xlsx(path = "data/KPIs-database.xlsx",
                      sheet = onglet[9],
             skip = 1) %>% 
   select(Date, Place, Quantity, Distance, Transport )
          
names(data)   
str(data)

# Joining data
Recovery <- data %>% left_join(Places, by = "Place")
names(Recovery)

# Total of Plastics
total_plastic <- sum(Recovery$Quantity)
total_km <- sum(Recovery$Distance %>% as.numeric())


GF <- 
   tibble(
    Date = as.Date(Sys.Date(),format = "%y-%m-%d"),
    Place= "Green Fablab",
    "Quantity (kg)" = total_plastic,
    "Distance (km)" =  total_km,
    Transport = "Foot",
    lat = Places$lat[1],
    long  = Places$long[1],
    Type = Places$Type[1]
   )

#Recovery <- rbind(Recovery, GF)



#rm(data, Places, onglet, GF)

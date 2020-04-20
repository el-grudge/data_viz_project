GB <- getData('GADM', country="gbr", level=2)
GB_sub <- subset(GB, NAME_1 != "Northern Ireland")
GB_sub2 <- subset(GB_sub, NAME_1 != "Wales")
GB_sub3 <- subset(GB_sub2, NAME_1 != "Scotland")
GB_fort <- fortify(GB_sub3, region = "NAME_2")

GB_fort <- filter(GB_fort, !id %in% 
                    c('Gateshead','Newcastle upon Tyne','North Tyneside','South Tyneside','Sunderland', # remove North of Tyne
                      'Wolverhampton','Dudley','Walsall','Sandwell','Birmingham','Solihull','Coventry', # remove West Midlands
                      'Bolton','Bury','Manchester','Oldham','Rochdale','Salford','Stockport','Tameside','Wigan', # remove Greater Manchester
                      'Sheffield','Rotherham','Barnsley','Doncaster', # remove Sheffield City Region
                      'Leeds', 'Wakefield', 'Kirklees', 'Calderdale', 'Bradford', # remove West Yorkshire
                      'Halton','Knowsley','Sefton','St Helens','Wirral', # remove Liverpool City Region
                      'Darlington','Hartlepool','Stockton-on-Tees','Redcar and Cleveland','Middlesbrough' # remove Tees Valley
                    ))

shapefile <- readOGR(dsn="data/Combined_Authorities_December_2019_Boundaries_EN_BFC")
shapefile <- spTransform(shapefile,"+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
mapdata <- tidy(shapefile, region="cauth19nm", proj="DECIMAL")

mapdata <- rbind(mapdata, GB_fort)

champions <- read_csv('data/english_champoins.csv')
colnames(champions)[3] <- "id"
county_champoins <- champions %>% 
  group_by(id) %>%
  summarise(Titles=sum(Titles))

mapdata <- mapdata %>% left_join(county_champoins, by='id')
mapdata[is.na(mapdata$Titles),]$Titles <- 0

midpoints <- mapdata %>% group_by(id) %>% summarize(clat = mean(lat), clong = mean(long), Titles=unique(Titles))

ggplot() + geom_polygon(data=mapdata, aes(x=long, 
                                  y=lat, 
                                  group=group, 
                                  fill=Titles), 
                              color = "black", size = 0.25) +
  coord_fixed(1) + 
  scale_fill_gradient2(low = "white", high = "navyblue") +
  theme_nothing(legend = TRUE) +
  labs(title='Champoins of England') +
  theme(plot.title=element_text(hjust = 0.2, vjust=-4))

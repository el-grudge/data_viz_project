# radarchars
champions <- filter(season_all, rank==1)
rownames(champions) <- paste(champions$team_name, champions$year + 1, sep='_')
champions <- select(champions, -rank, -team_name, -team_id, -year)

champ_Max <- apply(champions, 2, FUN=max)
champ_Min <- apply(champions, 2, FUN=min)
champ_Average <- colMeans(champions)
champ_properties <- rbind(champ_Max, champ_Min, champ_Average)
champ_properties <- as.data.frame(champ_properties)
rownames(champ_properties) <- c('Max', 'Min', 'Average')

radarchart(champ_properties, title='Average')
radarchart(rbind(champ_properties, champions['Chelsea_2015', ]), pcol=c(1,2), title='Chelsea 15')
radarchart(rbind(champ_properties, champions['Leicester_2016', ]), pcol=c(1,3), title='Leicester 16')
radarchart(rbind(champ_properties, champions['Chelsea_2017', ]), pcol=c(1,4), title='Chelsea 17')
radarchart(rbind(champ_properties, champions['Manchester City_2018', ]), pcol=c(1,5), title='Manchester City 18')
radarchart(rbind(champ_properties, champions['Manchester City_2019', ]), pcol=c(1,6), title='Manchester City 19')
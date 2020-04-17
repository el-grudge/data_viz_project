# Downloading Understatr package

#install.packages('remotes')
#remotes::install_github('ewenme/understatr')
# library(understatr)
# library(tidyverse)
# library(fmsb)
# library(corrplot)
# library(moments)
# library(reshape2)
# library(effectsize)
# library(gganimate)
# library(gifski)
# library(transformr)
# library(scales)
# library(ggrepel)
# library(ggcorrplot)

source('R/get_season.R')


# Testing package commands
league_seasons <- get_league_seasons("EPL")
league_team_stats <- get_league_teams_stats(league_name = "EPL", year = 2018)
leagues_meta <- get_leagues_meta()
match_shots <- get_match_shots(match_id = 11662)
match_stats <- get_match_stats(match_id = 11662)
player_matches_stats <- get_player_matches_stats(player_id = 882)
player_seasons_stats <- get_player_seasons_stats(player_id = 882)
player_shots <- get_player_shots(player_id = 882)
team_meta <- get_team_meta(team_name = "Newcastle United")
team_players_stats <- get_team_players_stats(team_name = "Newcastle United", year = 2018)

# # Getting league data
# league_stats_2014 <- get_league_teams_stats(league_name = "EPL", year = 2014)
# league_stats_2015 <- get_league_teams_stats(league_name = "EPL", year = 2015)
# league_stats_2016 <- get_league_teams_stats(league_name = "EPL", year = 2016)
# league_stats_2017 <- get_league_teams_stats(league_name = "EPL", year = 2017)
# league_stats_2018 <- get_league_teams_stats(league_name = "EPL", year = 2018)
# league_stats_all <- rbind(league_stats_2014, league_stats_2015, league_stats_2016, league_stats_2017, league_stats_2018)
#
# # Overall
# season_14 <- get_season(league_stats_2014)
# season_15 <- get_season(league_stats_2015)
# season_16 <- get_season(league_stats_2016)
# season_17 <- get_season(league_stats_2017)
# season_18 <- get_season(league_stats_2018)
# season_all <- rbind(season_14, season_15, season_16, season_17, season_18)

# home/away -- incomplete
season_14_h <- get_season(filter(league_stats_2014, h_a=='h'))
colnames(season_14_h) <- paste(colnames(season_14_h), "h", sep="_")

season_14_a <- get_season(filter(league_stats_2014, h_a=='a'))
colnames(season_14_a) <- paste(colnames(season_14_a), "a", sep="_")

# # the platonic table
# platonic_table <- season_all %>%
#   select(-c(2,4,5)) %>%
#   group_by(rank) %>%
#   summarise(mp=mean(mp),
#             pts=mean(pts),
#             win=mean(win),
#             draw=mean(draw),
#             loss=mean(loss),
#             goal_diff=mean(goal_diff),
#             goals_for=mean(goals_for),
#             goals_against=mean(goals_against),
#             xG=mean(xG),
#             xGA=mean(xGA),
#             deep=mean(deep),
#             deep_allowed=mean(deep_allowed),
#             avgCP=mean(avgCP),
#             avgCP_allowed=mean(avgCP_allowed),
#             def_actions=mean(def_actions),
#             def_actions_allowed=mean(def_actions_allowed),
#             ppda=mean(ppda),
#             ppda_allowed=mean(ppda_allowed))





# all-time ranking

# # model
# # correlation matrix
# season_all.cor <- cor(select(season_all, -c(1:5), -goal_diff))
# ggcorrplot(season_all.cor, type="upper", lab=TRUE, show.legend=FALSE)
#
# # coorelation bars
# # pts
# pts.corr <- as.data.frame(head(sort(season_all.cor[,'pts'], decreasing=TRUE)[-1], n=5))
# colnames(pts.corr) <- 'pts'
# ggcorrplot(pts.corr, lab=TRUE, show.legend=FALSE)
# # wins
# win.corr <- as.data.frame(head(sort(season_all.cor[,'win'], decreasing=TRUE)[-c(1,2)], n=5))
# colnames(win.corr) <- 'win'
# ggcorrplot(win.corr, lab=TRUE, show.legend=FALSE)
# # goals_for
# goals_for.corr <- as.data.frame(head(sort(season_all.cor[,'goals_for'], decreasing=TRUE)[-c(1,3,4)], n=5))
# colnames(goals_for.corr) <- 'goals_for'
# ggcorrplot(goals_for.corr, lab=TRUE, show.legend=FALSE)
# # xG
# xG.corr <- as.data.frame(head(sort(season_all.cor[,'xG'], decreasing=TRUE)[-c(1,2,4,5)], n=5))
# colnames(xG.corr) <- 'xG'
# ggcorrplot(xG.corr, lab=TRUE, show.legend=FALSE)

# # Top 5 wins
# colnames(sort(as.data.frame(season_all.cor)['win',], decreasing=TRUE)) #[,2:6]
# # Bottom 5 wins
# colnames(sort(as.data.frame(season_all.cor)['win',], decreasing=FALSE)[,2:6])
# # Top 5 loss
# colnames(sort(as.data.frame(season_all.cor)['loss',], decreasing=TRUE)[,2:6])
# # Bottom 5 loss
# colnames(sort(as.data.frame(season_all.cor)['loss',], decreasing=FALSE)[,c(1,3:6)])
# # Top 5 draw
# colnames(sort(as.data.frame(season_all.cor)['draw',], decreasing=TRUE)[,2:6])
# # Top 5 draw
# colnames(sort(as.data.frame(season_all.cor)['draw',], decreasing=FALSE)[,2:6])

# # feature extraction
# # build model to predict pts
# df <- select(season_all, -rank, -team_name, -win, -draw, -loss, -team_id)
# linear_model <- lm(pts ~ ., data=df)
# summary(linear_model) # 2 questions: why goal_diff and xGD have NA? do I need to use transformations or model selection methods?
# skewness(df)

# # model analysis: feature distribution
# # histogram - method 1
# drawhist <- function(df,i){
#   hist(
#     x = df[,i],
#     main = "",
#     xlab = colnames(df)[i],
#     col = "steelblue",
#     probability = TRUE
#   )
#   t <- seq(
#     from = min(df[,i]),
#     to = max(df[,i]),
#     by = 0.1
#   )
#   return (lines(
#     x = t,
#     y = dnorm(
#       x=t,
#       mean = mean(df[,i]),
#       sd = sd(df[,i])),
#     col = "red",
#     lwd = 3
#   ))
# }
#
# for (i in 1:ncol(df)) {
#   print(colnames(df)[i])
#   print(i)
#   drawhist(df, i)
# }
#
# # histgrams - method 2
# df_gathered <- gather(df, key=feature, value=value)
# ggplot(df_gathered, aes(value)) +
#   geom_histogram(aes(y=..density..),
#                  bins=40,
#                  col="red",
#                  fill="steelblue") +
#   geom_density(col=2) +
#   facet_wrap(vars(feature))
#
# # scatter plots
# df_melt <- melt(df, id = "pts")
# df_melt %>% head()
# ggplot(df_melt, aes(x=pts, y=value)) +
#   facet_wrap(~variable, scales = "free") +
#   geom_point()
#
# # normalize-standardize, then build model to predict pts
# df_transformed <- standardize(normalize(df, exclude="pts"), exclude="pts")
# lm_transformed <- lm(pts~., data=df_transformed)
# summary(lm_transformed)


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

# line-charts
as.data.frame(champions) %>% ggplot(aes(x=c(2015,2016,2017,2018,2019), y=pts, group=1)) + geom_line()

# contenders

# team win-lose-draw line
league_stats_all$matchday <- rep(c(1:38), length(league_stats_all$year)/38)
filter(select(mutate(league_stats_all, team_name=paste(team_name, year+1, sep='_')), team_name, pts, matchday),
       team_name %in% c('Chelsea_2015', 'Leicester_2016', 'Chelsea_2017', 'Manchester City_2018', 'Manchester City_2019')) %>%
  ggplot(aes(matchday, pts, col=team_name)) + geom_line()

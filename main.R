# Loading the libraries
source('R/libraries.R')

# Building the dataset
source('R/get_season.R')

league_stats_2014 <- get_league_teams_stats(league_name = "EPL", year = 2014)
league_stats_2015 <- get_league_teams_stats(league_name = "EPL", year = 2015)
league_stats_2016 <- get_league_teams_stats(league_name = "EPL", year = 2016)
league_stats_2017 <- get_league_teams_stats(league_name = "EPL", year = 2017)
league_stats_2018 <- get_league_teams_stats(league_name = "EPL", year = 2018)
league_stats_all <- rbind(league_stats_2014, league_stats_2015, league_stats_2016, league_stats_2017, league_stats_2018)

season_14 <- get_season(league_stats_2014)
season_15 <- get_season(league_stats_2015)
season_16 <- get_season(league_stats_2016)
season_17 <- get_season(league_stats_2017)
season_18 <- get_season(league_stats_2018)
season_all <- rbind(season_14, season_15, season_16, season_17, season_18)

#########################
#### 2- The path towards the top
# 2.2 Points and other important features
# 2.2.1 Scatter plots
source('R/points_and_features_scatter.R', print.eval=TRUE)

# 2.2.2 Correlation matrix
source('R/points_and_features_corrplot.R', print.eval=TRUE)

# 2.2.3 The case for xG
# Goal lines
source('R/goal_line.R', print.eval=TRUE)
# Separate Models + Combined Models
source('R/goalsVSxg.R', print.eval=TRUE)


#########################
#### 3- Champions, challengers, and also-rans ######
# 3.1 Platonic table
source('R/benchmarks.R')
platonictable <- build_platonictable(season_all)

# Ranking lollipop
source('R/platonictable_lollipop.R', print.eval=TRUE)
# Win/lose/draw piechart
source('R/platonictable_piechart.R', print.eval=TRUE)
# Goal difference
source('R/platonictable_pyramid.R', print.eval=TRUE)
# Goals for minus xG
source('R/platonictable_gxg.R', print.eval=TRUE)
# Attitude and work
source('R/platonictable_work.R', print.eval=TRUE)

#########################
#### 4. Champions, challengers, and also-rans
# 4.1 Pedigree
source('R/alltime_geoviz.R', print.eval=TRUE)

# 3.2 All-time ranking
source('R/alltime_geo_viz.R', print.eval=TRUE)
alltime <- build_alltimetable(season_all)

# 3.3 Orientation


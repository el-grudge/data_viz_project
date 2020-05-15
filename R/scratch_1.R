flavors <- c("chocolate", "vanilla", "phish food", "ube", "strawberry", "guava sorbet")
seattle <- c(3, 4, 7, 7, 3, 8)
portland <- c(6, 3, 3, 9, 5, 7)
sanfran <- c(10, 12, 15, 17, 11, 21)
ice.cream <- data.frame(flavors, seattle, portland, sanfran)

ice.cream
ice.cream %>% gather(key="location", value="price", seattle, portland, sanfran)

manu %>% gather(key = "team",
                value = "points",
                team, sum(pts))


select(league_team_stats, )

??select

starwars %>% group_by(gender) %>% select(group_cols())

starwars <- starwars
starwars <- as.data.frame(starwars)
starwars_1 <- starwars %>% group_by(gender)
starwars_2 <- starwars_1 %>% select(group_cols())

select(mtcars, .data$mpg : .data$disp)


select(mtcars, c(.data$mpg,.data$disp))

mtcars %>% sort(mpg)

order_by(10:1, cumsum(1:10))




#league_stats_2014 %>%   group_by(team_name) %>%

filter(league_stats_2014, team_id == '89') %>% filter(h_a == 'h') %>% select(pts) %>% sum()

league_stats_2014 %>% group_by(team_name) %>% filter(h_a == 'h') %>% select(pts) %>% summarise(pts=sum(pts))

league_stats_2014 %>%
  group_by(team_name) %>%
  filter(h_a == 'h') %>%
  select(pts) %>%
  summarise(home_pts=sum(pts)) %>% right_join(season_14, on=team_name)



league_stats_2014$result %>% head()


select(season, -h_a, -result, -date, -team_id, -league_name, -year, -npxG, -npxGA, -ppda.att, -ppda_allowed.att) %>%
  group_by(team_name) %>%
  summarise(pts=sum(pts), #ok
            goals_for=sum(scored), #ok
            goals_against=sum(missed), #ok
            goal_diff=sum(scored)-sum(missed), #ok
            win=sum(wins), #ok
            draws=sum(draws), #ok
            loses=sum(loses), #ok
            xG=sum(xG), #ok
            xGA=sum(xGA), #ok
            deep=sum(deep),
            deep_allowed=sum(deep_allowed),
            xpts=sum(xpts), #ok
            npxGD=sum(npxGD),
            ppda.def=mean(ppda.def),
            ppda_allowed.def=mean(ppda_allowed.def)) %>%
  arrange(desc(pts))


league_stats_2019 <- get_league_teams_stats(league_name = "EPL", year = 2019)
league_stats_2017
league_stats_2018

select(filter(league_stats_2017, team_name == 'Manchester City'), starts_with('ppda'))

record_breakers <- filter(league_stats_2017, team_name == 'Manchester City')

get_season <- function(season){
  return (as.data.frame(select(season, -h_a, -result, -date, -team_id, -league_name, -year, -npxG, -npxGA) %>%
                          group_by(team_name) %>%
                          summarise(pts=sum(pts),
                                    goals_for=sum(scored),
                                    goals_against=sum(missed),
                                    goal_diff=sum(scored)-sum(missed),
                                    win=sum(wins),
                                    draws=sum(draws),
                                    loses=sum(loses),
                                    xG=sum(xG),
                                    xGA=sum(xGA),
                                    deep=sum(deep),
                                    deep_allowed=sum(deep_allowed),
                                    xpts=sum(xpts),
                                    npxGD=sum(npxGD),
                                    ppda_att=mean(ppda.att),
                                    ppda_def=mean(ppda.def),
                                    ppda_allowed_att=mean(ppda_allowed.att),
                                    ppda_allowed_def=mean(ppda_allowed.def)) %>%
                          arrange(desc(pts))))
}

season_17 <- get_season(league_stats_2017)


#season_14 <- season_14 %>% left_join(season_14_h, by=c('team_name' = 'team_name_h'))
#season_14 <- season_14 %>% right_join(season_14_a, by=c('team_name' = 'team_name_a'))

df <- mutate(league_stats_2014, team_name=paste(team_name, year+1, sep='_'))
View(df)
as.data.frame(select(league_stats_2014, -h_a, -result, -date, -team_id, -league_name, -npxG, -npxGA, -xpts, -npxGD) %>%
                group_by(paste(team_name, year+1, sep='_')) %>%
                summarise(pts=sum(pts),
                          win=sum(wins),
                          draws=sum(draws),
                          loses=sum(loses),
                          goals_for=sum(scored),
                          goals_against=sum(missed),
                          goal_diff=sum(scored)-sum(missed),
                          xG=sum(xG),
                          xGA=sum(xGA),
                          deep=sum(deep),
                          deep_allowed=sum(deep_allowed),
                          avgCP_allowed=mean(ppda.att),
                          def_actions=mean(ppda.def),
                          avgCP=mean(ppda_allowed.att),
                          def_actions_allowed=mean(ppda_allowed.def),
                          ppda=mean(ppda.att)/mean(ppda.def),
                          ppda_allowed=mean(ppda_allowed.att)/mean(ppda_allowed.def)) %>%
                arrange(desc(pts)))


mutate(league_stats_2014)



drawhist <- function(df,i){
  hist(
    x = df[,i],
    main = "",
    xlab = colnames(df)[i],
    col = "steelblue",
    probability = TRUE
  )
  t <- seq(
    from = min(df[,i]),
    to = max(df[,i]),
    by = 0.1
  )
  return (lines(
    x = t,
    y = dnorm(
      x=t,
      mean = mean(df[,i]),
      sd = sd(df[,i])),
    col = "red",
    lwd = 3
  ))
}


for (i in 1:ncol(df)) {
  print(colnames(df)[i])
  print(i)
    drawhist(df, i)
}



min(df$pts)
max(df$pts)

min(df$goals_for)
max(df$goals_for)

min(df$goals_against)
max(df$goals_against)

min(df$goal_diff)
max(df$goal_diff)

mean(df$goal_diff)

# Basic Scatterplot Matrix
pairs(~mpg+disp+drat+wt,data=mtcars,
      main="Simple Scatterplot Matrix")

colnames(df)

pairs(~pts+goals_for+goals_against+goal_diff+xG+xGA+xGD+deep+deep_allowed+avgCP_allowed+def_actions+avgCP+def_actions_allowed+ppda+ppda_allowed,
      data=df)

# to be included ###############################################################
# scatter plots
df_melt <- melt(df, id = "pts")

df_melt %>% head()


ggplot(df_melt, aes(x=value, y=pts)) +
  facet_wrap(~variable, scales = "free") +
  geom_point()

# histograms
df_gathered <- gather(df, key=feature, value=value)
ggplot(df_gathered, aes(value)) +
  geom_histogram(aes(y=..density..),
                 bins=40,
                 col="red",
                 fill="steelblue") +
  geom_density(col=2) +
  facet_wrap(vars(feature))
################################################################################

ggplot(data=chol, aes(chol$AGE)) +
  geom_histogram(aes(y =..density..),
                 breaks=seq(20, 50, by = 2),
                 col="red",
                 fill="green",
                 alpha = .2) +
  geom_density(col=2) +
  labs(title="Histogram for Age") +
  labs(x="Age", y="Count")


############################################################################################
# normalization
normalize(x, method = "standardize", range = c(0, 1), margin = 1L, on.constant = "quiet")

normalize(df, method="standardize", range=c(0,1), margin=1L, on.constant="quiet")

############################################################################################
# standardize
library(effectsize)
standardize(df)
scale(df, center=TRUE, scale=TRUE)
normalize(scale(df, center=TRUE, scale=TRUE))
############# model using normalized-standardized data
df_transformed <- standardize(normalize(df, exclude="pts"), exclude="pts")
lm_transformed <- lm(pts~., data=df_transformed)
summary(lm_transformed)
############################################################################################
df_transformed_predictor <- standardize(normalize(df))
lm_transformed_predictor <- lm(pts~., data=df_transformed_predictor)
summary(lm_transformed_predictor)
############################################################################################
df_transformed_predictor_rev <- normalize(standardize(df))
lm_transformed_predictor_rev <- lm(pts~., data=df_transformed_predictor_rev)
summary(lm_transformed_predictor_rev)
############################################################################################
df_transformed_rev <- normalize(standardize(df, exclude="pts"), exclude="pts")
lm_transformed_rev <- lm(pts~., data=df_transformed_rev)
summary(lm_transformed_rev)
############################################################################################
summary(lm_transformed)
summary(lm_transformed_predictor)
summary(lm_transformed_predictor_rev)
summary(lm_transformed_rev)
############################################################################################
#df_transformed, df_transformed_predictor, df_transformed_predictor_rev, df_transformed_rev
#var(df_transformed_rev$goals_against)
df_gathered <- gather(df_transformed, key=feature, value=value)
ggplot(df_gathered, aes(value)) +
  geom_histogram(aes(y=..density..),
                 bins=15,
                 col="red",
                 fill="steelblue") +
  geom_density(col=2) +
  facet_wrap(vars(feature))
############################################################################################
df_transformed <- normalize(df, exclude="pts")
lm_transformed <- lm(pts~., data=df_transformed)
summary(lm_transformed)
############################################################################################
df_transformed <- standardize(df, exclude="pts")
lm_transformed <- lm(pts~., data=df_transformed)
summary(lm_transformed)
############################################################################################
# by goal_diff
goal_diff <- select(season_17 %>% arrange(desc(goal_diff)), team_name, team_id)

joined <- select(goal_diff %>% left_join(season_18, by=c('team_id'='team_id')),
                 team_name.x, team_id, rank, team_name.y)

distance <- abs(as.integer(rownames(joined)) - as.integer(joined$rank))

mean(distance[!is.na(distance)])

# by xGD
xgd <- select(season_17 %>% arrange(desc(xGD)), team_name, team_id)

joined <- select(xgd %>% left_join(season_18, by=c('team_id'='team_id')),
                 team_name.x, team_id, rank, team_name.y)

distance <- abs(as.integer(rownames(joined)) - as.integer(joined$rank))

mean(distance[!is.na(distance)])
############################################################################################
season_all.cor <- cor(select(season_all, -rank, -team_name, -team_id, -win, -draw, -loss))
colnames(sort(as.data.frame(season_all.cor)['pts',], decreasing=TRUE)[,2:6])
colnames(sort(as.data.frame(season_all.cor)['pts',], decreasing=FALSE)[,1:6])
#############################################################################################
########### goals_for/xG variance ###########################################################
as.data.frame(league_stats_all) %>%
  group_by(date) %>%
  summarise(goals_for = mean(scored), xG = mean(xG)) %>%
  gather(key=statistic, value=score, goals_for, xG) %>%
  ggplot(aes(x=date, y=score)) +
  geom_line(col="steelblue") +
  facet_grid(vars(statistic)) +
  theme_bw()

#
#
cut(tmp_2$matchdate, breaks=4)
tmp_2$matchdate[1]
vector(dates)
c(dates)[1]
dates[1]
cut(dates, breaks='14 days')
dates <- seq(from = min(tmp_2$matchdate), to = max(tmp_2$matchdate), length.out=380)
colnames(dates) <- 'matchdate'
dates %>%head()
as.data.frame(cbind(dates, tmp_2[,c('min', 'max')])) %>%head()



#
geom_pointrange(data = filter(df, date == as.Date(cut(date, breaks = "6 week"))), aes(x = date, ymin = lo, ymax = hi))

as.data.frame(league_stats_all) %>%
  group_by(date) %>%
  summarise(goals_for = mean(scored), xG = mean(xG)) %>%
  mutate(goals_for_avg_1=roll_mean(goals_for, 1, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_2=roll_mean(goals_for, 2, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_3=roll_mean(goals_for, 3, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_4=roll_mean(goals_for, 4, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_5=roll_mean(goals_for, 5, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_6=roll_mean(goals_for, 6, align = "right", fill = NA))

as.data.frame(league_stats_all) %>%
  group_by(date) %>%
  summarise(goals_for = mean(scored), xG = mean(xG)) %>%
  mutate(goals_for_avg_1=roll_mean(goals_for[1], 1, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_2=roll_mean(goals_for[2], 2, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_6=roll_mean(goals_for, 3, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_6=roll_mean(goals_for, 4, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_6=roll_mean(goals_for, 5, align = "right", fill = NA)) %>%
  mutate(goals_for_avg_6=roll_mean(goals_for, 6, align = "right", fill = NA))

league_stats_all %>% head()

###%>%
  gather(key=statistic, value=score, goals_for, xG) %>%
  mutate(average=roll_mean(score))


+
  geom_smooth()

library(ggplot2)
library(reshape2)
mtmelt <- melt(mtcars, id = "mpg")

ggplot(mtmelt, aes(x = value, y = mpg)) +
  facet_wrap(~variable, scales = "free") +
  geom_point()

#############################################################################################
########### overall ###########################################################

########### contenders ###########################################################
contenders <- filter(season_all, rank %in% c(2:4))
rownames(champions) <- champions$team_name
champions <- select(champions, -rank, -team_name, -team_id)

champ_Max <- apply(champions, 2, FUN=max)
champ_Min <- apply(champions, 2, FUN=min)
champ_Average <- colMeans(champions)
champ_properties <- rbind(champ_Max, champ_Min, champ_Average)
champ_properties <- as.data.frame(champ_properties)
rownames(champ_properties) <- c('Max', 'Min', 'Average')

#############################################################################################
############  position timeline ########################################################
aston_villa <- filter(league_stats_2014, team_name=="Aston Villa")
aston_villa <- aston_villa %>% select(scored, missed, pts, date)
aston_villa$rolling_pts <- 0
aston_villa$rolling_scored <- 0
aston_villa$rolling_against <- 0
aston_villa$rolling_diff <- 0

for (i in c(1:nrow(aston_villa))){
  aston_villa[c(i:nrow(aston_villa)),]$rolling_pts <- aston_villa[i,]$rolling_pts+aston_villa[i,]$pts
  aston_villa[c(i:nrow(aston_villa)),]$rolling_scored <- aston_villa[i,]$rolling_scored+aston_villa[i,]$scored
  aston_villa[c(i:nrow(aston_villa)),]$rolling_against <- aston_villa[i,]$rolling_against+aston_villa[i,]$missed
  aston_villa[c(i:nrow(aston_villa)),]$rolling_diff <- aston_villa[i,]$rolling_diff+(aston_villa[i,]$scored-aston_villa[i,]$missed)
  #print(aston_villa[c(i:nrow(aston_villa)),]$rolling)
  print(aston_villa[i,])
}

#############################################################################################
############### DECISION TREES
library(ISLR)
data(package="ISLR")
carseats<-Carseats
library(tree)
names(carseats)
hist(carseats$Sales)
High = ifelse(carseats$Sales<=8, "No", "Yes")
carseats = data.frame(carseats, High)
tree.carseats = tree(High~.-Sales, data=carseats)
summary(tree.carseats)
tree.carseats
plot(tree.carseats)
text(tree.carseats, pretty = 0)

select(season_all, -c(1:5), -win,-draw,-loss) %>% head()

tree.2014 <- tree(pts~., data=select(season_all, -c(1:5), -win,-draw,-loss))
plot(tree.2014)
text(tree.2014, pretty = 0)

#############################################################################################
library(ggcorrplot)
df <- select(iris, -Species)
ggcorrplot(select(season_all, -c(1:5)), label = TRUE)

ggcorrplot(cor_pmat(select(season_all, -c(1:5))))

ggcorrplot(season_all.cor)

season_all.cor <- cor(select(season_all, -c(1:5)))

ggcorr()


#############################################################################################
library(plotly)

fig <- plot_ly(type = 'parcoords', line = list(color = 'blue'),
               dimensions = list(
                 list(range = c(1,5),
                      constraintrange = c(1,2),
                      label = 'A', values = c(1,4)),
                 list(range = c(1,5),
                      tickvals = c(1.5,3,4.5),
                      label = 'B', values = c(3,1.5)),
                 list(range = c(1,5),
                      tickvals = c(1,2,4,5),
                      label = 'C', values = c(2,4),
                      ticktext = c('text 1', 'text 2', 'text 3', 'text 4')),
                 list(range = c(1,5),
                      label = 'D', values = c(4,2))
               )
)

fig

filter(platonic_table %>% head(), rank<3) %>%
  plot_ly(type='parcoord',
          line=list(color=~rank,
                    colorscale=list(c(0,'steelblue'), c(1,'skyblue'))),
          dimensions=list(
            list(range=(min(pts), max(pts)),
                 label='pts',
                 values=~pts),
            list(range=(min(mp), max(mp))
                 label='mp',
                 values=~mp)
          )
          )

mtcars %>% ggplot(aes(mpg, cyl)) + geom_line(col='skyblue')


library(lattice)
parallel(filter(platonic_table %>% head(), rank<3))

library(rrgobi)



#####################################################################################
############### Goals vs xG for following season

s14 <- select(season_14, team_name, g4_14=goals_for, xG_14=xG)
s15 <- select(season_15, team_name, g4_15=goals_for, xG_15=xG)
s16 <- select(season_16, team_name, g4_16=goals_for, xG_16=xG)
s17 <- select(season_17, team_name, g4_17=goals_for, xG_17=xG)
s18 <- select(season_18, team_name, g4_18=goals_for, xG_18=xG)
s19 <- select(season_19, team_name, g4_19=goals_for, xG_19=xG)

# combine
#data <- s15 %>% left_join(s14, on=team_name)
#data <- s16 %>% left_join(s15, on=team_name)
#data <- s17 %>% left_join(s16, on=team_name)
#data <- s18 %>% left_join(s17, on=team_name)
data <- s19 %>% left_join(s18, on=team_name)
colnames(data) <- c('team_name', 'g4', 'xG', 'g4b4', 'xGb4')

# impute
tempData <- mice(data,m=1,maxit=1,meth='mean',seed=500)
data <- complete(tempData)

# model
lin_model <- lm(g4~.-team_name-xG, data=data)
sum_lin <- summary(lin_model)
sum_lin$coefficients[,4]

# s14, s15 --> xg >
# s15, s16 --> g4 >
# s16, s16 --> xg >
# s17, s18 --> g4 >
# s18, s19 --> x4 >

###########################################################################################################################
sall_1 <- rbind(s14, s15, s16, s17)

sall_1 <- as.data.frame(sall_1 %>% group_by(team_name) %>% summarise(goals_for=mean(goals_for), xG=mean(xG)) %>% ungroup())

colnames(sall_1) <- c('team_name', 'goal_for_b4', 'xG_b4')

data <- s18 %>% left_join(sall_1, on=team_name)

tempData <- mice(data,m=1,maxit=1,meth='mean',seed=500)

data <- complete(tempData)

lin_model <- lm(goals_for~.-team_name-xG, data=data)
summary(lin_model)

data<-s15 %>% left_join(s14, on=team_name) %>% left_join(s15)

library(mice)
tempData <- mice(data,m=1,maxit=1,meth='mean',seed=500)
summary(tempData)
tempData$imp$feat20
data <- complete(tempData)
data %>% head()
lin_model <- lm(g4_15~.-team_name-xG_15, data=data)
summary(lin_model)

df_transformed <- standardize(normalize(df, exclude="pts"), exclude="pts")
lm_transformed <- lm(pts~., data=df_transformed)
summary(lm_transformed)

###########################################################################################################################
league_stats_2019 <- get_league_teams_stats(league_name = "EPL", year = 2019)
season_19 <- get_season(league_stats_2019)

league_stats_2019
# 1- retrieve xG, g4 previous match
# 2- add retrieved data to following week's data
# 3- build model to predict g4 nxt match
# 4- plot coeff

View(league_stats_2019)
sample_data <- league_stats_2019 %>% select(team_name, date, xG, scored) %>% as.data.frame() %>% head()
sample_data$xgb4 <- 0
sample_data$gb4 <- 0

for (i in c(2:nrow(sample_data))){
  prev <- sample_data[i-1,3:4]
  sample_data[i,c(ncol(sample_data)-1,ncol(sample_data))] <- prev
}

sample_data

prev <- sample_data[1,3:4]
this <- sample_data[2,4]
data <- as.data.frame(cbind(g4=sample_data[2,4], xg_b4=sample_data[1,3], g4_b4=sample_data[1,3]))

lin_model <- lm(g4~.,data=data)
summary(lin_model)


data <- NULL
for (i in unique(league_stats_2019$team_name)){
  data <- rbind(data, filter(league_stats_2019, team_name==i)%>% select(team_name, date, xG, scored) %>% as.data.frame())
}
data$xgb4 <- 0
data$gb4 <- 0

for (i in unique(league_stats_2019$team_name)){
  for (j in c(2:nrow(filter(data, team_name==i)))){
    prev <- data[j-1, 3:4]
    data[j,c(ncol(data)-1,ncol(data))] <- prev
  }
}

data %>% head()

lin_model <- lm(scored~.-team_name-date-xG, data=data)
summary(lin_model)

# 1- build the dataset
xgVSg4 <- rbind(league_stats_all, league_stats_2019)
data <- NULL
for (i in unique(xgVSg4$team_name)){
  data <- rbind(data, filter(xgVSg4, team_name==i)%>% select(team_name, date, xG, scored) %>% as.data.frame())
}
data$xgb4 <- 0
data$gb4 <- 0

for (i in unique(data$team_name)){
  tmp <- data[data$team_name==i,]
  for (j in 2:nrow(tmp)){
    prev <- tmp[j-1, 3:4]
    tmp[j,5:6] <- prev
  }
  data[as.integer(rownames(tmp)),] <- tmp
}

# 2- build the model
lin_model <- lm(scored~.-team_name-date-xG, data=data)
summary(lin_model)



####

data$scored <- factor(data$scored)

ggplot(data, aes(scored, gb4)) + geom_point()

ggplot(data, aes(scored, xgb4)) + geom_point()

ggplot(data, aes(scored, gb4)) + geom_boxplot()
ggplot(data, aes(scored, xgb4)) + geom_boxplot()

geom_boxplot(aes(color = Station))

data %>% gather(key=statistic, value=value, xgb4, gb4) %>% select(-date, -xG) %>%
  ggplot(aes(scored, value)) +
  geom_bar(aes(fill=statistic, color=statistic), stat = "identity", position = "dodge", width = 0.5)


ggplot(data, aes(scored)) +
  geom_bar(aes(fill=))


#########################3

season_all.cor %>% head()
season_all.cor2 <- as.data.frame(season_all.cor) %>% select(pts, win, goals_for, xG, deep, avgCP, everything()) %>% head()

as.data.frame(season_all.cor)[order(pts),]

ggcorrplot(season_all.cor,
           #type="upper", 
           lab=TRUE, 
           show.legend=FALSE,
           colors=c("steelblue", "white", "red"),
           lab_size = 2,
           hc.order = TRUE,
           #hc.method = "average",  
           outline.color='black',
           insig='pch',
           pch.col='red',
           pch.cex=0.001,
          show.diag = FALSE
           )

?hclust
"ward.D", 
"ward.D2", 
"single", 
"complete", 
"average", 
"mcquitty", 
"median",
"centroid"


##################### piechart

platonictable %>%
  mutate(win_p=win/mp*100,
         draw_p=draw/mp*100,
         loss_p=loss/mp*100,
         rank=factor(rank)) %>%
  select(rank, win_p, draw_p, loss_p) %>% filter(rank=='1')
  gather(key=result, value=percent_v, win_p, draw_p, loss_p) %>%
  ggplot(aes(x="", y=percent_v, fill=result)) + 
  scale_fill_manual(values=c("gray", "red", "steelblue")) + 
  geom_bar(stat="identity", position="fill") +
  coord_polar(theta = "y", start = 0) +
  facet_wrap(vars(rank)) +
  theme_bw()

  
  
as.data.frame(platonictable %>%
  mutate(win_p=win/mp*100,
         loss_p=loss/mp*100,
         draw_p=draw/mp*100,
         rank=factor(rank)) %>% 
    select(rank, win_p, draw_p, loss_p) %>% 
    filter(rank=='1')) %>% 
  gather(key=result, value=rate, win_p, loss_p, draw_p) %>%
  mutate(pos = cumsum(rate) - rate/2) %>%
    ggplot(aes(x="", y=rate, fill=result)) + 
    scale_fill_manual(values=c("gray", "red", "steelblue")) + 
    geom_col(position="stack") + geom_text(aes(y=pos, label=rate))
  # theme_minimal() +
  # theme(axis.title.y=element_blank(),
  #       axis.text.y=element_blank(),
  #       axis.ticks.y=element_blank())
    #+ geom_text()
    #coord_polar(theta = "y", start = 0)

theme(axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank())


platonictable %>%
  select(rank, goals_for, goals_against) %>%
  mutate(goals_against=goals_against*-1) %>%
  gather(key=event, value=number, goals_for, goals_against) %>%
  ggplot(aes(x=number, y=rank, fill=event)) + 
  geom_col() +
  scale_fill_manual(values=c("red", "steelblue")) +
  scale_y_reverse(breaks=seq(1,20,1)) +
  scale_x_continuous(breaks=seq(-100,100,10)) +
  theme_minimal() +
  labs(title='Goals for/agains') +
  theme(axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        legend.position='none')


platonictable %>%
  select(rank, goals_for, xG) %>%
  ggplot(aes(rank, goals_for)) +
  geom_col(position='identity', fill='steelblue') + 
  geom_point(aes(x=rank, y=xG), color='red', size=3) +
  geom_line(aes(x=rank, y=xG), color='red', size=1) +
  theme_minimal() +
  scale_x_continuous(breaks=seq(1,20,1)) +
  scale_y_continuous(breaks=seq(1,100,10)) +
  theme(axis.title.y=element_blank(),
        axis.title.x=element_blank())

platonictable %>%
  select(rank, goals_against, xGA) %>%
  ggplot(aes(rank, goals_against)) +
  geom_col(position='identity', fill='red') + 
  geom_point(aes(x=rank, y=xGA), color='steelblue', size=3) +
  geom_line(aes(x=rank, y=xGA), color='steelblue', size=1) +
  theme_minimal() +
  scale_x_continuous(breaks=seq(1,20,1)) +
  scale_y_continuous(breaks=seq(1,100,10)) +
  theme(axis.title.y=element_blank(),
        axis.title.x=element_blank())


platonictable %>%
  select(rank, goals_for, goals_against, xG, xGA) %>% 
  gather(key=goals, value=number, goals_for, goals_against) %>%
  gather(key=expected, value=x_number, xG, xGA) %>%
  filter((goals=='goals_for' & expected=='xG') | (goals=='goals_against' & expected=='xGA')) %>%
  mutate(phase=c(rep('Attack', 20), rep('Defense', 20))) %>%
  ggplot(aes(x=rank, y=number, fill=goals)) +
  geom_bar(stat='identity') +
  geom_point(aes(x=rank, y=x_number, col=expected)) +
  geom_line(aes(x=rank, y=x_number, col=expected)) +
  scale_fill_manual(name='', values=c('red', 'steelblue')) +
  scale_color_manual(name='', values=c('red', 'steelblue')) +
  facet_wrap(~phase) +
  theme_minimal() +
  theme(axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank()) +
  scale_y_continuous(breaks=seq(0,100,10)) +
  labs(title = "Goals and expected goals")

platonictable %>%
  select(rank, goals_for, goals_against, xG, xGA) %>% 
  gather(key=goals, value=number, goals_for, goals_against) %>%
  gather(key=expected, value=x_number, xG, xGA) %>%
  filter((goals=='goals_for' & expected=='xG') | (goals=='goals_against' & expected=='xGA')) %>%
  mutate(phase=c(rep('offense', 20), rep('defense', 20)),
         )

factor(x$phase, levels=c('A','B'))

x <- factor(c(rep('offense', 20), rep('defense', 20))) %>% revalue(c('A','B'))
x

factor(c("alpha","beta","gamma","alpha","beta")) %>% revalue(c("beta"="two", "gamma"="three"))

factor(x$phase, levels=sort(phase))

p1 <- ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point()

# You can assign different labellers to variables:
p1 + facet_grid(
  vs + am ~ gear,
  labeller = labeller(vs = label_both, am = label_value)
)



ggplot(df, aes(y=id)) +
  geom_point(aes(x=year, color=value1), size=4) +
  geom_point(aes(x=value3, colour ='value3'), size=3) +
  geom_point(aes(x=value2, colour ='value2'), size=5) +
  scale_colour_manual(name="",  
                      values = c("1"="yellow", "2"="orange", "3"="red",
                                 "value3"="grey", "value2"="black"))

platonictable %>%
  select(rank, goals_for, goals_against, xG, xGA) %>%
  ggplot(aes(x=rank, y=goals_for)) +
  geom_bar(aes(fill=goals_against), stat='identity') +
  geom_bar(aes(y=goals_against), stat='identity', fill='red', alpha=0.5) +
  theme_minimal()

# platonictable %>%
#   select(rank, goals_for, goals_against, xG, xGA) %>% 
#   gather(key=goals, value=number, -rank, -xG, -xGA) %>% 
#   spread(rank, number) %>%
#   gather(key=)
#   
#   gather(key=expected, value=x.numbers, -rank, -goals, -number) %>%
#   spread(rank)
# 
#   separate(goals, c('expected, x_number'), sep='^x+')
#   
#   spread(goals, number)
#   #gather(key=expected, value=x_number, xG, xGA, -goals, -number)
# 
# 
# df <- data.frame(
#   id = 1:10,
#   time = as.Date('2009-01-01') + 0:9,
#   Q3.2.1. = rnorm(10, 0, 1),
#   Q3.2.2. = rnorm(10, 0, 1),
#   Q3.2.3. = rnorm(10, 0, 1),
#   Q3.3.1. = rnorm(10, 0, 1),
#   Q3.3.2. = rnorm(10, 0, 1),
#   Q3.3.3. = rnorm(10, 0, 1)
# )
# 
# df %>%
#   gather(key, value, -id, -time) %>%
#   extract(key, c("question", "loop_number"), "(Q.\\..)\\.(.)")
# 
# 
#   
#   
#   
#   group_by(rank) %>%
#   #summarise(expected=goals[goals=='xG'], number=number[goals=='xG'])
#   summarise(expected=rbind(goals[goals=='xG'],goals[goals=='xGA']))
#   
#   
#   #extract(goals, c('expected', 'xnumbers'), "(xG)(xGA)")
#   
# x <-platonictable %>%
#     select(rank, goals_for, goals_against, xG, xGA) %>% 
#     gather(key=goals, value=number, -rank)
# 
# x[x$goals=='xG' | x$goals=='xGA',]


platonictable %>%
  select(rank, deep, avgCP) %>%
  gather(key, value, -rank) %>%
  ggplot(aes(x=rank, y=value, fill=key)) +
  geom_bar(stat='identity', position='fill')

platonictable %>%
  select(rank, avgCP) %>%
  gather(key, value, -rank) %>%
  ggplot(aes(x=rank, y=value, fill=key)) +
  #geom_bar(stat='identity', position='fill', width=0.4) + 
  geom_col(position='stack')

platonictable %>%
  select(rank, deep) %>%
  gather(key, value, -rank) %>%
  ggplot(aes(x=rank, y=value, fill=key)) +
  #geom_bar(stat='identity', position='fill', width=0.4) + 
  geom_col(position='stack')

platonictable %>%
  select(rank, xG, deep, avgCP, ppda) %>%
  mutate(active_possesion=deep/avgCP*100,
         direct_play=deep/xG,
         ppda=ppda/10) %>%
  ggplot(aes(active_possesion, direct_play)) +
  geom_point() +
  geom_text(aes(active_possesion, direct_play, label=rank))

platonictable %>%
  select(rank, xG, deep, avgCP, ppda) %>%
  mutate(active=deep/avgCP*100,
         direct=deep/xG) %>%
  ggplot() +
  geom_circle(aes(x0 = active, y0 = direct, r = ppda/150, fill=ppda, alpha=0), show.legend=TRUE) +
  scale_fill_gradient2(low='steelblue', mid='white', high='red', midpoint=mean(platonictable$ppda)) +
  geom_text(aes(active, direct, label=rank)) +
  theme_minimal() +
  theme(legend.position='right',
        axis.text=element_blank(),
        axis.title=element_text(size=16)) +
  labs(title='Directness, activeness, workrate',
       x='Active Possession',
       y='Directness') +
  geom_segment(aes(x=1.9, xend=4.0, y=4.0, yend=4.0), size=1,
               arrow = arrow(length = unit(0.6,"cm")))  +
  geom_segment(aes(x=1.9, xend=1.9, y=4.0, yend=6.5), size=1,
               arrow = arrow(length = unit(0.6,"cm"))) +
  guides(alpha=FALSE)
  


breaks=c(9.0, 10.5, 12.0),
labels=c(9.0, 10.5, 12.0),
limits=c(0,10)



midpoint <- range(x$ppda)[2]-((range(x$ppda)[2]-range(x$ppda)[1])/2)

x <- platonictable %>%
  select(rank, xG, deep, avgCP, ppda) %>%
  mutate(active=deep/avgCP*100,
         direct=deep/xG,
         ppda=ppda/150)



work %>% 
ggplot() +
  geom_circle(aes(x0 = active, y0 = direct, r = ppda, fill = ppda))

ggplot() +
  geom_cirlce(aes(x0=active, y0=direct, r=ppda, fill=ppda), data=work)

# Behold the some circles
ggplot() +
  geom_circle(aes(x0 = x0, y0 = y0, r = r, fill = r), data = circles)


platonictable %>%
  select(rank, xG, deep) %>%
  mutate(directness=deep/xG) %>%
  ggplot(aes(rank, directness)) +
  geom_bar(stat='identity')

platonictable %>%
  select(rank, ppda) %>%
  ggplot(aes(rank,ppda)) +
  geom_bar(stat='identity')

platonictable %>% head()

library(ggforce)
# circles are drawn centered at x and y

data(mpg)
ggplot(mpg, aes(displ, hwy)) + geom_circle(radius=0.1) + geom_point()
ggplot(mpg, aes(displ, hwy)) + geom_circle(linetype=2, radius=0.05, alpha=0.5)
ggplot(mpg, aes(displ, hwy)) + geom_circle(aes(linetype=factor(cyl)), radius=0.05, alpha=0.5)

circles <- data.frame(
  x0 = rep(1:3, 3),
  y0 = rep(1:3, each = 3),
  r = seq(0.1, 1, length.out = 9)
)

circles



########################################################################

install.packages(c("rgeos", "gpclib", "maptools", "sp"))

library(rgeos)
library(maptools)
library(gpclib)
library(rgdal)
library(sf)

# MAP
# np_dist <- readShapeSpatial("data/NHS_England_Regions/NHS_England_Regions.shp")
# np_dist <- st_read("data/NHS_England_Regions/NHS_England_Regions.shp")
np_dist <- readShapeSpatial('/home/minasonbol/R/Projects/GENERAL/FOOTBALL/data/gadm36_GBR_shp/gadm36_GBR_1.shp')
# VERIFY IT LOADED PROPERLY
plot(np_dist)


library(GGcorr)
########################################################################
###### add league_name, season, matchday to match_ids###################
head(match_ids)


d <- 5
for(i in 1:10) { 
  nam <- paste("A", i, sep = "")
  assign(nam, rnorm(3)+d)
}


match_stats <- get_match_stats(match_id = 81)
match_shots <- get_match_shots(match_id = 81)
View(match_stats)
View(match_shots)

class(unique(get_match_shots(match_id = 11662)[,'date']))

date_x <- data.frame(get_match_shots(match_id = 11662)[1,'date'])
year(x)

class(x$date)
class(as.Date(x$date))

match_ids[match_ids$match_id == 11662,]$date <- as.Date(x$date)
match_ids[match_ids$match_id == 11662,]$date


class(match_ids$date) <- "Date"

table(match_ids$league_name)

lapply(
  X = v_dist,
  FUN = function(distance_method) dist(
    x = scale_M,
    method = distance_method
  )
)

match_ids$date > as.Date('2019-12-31')

match_ids$season <- lapply(
  X = match_ids$date,
  FUN = function(matchdate){
    if((matchdate > as.Date('2014-07-31')) & (matchdate < as.Date('2015-06-01'))){
      return ('2014/15')
    } else if ((matchdate > as.Date('2015-07-31')) & (matchdate < as.Date('2016-06-01'))) {
      return ('2015/16')
    } else if ((matchdate > as.Date('2016-07-31')) & (matchdate < as.Date('2017-06-01'))) {
      return ('2016/17')
    } else if ((matchdate > as.Date('2017-07-31')) & (matchdate < as.Date('2018-06-01'))) {
      return ('2017/18')
    } else if ((matchdate > as.Date('2018-07-31')) & (matchdate < as.Date('2019-06-01'))) {
      return ('2018/19')
    } else if ((matchdate > as.Date('2019-07-31')) & (matchdate < as.Date('2020-06-01'))) {
      return ('2019/20')
    }
  }
)

match_ids$date

View(match_ids)
View(is.na(match_ids$season))

cat(sprintf("\"%f\" \"%f\"\n", df$r, df$interest))
cat(sprintf("\"%f\"", matchdate, '2014/15'))


if((match_ids$date > as.Date('2014-07-31')) & (match_ids$date < as.Date('2015-06-01'))){
  '2014/15'
} else if ((match_ids$date > as.Date('2015-07-31')) & (match_ids$date < as.Date('2016-06-01'))) {
  '2015/16'
} else if ((match_ids$date > as.Date('2016-07-31')) & (match_ids$date < as.Date('2017-06-01'))) {
  '2016/17'
} else if ((match_ids$date > as.Date('2017-07-31')) & (match_ids$date < as.Date('2018-06-01'))) {
  '2017/18'
} else if ((match_ids$date > as.Date('2018-07-31')) & (match_ids$date < as.Date('2019-06-01'))) {
  '2018/19'
} else if ((match_ids$date > as.Date('2019-07-31')) & (match_ids$date < as.Date('2020-06-01'))) {
  '2019/20'
}


vapply(
  X = match_ids$date,
  FUN = function(matchdate){
    if((matchdate > as.Date('2014-07-31')) & (matchdate < as.Date('2015-06-01'))){
      return ('2014/15')
    } else if ((matchdate > as.Date('2015-07-31')) & (matchdate < as.Date('2016-06-01'))) {
      return ('2015/16')
    } else if ((matchdate > as.Date('2016-07-31')) & (matchdate < as.Date('2017-06-01'))) {
      return ('2016/17')
    } else if ((matchdate > as.Date('2017-07-31')) & (matchdate < as.Date('2018-06-01'))) {
      return ('2017/18')
    } else if ((matchdate > as.Date('2018-07-31')) & (matchdate < as.Date('2019-06-01'))) {
      return ('2018/19')
    } else if ((matchdate > as.Date('2019-07-31')) & (matchdate < as.Date('2020-06-01'))) {
      return ('2019/20')
    } else {
      return ('NA')
    }
  },
  FUN.VALUE = character(1)
)

length('2019/20')

match_ids$date[2266]
match_ids[2266,]


match_ids <- match_ids[order(match_ids$date),]

nrow(match_ids[(match_ids$h_team=='AC Milan' | match_ids$a_team=='AC Milan') & match_ids$season=='2014/15',])

X = match_ids$h_team
FUN = function(team){
  seq(1:38)
}

seq(1:38)

View(match_ids)
View(match_ids[order(match_ids$league_name),])

bayern_season <- match_ids[(match_ids$h_team == 'Bayern Munich' | match_ids$a_team == 'Bayern Munich') & match_ids$season %in% c('2014/15', '2015/16'),]

bayern_1415$week <- seq(1:nrow(bayern_1415))

bayern_season$week <- 0

for (i in unique(bayern_season$season)){
  bayern_season[bayern_season$season==i,]$week <- seq(1:nrow(bayern_season[bayern_season$season==i,]))
}

match_ids$week <- 0
for (i in unique(match_ids$h_team)){
  team <- match_ids[(match_ids$h_team==i | match_ids$a_team==i),]
  for (j in unique(team$season)){
    match_ids[(match_ids$h_team==i | match_ids$a_team==i) & match_ids$season==j,]$week <- 
      seq(1:nrow(match_ids[(match_ids$h_team==i | match_ids$a_team==i) & match_ids$season==j,]))
    print(i)
    print(j)
    print(match_ids[(match_ids$h_team==i | match_ids$a_team==i) & match_ids$season==j,])
  }
}
#########################################################################################################
################################# Digging into matches ##################################################
rownames(match_ids) <- seq(1:nrow(match_ids))
head(match_ids)
match_shots <- get_match_shots(match_id = match_ids[1,]$match_id)
View(match_shots)
match_stats <- get_match_stats(match_id = match_ids[1,]$match_id)
View(match_stats)

get_team_players_stats(team_name = "Newcastle United", year = 2018)
View(team_players_stats)

lubridate::year(match_ids$date)
substring(match_ids$season,1,4)

bundesliga_2019 <- get_league_teams_stats(league_name = "Bundesliga", year = 2019)
season_19 <- get_season(bundesliga_2019)
source('R/points_and_features_scatter.R', print.eval=TRUE)

season_19 %>%
select(-rank, -team_name, -team_id, -mp, -year) %>%
  melt(id = "pts") %>%
  ggplot(aes(x=pts, y=value)) +
  geom_point(col='steelblue') +
  geom_smooth(col='red', alpha=0.2, size=0.7) +
  facet_wrap(~variable, scales = "free") +
  theme_minimal() +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  labs(title = "Relationship between points and other factors",
       x ='Points')

season_scatter(season_19)

#tmp[is.na(tmp$goals_for_avg),]

colnames(is.na(tmp))
summary(tmp)
class(tmp)

colz <- colnames(tmp)[colSums(is.na(tmp)) > 0]
colz[1]
tmp[,colz[1]]
is.na(tmp[,colz[1]])


#tmp$goals_for_avg[1] <- roll_mean(tmp$goals_for, 1, align='right', fill=NA)[1]
tmp[1,colz[1]]

mean()

tmp$goals_for

tmp[1:2,'goals_for']
colnames(tmp)

tmp[1:2,colz[1]]

# inputs:
#   null colnames - null_cols[]
#   data colnames - col_func[1]
#   function - col_func[2]
#   nrows

tmp[1,colz[1]] <- mean(as.numeric(tmp[1:1,'goals_for']))

length(colnames(tmp)[colSums(is.na(tmp)) > 0])

head(tmp)
null_cols <- colnames(tmp)[colSums(is.na(tmp)) > 0]
for (i in c(1:length(null_cols))){
  col_func <- scan(what="", text=null_cols[i], sep=".")
  print(col_func)
  # print(null_cols[i])
  #for (j in c(1:colSums(is.na(tmp[,null_cols[i]])))){
  # for (j in c(1:colSums(is.na(tmp[,null_cols[1]])))){
  #   print(tmp[j,null_cols[i]])
  # }
  for (j in 1:sum(is.na(tmp[,null_cols[i]]))){
    #print(j)
    #print(tmp[j,null_cols[i]])
    #tmp[j,null_cols[i]]
    print(tmp[1:j,col_func[1]])
    print(get(col_func[2])(tmp[1:j,col_func[1]]))
  }
}

as.numeric()

tmp[1:2,col_func[1]]

tmp[1:1,col_func[1]]

col_func[1]

#for (j in ){}

for (j in 1:colSums(is.na(tmp[,null_cols[i]]))){
  print(tmp[j,null_cols[i]])
}
  
tmp[rownumofemptycol, coname]

col_func <- scan(what="", text=null_cols[1], sep=".")[2]
colSums(is.na(tmp[,null_cols[i]]))
null_cols
#goals_for_avg
#goals_for_min
#goals_for_max
#xG_mean
#xG_min
#xG_max

head(tmp)

strsplit(null_cols[1], "[.]")

x <- scan(what="", text=null_cols[1], sep=".")[2]

get(x)(1:3)
mean(1:3)


df_a <- tmp %>% select(matchdate, starts_with('xG'), -xG) %>% mutate(measure='xG')
df_b <- tmp %>% select(matchdate, starts_with('goals'), -goals_for) %>% mutate(measure='goals_for')
colnames(df_a) <- c('matchdate', 'mean', 'min', 'max', 'measure')
colnames(df_b) <- c('matchdate', 'mean', 'min', 'max', 'measure')
tmp_2 <- rbind(df_a, df_b)

head(tmp)
tmp %>% select(matchdate, starts_with('xG'), -xG) %>% mutate(measure='xG') %>% head()

View(pivot_longer(tmp,
             c(goals_for.mean, xG.mean),
             names_to='measure',
             values_to='averages') %>%
  pivot_longer(c(goals_for.min, xG.min),
               names_to='measure_min',
               values_to='min') %>%
  pivot_longer(c(goals_for.max, xG.max),
               names_to='measure_max',
               values_to='max') %>%
  filter((measure=='goals_for.mean' & measure_min=='goals_for.min' & measure_max=='goals_for.max') | 
           (measure=='xG.mean' & measure_min=='xG.min' & measure_max=='xG.max')) %>%
    select(matchdate, averages, min, max, measure) %>%
    mutate(measure=ifelse(measure=='goals_for.mean', 'goals_for', 'xG')))

mutate(popular=ifelse(popular=='approve_estimate', 'approve', 'disapprove'))

# pivot_longer(approval_topline, 
#              c(approve_estimate, disapprove_estimate), 
#              names_to='popular', 
#              values_to='estimate') %>%
#   pivot_longer(c(approve_hi, disapprove_hi), names_to='popular_hi', values_to='hi') %>%

View(tmp_2)

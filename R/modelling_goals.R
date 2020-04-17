############################################################################################
########### GOALS_FOR VS XG ################################################################
########### NO TRANSFORMATIONS #############################################################
df <- select(season_all, pts, goals_for, xG)
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### NORMALIZED FEATURES #############################################################
df <- select(season_all, pts, goals_for, xG)
df <- normalize(df, exclude="pts")
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### NORMALIZED ALL ##################################################################
df <- select(season_all, pts, goals_for, xG)
df <- normalize(df)
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### STANDARDIZED FEATURES ###########################################################
df <- select(season_all, pts, goals_for, xG)
df <- standardize(df, exclude="pts")
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### STANDARDIZED ALL ################################################################
df <- select(season_all, pts, goals_for, xG)
df <- standardize(df)
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### STANDARDIZED->NORMALIZE FEATURES ################################################
df <- select(season_all, pts, goals_for, xG)
df <- normalize(standardize(df, exclude="pts"), exclude="pts")
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### STANDARDIZED->NORMALIZE ALL #####################################################
df <- select(season_all, pts, goals_for, xG)
df <- normalize(standardize(df))
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### NORMALIZE->STANDARDIZED FEATURES ################################################
df <- select(season_all, pts, goals_for, xG)
df <- normalize(standardize(df, exclude="pts"), exclude="pts")
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### NORMALIZE->STANDARDIZED ALL #####################################################
df <- select(season_all, pts, goals_for, xG)
df <- normalize(standardize(df))
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### goals only ALL #####################################################
df <- select(season_all, pts, goals_for)
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### xg only ALL #####################################################
df <- select(season_all, pts, xG)
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### goals_for for wins #####################################################
df <- select(season_all, win, goals_for)
linear_model <- lm(win ~ ., data=df)
summary(linear_model)
#############################################################################################
########### xG for wins #####################################################
df <- select(season_all, win, xG)
linear_model <- lm(win ~ ., data=df)
summary(linear_model)
########### goal_diff for pts #####################################################
df <- select(season_all, pts, goal_diff)
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### xgd for pts #####################################################
df <- select(season_all, pts, xGD)
linear_model <- lm(pts ~ ., data=df)
summary(linear_model)
########### goal_diff for wins #####################################################
df <- select(season_all, win, goal_diff)
linear_model <- lm(win ~ ., data=df)
summary(linear_model)
########### xgd for wins #####################################################
df <- select(season_all, win, xGD)
linear_model <- lm(win ~ ., data=df)
summary(linear_model)

goalsVSxg <- function(league_stats){
  # 1- build the dataset
  xgVSg4 <- league_stats
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
  lin_model_xg <- lm(scored~xgb4, data=data)
  lin_model_g4 <- lm(scored~gb4, data=data)

  model_xg <- as.data.frame(cbind(lin_model_xg$fitted.values, lin_model_xg$residuals))
  colnames(model_xg) <- c('fitted.values', 'residuals')

  model_xg_sum <- summary(lin_model_xg)
  model_g4_sum <- summary(lin_model_g4)

  r.sqr <- c(model_xg_sum$r.squared, model_g4_sum$r.squared)
  r.sqr <- as.data.frame(r.sqr)
  r.sqr$models <- c('xG', 'goals')
  
  # separate models
  r.sqr_plot <- ggplot(r.sqr, aes(x=models, y=r.sqr)) +
    geom_bar(stat='identity', fill=c('steelblue', 'red')) +
    theme_minimal() +
    theme(axis.title.y=element_blank(),
          axis.title.x=element_blank()) +
    labs(title = 'R-squared comparison')
  
  # combined model
  lin_model <- lm(scored~.-team_name-date-xG, data=data)
  
  return(list(r.sqr_plot, summary(lin_model)))
}
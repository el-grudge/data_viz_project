# Correlation matrix
season_corrplot <- function(season){
  season_all.cor <- cor(select(season, -c(1:5), -goal_diff))
  ggcorrplot(season_all.cor, #type="upper", 
             lab=TRUE, 
             show.legend=FALSE,
             colors=c("steelblue", "white", "red"),
             hc.order=TRUE,
             lab_size = 2,
             outline.color='black')
}
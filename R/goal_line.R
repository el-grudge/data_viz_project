goal_line <- function(league_stats){
  # create rolling aggregate table
  tmp <- data.frame(league_stats %>%
                      mutate(matchday=rep(c(1:38), length(league_stats_all$year)/38)) %>%
                      select(matchday, everything()) %>%
                      group_by(matchday, year) %>%
                      summarise(matchdate=min(date), goals_for = mean(scored), xG = mean(xG)) %>%
                      ungroup() %>%
                      select(-matchday, -year) %>%
                      arrange(matchdate) %>%
                      mutate(goals_for.mean=roll_mean(goals_for, 6, align='right', fill=NA),
                             goals_for.min=roll_min(goals_for, 6, align='right', fill=NA),
                             goals_for.max=roll_max(goals_for, 6, align='right', fill=NA),
                             xG.mean=roll_mean(xG, 6, align='right', fill=NA),
                             xG.min=roll_min(xG, 6, align='right', fill=NA),
                             xG.max=roll_max(xG, 6, align='right', fill=NA)))
  
  # filling empty cells
  null_cols <- colnames(tmp)[colSums(is.na(tmp)) > 0]
  for (i in c(1:length(null_cols))){
    col_func <- scan(what="", text=null_cols[i], sep=".")
    for (j in 1:sum(is.na(tmp[,null_cols[i]]))){
      tmp[j, null_cols[i]] <- get(col_func[2])(tmp[1:j,col_func[1]])
    }
  }
  
  # manipulate the table
  # plot
  tmp %>%
    pivot_longer(c(goals_for.mean, xG.mean),
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
    mutate(measure=ifelse(measure=='goals_for.mean', 'goals_for', 'xG')) %>%
    ggplot(aes(matchdate, averages)) +
    geom_line(col='steelblue') +
    geom_ribbon(aes(ymin = min, ymax = max), fill='steelblue', alpha=0.2, col='steelblue', size=0.2) +
    geom_pointrange(data=function(x) {filter(x, matchdate==as.Date(cut(matchdate, breaks=10)))}, aes(ymin=min, ymax=max), col='steelblue') +
    facet_grid(vars(measure)) +
    theme_minimal() +
    theme(axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.title.x=element_blank()) +
    labs(title = 'Goal & xG averages with Min-Max Range')
}
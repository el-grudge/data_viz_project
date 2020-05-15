pyramid <- function(gdpyramid) {
  # Goal difference pyramid
  gdpyramid %>%
    select(rank, goals_for, goals_against) %>%
    mutate(goals_against=goals_against*-1) %>%
    gather(key=event, value=number, goals_for, goals_against) %>%
    ggplot(aes(x=number, y=rank, fill=event)) + 
    geom_col() +
    scale_fill_manual(values=c("red", "steelblue")) +
    scale_y_reverse(breaks=seq(1,20,1)) +
    scale_x_continuous(breaks=seq(-100,100,10)) +
    theme_minimal() +
    labs(title='Goals for/against') +
    theme(axis.title.y=element_blank(),
          axis.title.x=element_blank(),
          legend.position='none')
  }
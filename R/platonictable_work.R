workrate <- function(worktable){
  # Attitude and work
  worktable %>%
    select(rank, xG, deep, CP, ppda) %>%
    mutate(active=deep/CP*100,
           ppda=-ppda) %>%
    ggplot() +
    geom_circle(aes(x0 = active, y0 = ppda/4, r = xG/1000, fill=xG, alpha=1), show.legend=TRUE) +
    scale_fill_gradient2(low='red', mid='white', high='steelblue', midpoint=mean(platonictable$xG)) +
    geom_text(aes(active, ppda/4, label=rank), size=3) +
    theme_minimal() +
    labs(title='Directness, activeness, workrate',
         x='Active Possession',
         y='Passes per Defensive Action') +
    theme(legend.position='right',
          axis.title=element_text(size=16),
          plot.title=element_text(vjust=2.1, size=15),
          axis.text=element_blank(),
          axis.title.x=element_text(size=10),
          axis.title.y=element_text(size=10)) +
    guides(alpha=FALSE) +
    scale_x_continuous(position = 'top') +
    geom_segment(aes(x=2.0, xend=4.0, y=-1.75, yend=-1.75), size=1,
                 arrow = arrow(length = unit(0.6,"cm")))  +
    geom_segment(aes(x=2.0, xend=2.0, y=-1.75, yend=-3.5), size=1,
                 arrow = arrow(length = unit(0.6,"cm")))
  }
# ranking lollipop
platonictable %>%
  select(rank, pts) %>% 
  ggplot(aes(pts, rank)) +
  geom_point(size=4, color='red') + 
  geom_segment(aes(xend=0, yend=rank), col='steelblue', size=2) +
  scale_y_reverse(breaks=seq(1,20,1)) +
  scale_x_continuous(breaks=seq(0,100,5)) +
  theme_minimal() +
  theme(axis.title.y=element_blank(),
        axis.ticks.y=element_blank()) +
  labs(title = 'Average points tally per rank',
       x = 'Points')

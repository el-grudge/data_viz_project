# Attitude and work
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
        axis.title=element_text(size=16)) +
  labs(title='Directness, activeness, workrate',
       x='Active Possession',
       y='Directness') +
  geom_segment(aes(x=1.9, xend=4.0, y=4.0, yend=4.0), size=1,
               arrow = arrow(length = unit(0.6,"cm")))  +
  geom_segment(aes(x=1.9, xend=1.9, y=4.0, yend=6.5), size=1,
               arrow = arrow(length = unit(0.6,"cm"))) +
  guides(alpha=FALSE)

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
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  labs(title = 'Average points tally per rank',
       x = 'Points')


# win/lose/draw piechart
platonictable %>%
  mutate(win_p=win/mp*100,0,
         draw_p=draw/mp*100,0,
         loss_p=loss/mp*100,0,
         rank=factor(rank)) %>%
  select(rank, win_p, draw_p, loss_p) %>% 
  gather(key=result, value=percent, win_p, loss_p, draw_p) %>%
  group_by(rank) %>%
  mutate(pos = cumsum(percent) - percent/2) %>%
  ungroup %>%
  ggplot(aes(x="", y=percent, fill=result)) + 
  scale_fill_manual(values=c("gray", "red", "steelblue")) + 
  geom_col(position="stack") +
  coord_polar(theta = "y", start = 0) +
  theme_minimal() +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        legend.position="none") +
  geom_text(aes(y=pos, label=as.integer(percent)), size=2) +
  scale_y_continuous(breaks=seq(0,100,10)) +
  facet_wrap(vars(rank)) + 
  labs(title='win-lose-draw percentages')


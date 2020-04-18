# win/lose/draw piechart
platonictable %>%
  mutate(win_p=win/mp*100,0,
         draw_p=draw/mp*100,0,
         loss_p=loss/mp*100,0,
         rank=factor(rank)) %>%
  select(rank, win_p, draw_p, loss_p) %>% 
  mutate(win=win_p, draw=draw_p, loss=loss_p) %>%
  select(rank, win, draw, loss) %>% 
  gather(key=result, value=percent, win, loss, draw) %>%
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
        axis.ticks.x=element_blank()) +
        #legend.position="none") +
  geom_text(aes(y=pos, label=as.integer(percent)), size=2) +
  scale_y_continuous(breaks=seq(0,100,10)) +
  facet_wrap(vars(rank)) + 
  labs(title='win-lose-draw percentages')


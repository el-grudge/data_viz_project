# Goal difference (pyramid)
platonictable %>%
  select(rank, goals_for, goals_against, xG, xGA) %>% 
  gather(key=goals, value=number, goals_for, goals_against) %>%
  gather(key=expected, value=x_number, xG, xGA) %>%
  filter((goals=='goals_for' & expected=='xG') | (goals=='goals_against' & expected=='xGA')) %>%
  mutate(phase=c(rep('Attack', 20), rep('Defense', 20))) %>%
  ggplot(aes(x=rank, y=number, fill=goals)) +
  geom_bar(stat='identity') +
  geom_point(aes(x=rank, y=x_number, col=expected), show.legend=FALSE) +
  geom_line(aes(x=rank, y=x_number, col=expected)) +
  scale_fill_manual(name='', values=c('red', 'steelblue')) +
  scale_color_manual(name='', values=c('red', 'steelblue')) +
  facet_col(~phase) +
  theme_minimal() +
  theme(axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank()) +
  scale_y_continuous(breaks=seq(0,100,10)) +
  labs(title = "Goals and expected goals") +
  guides()
# Scatter plots
season_all %>%
  select(-rank, -team_name, -team_id, -mp, -year) %>%
  melt(id = "pts") %>%
  ggplot(aes(x=pts, y=value)) +
  geom_point(col='steelblue') +
  geom_smooth(col='red', alpha=0.2, size=0.7) +
  facet_wrap(~variable, scales = "free") +
  theme_minimal() +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  labs(title = "Relationship between points and other factors",
       x ='Points')
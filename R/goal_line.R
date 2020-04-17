tmp <- league_stats_all %>%
  mutate(matchday=rep(c(1:38), length(league_stats_all$year)/38)) %>%
  select(matchday, everything()) %>%
  group_by(matchday, year) %>%
  summarise(matchdate=min(date), goals_for = mean(scored), xG = mean(xG)) %>%
  ungroup() %>%
  select(-matchday, -year) %>%
  arrange(matchdate) %>%
  mutate(goals_for_avg=roll_mean(goals_for, 6, align='right', fill=NA),
         goals_for_min=roll_min(goals_for, 6, align='right', fill=NA),
         goals_for_max=roll_max(goals_for, 6, align='right', fill=NA),
         xG_mean=roll_mean(xG, 6, align='right', fill=NA),
         xG_min=roll_min(xG, 6, align='right', fill=NA),
         xG_max=roll_max(xG, 6, align='right', fill=NA))

tmp$goals_for_avg[1] <- roll_mean(tmp$goals_for, 1, align='right', fill=NA)[1]
tmp$goals_for_avg[2] <- roll_mean(tmp$goals_for, 2, align='right', fill=NA)[2]
tmp$goals_for_avg[3] <- roll_mean(tmp$goals_for, 3, align='right', fill=NA)[3]
tmp$goals_for_avg[4] <- roll_mean(tmp$goals_for, 4, align='right', fill=NA)[4]
tmp$goals_for_avg[5] <- roll_mean(tmp$goals_for, 5, align='right', fill=NA)[5]

tmp$goals_for_min[1] <- roll_min(tmp$goals_for, 1, align='right', fill=NA)[1]
tmp$goals_for_min[2] <- roll_min(tmp$goals_for, 2, align='right', fill=NA)[2]
tmp$goals_for_min[3] <- roll_min(tmp$goals_for, 3, align='right', fill=NA)[3]
tmp$goals_for_min[4] <- roll_min(tmp$goals_for, 4, align='right', fill=NA)[4]
tmp$goals_for_min[5] <- roll_min(tmp$goals_for, 5, align='right', fill=NA)[5]

tmp$goals_for_max[1] <- roll_max(tmp$goals_for, 1, align='right', fill=NA)[1]
tmp$goals_for_max[2] <- roll_max(tmp$goals_for, 2, align='right', fill=NA)[2]
tmp$goals_for_max[3] <- roll_max(tmp$goals_for, 3, align='right', fill=NA)[3]
tmp$goals_for_max[4] <- roll_max(tmp$goals_for, 4, align='right', fill=NA)[4]
tmp$goals_for_max[5] <- roll_max(tmp$goals_for, 5, align='right', fill=NA)[5]

tmp$xG_mean[1] <- roll_mean(tmp$xG, 1, align='right', fill=NA)[1]
tmp$xG_mean[2] <- roll_mean(tmp$xG, 2, align='right', fill=NA)[2]
tmp$xG_mean[3] <- roll_mean(tmp$xG, 3, align='right', fill=NA)[3]
tmp$xG_mean[4] <- roll_mean(tmp$xG, 4, align='right', fill=NA)[4]
tmp$xG_mean[5] <- roll_mean(tmp$xG, 5, align='right', fill=NA)[5]

tmp$xG_min[1] <- roll_min(tmp$xG, 1, align='right', fill=NA)[1]
tmp$xG_min[2] <- roll_min(tmp$xG, 2, align='right', fill=NA)[2]
tmp$xG_min[3] <- roll_min(tmp$xG, 3, align='right', fill=NA)[3]
tmp$xG_min[4] <- roll_min(tmp$xG, 4, align='right', fill=NA)[4]
tmp$xG_min[5] <- roll_min(tmp$xG, 5, align='right', fill=NA)[5]

tmp$xG_max[1] <- roll_max(tmp$xG, 1, align='right', fill=NA)[1]
tmp$xG_max[2] <- roll_max(tmp$xG, 2, align='right', fill=NA)[2]
tmp$xG_max[3] <- roll_max(tmp$xG, 3, align='right', fill=NA)[3]
tmp$xG_max[4] <- roll_max(tmp$xG, 4, align='right', fill=NA)[4]
tmp$xG_max[5] <- roll_max(tmp$xG, 5, align='right', fill=NA)[5]

df_a <- tmp %>% select(matchdate, starts_with('xG'), -xG) %>% mutate(measure='xG')
df_b <- tmp %>% select(matchdate, starts_with('goals'), -goals_for) %>% mutate(measure='goals_for')
colnames(df_a) <- c('matchdate', 'mean', 'min', 'max', 'measure')
colnames(df_b) <- c('matchdate', 'mean', 'min', 'max', 'measure')
tmp_2 <- rbind(df_a, df_b)

tmp_2 %>%
  ggplot(aes(matchdate, mean)) +
  geom_line(col='steelblue') +
  geom_ribbon(aes(ymin = min, ymax = max), fill='steelblue', alpha=0.2, col='steelblue', size=0.2) +
  geom_pointrange(data=filter(tmp_2, matchdate==as.Date(cut(matchdate, breaks=10))), aes(ymin=min, ymax=max), col='steelblue') +
  facet_grid(vars(measure)) +
  theme_minimal() +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x=element_blank()) +
  labs(title = 'Goal & xG averages with Min-Max Range')

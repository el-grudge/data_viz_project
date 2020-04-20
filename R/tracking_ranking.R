league_stats <- as.data.frame(league_stats_all)
animate_full <- NULL
for (i in unique(league_stats$team_name)){
  tmp <- filter(league_stats, team_name==i)
  tmp <- tmp %>% select(team_name, scored, missed, pts, date)
  tmp$points <- 0
  tmp$goals_for <- 0
  tmp$goals_against <- 0
  tmp$goal_diff <- 0
  tmp$matchday <- 0
  for (i in c(1:nrow(tmp))){
    tmp[c(i:nrow(tmp)),]$points <- tmp[i,]$points+tmp[i,]$pts
    tmp[c(i:nrow(tmp)),]$goals_for <- tmp[i,]$goals_for+tmp[i,]$scored
    tmp[c(i:nrow(tmp)),]$goals_against <- tmp[i,]$goals_against+tmp[i,]$missed
    tmp[c(i:nrow(tmp)),]$goal_diff <- tmp[i,]$goal_diff+(tmp[i,]$scored-tmp[i,]$goal_diff)
    tmp[i,]$matchday <- i
  }
  tmp <- tmp %>% select(team_name, matchday, everything(), -scored, -missed, -pts, -date)
  animate_full <- rbind(animate_full, tmp)
}

iteration_sequence <- c(1:460)

my_anim <- ggplot(animate_full,
       aes(matchday,
           points,
           color = team_name,
           group = team_name)) +
  geom_line() +
  geom_point(size = 2) +
  geom_text(aes(x = 1.02 *matchday,
                label = team_name,
                size = 3),
            hjust = 0) +
  geom_text(aes(x = 1.4 * matchday + 10,
                label = ""),
            hjust = 0) +
  transition_reveal(matchday, keep_last=TRUE) +
  coord_cartesian(clip = 'off') +
  labs(title = '2014/2015 Season
                {iteration_sequence[frame_along]} Matchday',
       x = "matchday",
       y = 'points') +
  theme_minimal() +
  scale_y_continuous(labels = comma)+
  theme(plot.margin = margin(8, 8, 8, 8),
        legend.position = "none") +
  view_follow(aspect_ratio = 1.3)

animate(my_anim,
        duration = 30,
        fps = 5,
        width = 500,
        height = 300,
        renderer = gifski_renderer())
anim_save("outbreak_animation.gif")



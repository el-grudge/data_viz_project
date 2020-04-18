get_season <- function(season){
  season <- as.data.frame(select(season, -h_a, -result, -date, -league_name, -npxG, -npxGA, -xpts, -npxGD) %>%
                            group_by(team_name) %>%
                            summarise(mp=sum(wins, draws, loses),
                                      team_id=unique(team_id),
                                      year=unique(year),
                                      pts=sum(pts),
                                      win=sum(wins),
                                      draw=sum(draws),
                                      loss=sum(loses),
                                      goals_for=sum(scored),
                                      goals_against=sum(missed),
                                      goal_diff=sum(scored)-sum(missed),
                                      xG=sum(xG),
                                      xGA=sum(xGA),
                                      deep=sum(deep),
                                      deep_allowed=sum(deep_allowed),
                                      avgCP=sum(ppda_allowed.att),
                                      avgCP_allowed=sum(ppda.att),
                                      def_actions=sum(ppda.def),
                                      def_actions_allowed=sum(ppda_allowed.def),
                                      ppda=sum(ppda.att)/sum(ppda.def),
                                      ppda_allowed=sum(ppda_allowed.att)/sum(ppda_allowed.def)) %>%
                            arrange(desc(pts)))
  season$rank <- as.integer(rownames(season))
  season <- select(season, rank, everything())
  return (season)
}

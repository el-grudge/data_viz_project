build_platonictable <- function(data){
  return (as.data.frame(platonic_table <- data %>%
            select(-c(2,4,5)) %>%
            group_by(rank) %>%
            summarise(mp=mean(mp),
                      pts=mean(pts),
                      win=mean(win),
                      draw=mean(draw),
                      loss=mean(loss),
                      goal_diff=mean(goal_diff),
                      goals_for=mean(goals_for),
                      goals_against=mean(goals_against),
                      xG=mean(xG),
                      xGA=mean(xGA),
                      deep=mean(deep),
                      deep_allowed=mean(deep_allowed),
                      CP=mean(CP),
                      CP_allowed=mean(CP_allowed),
                      def_actions=mean(def_actions),
                      def_actions_allowed=mean(def_actions_allowed),
                      ppda=mean(ppda),
                      ppda_allowed=mean(ppda_allowed))))
}

build_alltimetable <- function(data){
  return (as.data.frame(all_time <- data %>%
                          group_by(team_name) %>%
                          summarise(pts=sum(pts),
                                    win=sum(win),
                                    draw=sum(draw),
                                    loss=sum(loss),
                                    goals_for=sum(goals_for),
                                    goals_against=sum(goals_against),
                                    goal_diff=sum(goal_diff),
                                    xG=sum(xG),
                                    xGA=sum(xGA),
                                    deep=sum(deep),
                                    deep_allowed=sum(deep_allowed),
                                    CP=sum(CP),
                                    CP_allowed=sum(CP_allowed),
                                    def_actions=sum(def_actions),
                                    def_actions_allowed=sum(def_actions_allowed),
                                    ppda=sum(ppda),
                                    ppda_allowed=sum(ppda_allowed)) %>%
                          arrange(desc(pts))))
}

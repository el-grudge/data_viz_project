# Libraries
library(GGally)
library(hrbrthemes)
library(viridis)


# 1 - Data set is provided by R natively
data <- iris

# Plot
ggparcoord(data, columns = 1:4, groupColumn = 5)


# 2 - Data set is provided by R natively
data <- iris

# Plot
ggparcoord(data,
           columns = 1:4,
           groupColumn = 5,
           order = "anyClass",
           showPoints = TRUE,
           title = "Parallel Coordinate Plot for the Iris Data",
           alphaLines = 0.3
)

ggparcoord(data,
           columns = 1:4, groupColumn = 5, order = "anyClass",
           scale="globalminmax",
           showPoints = TRUE,
           title = "No scaling",
           alphaLines = 0.3
)

ggparcoord(data,
           columns = 1:4, groupColumn = 5, order = "anyClass",
           scale="uniminmax",
           showPoints = TRUE,
           title = "Standardize to Min = 0 and Max = 1",
           alphaLines = 0.3
)

ggparcoord(data,
           columns = 1:4, groupColumn = 5, order = "anyClass",
           scale="std",
           showPoints = TRUE,
           title = "Normalize univariately (substract mean & divide by sd)",
           alphaLines = 0.3
)

ggparcoord(data,
           columns = 1:4, groupColumn = 5, order = "anyClass",
           scale="center",
           showPoints = TRUE,
           title = "Standardize and center variables",
           alphaLines = 0.3
)

data %>%
  arrange(desc(Species)) %>%
  ggparcoord(
    columns = 1:4, groupColumn = 5, order = "anyClass",
    showPoints = TRUE,
    title = "Original",
    alphaLines = 1
  )+
  scale_color_manual(values=c( "steelblue", "#E8E8E8", "#E8E8E8") ) +
  theme_bw()+
  theme(
    legend.position="Default",
    plot.title = element_text(size=10)
  ) +
  xlab("")


data <- as.data.frame(select(platonic_table, -mp) %>% head())
data <- select(data, -deep, -deep_allowed, -avgCP, -avgCP_allowed)
data$rank <- factor(data$rank)

data$win <- data$win/sum(data$win, data$draw, data$loss) *100

resultPercentage <- function(data, result){
  mp <- data$win+data$draw+data$loss
  result <- data[,result]
  return (result/mp*100)
}

data[,'win']

data$winP <- resultPercentage(data, 'win')
data$drawP <- resultPercentage(data, 'draw')
data$lossP <- resultPercentage(data, 'loss')



apply(data, 1, FUN=resultPercentage('win'))

data %>%
  ggparcoord(
    columns=2:ncol(data), groupColumn=1,
    scale="globalminmax",
    showPoints=TRUE,
    alphaLines=1
  ) +
  scale_color_manual(values=c( "steelblue", rep("#E8E8E8", nrow(data)-1)) ) +
  theme_bw()

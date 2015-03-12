library(data.table)

dfTitanic <- data.frame(Titanic)
dtTitanic <- data.table(dfTitanic)
str(dfTitanic)
head(dtTitanic)

nTot <- dtTitanic[, sum(Freq)]
nTot
dtSurvived <- dtTitanic[, list(n=sum(Freq)), by='Survived']
dtSurvived
help(barplot)

vectorHeight <- dtSurvived[, n]
vectorNames <- dtSurvived[, Survived]

barplot(height=vectorHeight, names.arg=vectorNames)
dtSurvived[, percentage := n / sum(n)]
dtSurvived[, colorPlot := ifelse(Survived == 'Yes', 'blue', 'red')]

barplot(
  height=dtSurvived[, percentage],
  names.arg=dtSurvived[, Survived],
  col=dtSurvived[, colorPlot],
  ylim=c(0, 1)
)

dtSurvived[, textPercentage := paste(round(percentage * 100), '%', sep='')]
plotTitle <- 'Proportion of passengers surviving or not'
ylabel <- 'percentage'

barplot(
  height=dtSurvived[, percentage],
  names.arg=dtSurvived[, Survived],
  col=dtSurvived[, colorPlot],
  ylim=c(0, 1),
  legend.text=dtSurvived[, textPercentage],
  ylab=ylabel,
  main=plotTitle
)

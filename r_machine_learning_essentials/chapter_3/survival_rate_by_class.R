library(data.table)

dfTitanic <- data.frame(Titanic)
dtTitanic <- data.table(dfTitanic)

dtClass <- dtTitanic[, list(n=sum(Freq)), by=c('Survived','Class')]
dtClass[, percentage := n / sum(n), by='Class']
dtClass[, textPercentage := paste(round(percentage * 100), '%',sep='')]

barplot(
  height=dtClass[Survived == 'Yes', percentage],
  names.arg=dtClass[Survived == 'Yes', Class],
  col=dtClass[Survived == 'Yes', Class],
  ylim=c(0, 1),
  legend.text=dtClass[Survived == 'Yes', textPercentage],
  ylab='survival rate',
  main='Survival rate by class')

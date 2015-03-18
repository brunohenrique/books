library(data.table)

dfTitanic <- data.frame(Titanic)
dtTitanic <- data.table(dfTitanic)

dtGenderFreq <- dtTitanic[, list(n=sum(Freq)), by=c('Sex', 'Class')]
dtGenderFreq[, percentage := n / sum(n), by='Class']
dtGenderFreq <- dtGenderFreq[Sex == 'Female']
dtGenderFreq[, textPercentage := paste(round(percentage * 100), '%', sep='')]

barplot(
  height=dtGenderFreq[, percentage],
  names.arg=dtGenderFreq[, Class],
  col=dtGenderFreq[, Class],
  ylim=c(0, 1),
  legend.text=dtGenderFreq[, textPercentage],
  ylab='survival rate',
  main='Percentage of females'
)

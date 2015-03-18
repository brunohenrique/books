library(data.table)

dfTitanic <- data.frame(Titanic)
dtTitanic <- data.table(dfTitanic)

dtGenderClass <- dtTitanic[, list(n=sum(Freq)), by=c('Survived','Sex', 'Class')]
dtGenderClass[, nTot := sum(n), by=c('Sex', 'Class')]
dtGenderClass[, percentage := n / sum(n), by=c('Sex', 'Class')]
dtGenderClass <- dtGenderClass[Survived == 'Yes']
dtGenderClass[, textPercentage := paste(round(percentage * 100),'%', sep='')]
dtGenderClass[, colorPlot := rainbow(nrow(dtGenderClass))]
dtGenderClass[, SexAbbr := ifelse(Sex == 'Male', 'M', 'F')]
dtGenderClass[, barName := paste(Class, SexAbbr, sep='')]
dtGenderClass[, barLabel := paste(barName, nTot, sep='\n')]

barplot(
  height=dtGenderClass[, percentage],
  names.arg=dtGenderClass[, barLabel],
  col=dtGenderClass[, colorPlot],
  xlim=c(0, 11),
  ylim=c(0, 1),
  ylab='survival rate',
  legend.text=dtGenderClass[, textPercentage])

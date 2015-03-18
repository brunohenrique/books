library(data.table)

dfTitanic <- data.frame(Titanic)
dtTitanic <- data.table(dfTitanic)

dtTitanic[, nTot := sum(Freq), by=c('Sex', 'Class', 'Age')]
dtTitanic[, percentage := Freq / nTot]
dtAll <- dtTitanic[Survived == 'Yes', ]
dtAll[, ClassAbbr := substring(Class, 1, 1)]
dtAll[, SexAbbr := ifelse(Sex == 'Male', 'M', 'F')]
dtAll[, AgeAbbr := ifelse(Age == 'Child', 'C', 'A')]
dtAll[, textLegend := paste(ClassAbbr, SexAbbr, AgeAbbr, sep='')];
dtAll[, colorPlot := rainbow(nrow(dtAll))]
dtAll[, labelPerc := paste(round(percentage * 100), '%', sep='')]
dtAll[, label := paste(labelPerc, nTot, sep='\n')]

barplot(
  height=dtAll[, percentage],
  names.arg=dtAll[, label],
  col=dtAll[, colorPlot],
  xlim=c(0, 23),
  legend.text=dtAll[, textLegend],
  cex.names=0.5
)

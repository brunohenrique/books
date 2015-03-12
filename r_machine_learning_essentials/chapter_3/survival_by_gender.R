library(data.table)

dfTitanic <- data.frame(Titanic)
dtTitanic <- data.table(dfTitanic)

dtGender <- dtTitanic[, list(n=sum(Freq)), by=c('Survived', 'Sex')]
dtGender

dtGender[, percentage := n / sum(n), by='Sex']
dtGender[, textPercentage := paste(round(percentage * 100), '%', sep='')]
dtGender[, colorPlot := ifelse(Survived == 'Yes', 'blue', 'red')]
dtGenderMale <- dtGender[Sex == 'Male']

barplot(
  height=dtGenderMale[, percentage],
  names.arg=dtGenderMale[, Survived],
  col=dtGenderMale[, colorPlot],
  ylim=c(0, 1),
  legend.text=dtGenderMale[, textPercentage],
  ylab='percentage',
  main='Survival rate for the males'
)

barplot(
  height=dtGender[Sex == 'Female', percentage],
  names.arg=dtGender[Sex == 'Female', Survived],
  col=dtGender[Sex == 'Female', colorPlot],
  ylim=c(0, 1),
  legend.text=dtGender[Sex == 'Female', textPercentage],
  ylab='percentage',
  main='Survival rate for the females'
)

barplot(
  height=dtGender[Survived == 'Yes', percentage],
  names.arg=dtGender[Survived == 'Yes', Sex],
  col=dtGender[Survived == 'Yes', Sex],
  ylim=c(0, 1),
  legend.text=dtGender[Survived == 'Yes', textPercentage],
  ylab='percentage',
  main='Survival rate by gender'
)

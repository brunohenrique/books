library('rpart')
library('rpart.plot')
library('data.table')

dfTitanic <- data.frame(Titanic)
dtTitanic <- data.table(dfTitanic)

dtLong <- dtTitanic[, 
                   list(Freq = rep(1, Freq)), 
                   by=c('Survived', 'Sex', 'Age', 'Class')
                   ]

dtLong[, Freq := NULL]
dtLong[, Survived := ifelse(Survived == 'Yes', 1, 0)]
head(dtLong)
tail(dtLong)

help(rpart)

formulaRpart <- formula('Survived ~ Sex + Age + Class')

treeRegr <- rpart(
  formula=formulaRpart,
  data = dtLong,
)
prp(treeRegr)

treeClass <- rpart(
  formula=formulaRpart,
  data = dtLong,
  method='class'
)
prp(treeClass)

visits <- read.csv('webvisit1.csv')

visits0 <- visits[visits$version == 0,]

hist(visits0$pages)
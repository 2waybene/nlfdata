library(ggplot2)
library(reshape2)
library(readxl)

setwd("~/myGit/nfldata/")

de <- read_excel("headcount.xlsx")

dm <- cbind(as.numeric(de$Worskhip),as.numeric(de$SundaySchool), as.numeric(de$Friday), as.numeric(de$Prayer))
colnames(dm) <- colnames(de)[-1]
rownames(dm) <- as.character(de$Day)

dt.melt.2 <- melt(dm)
head(dt.melt.2)

colnames(dt.melt.2) <- c ("Week", "Category", "HeadCount")
# plot everything
p = ggplot(dt.melt.2, aes(Week, HeadCount)) +   
  geom_bar(aes(fill = Category), position = "dodge", stat="identity")

ggObj = p + ggtitle("NFL attendance", subtitle = "Weekly since 2020-03-15") + theme(axis.text.x=element_text(angle=90, hjust=1))

ggsave(plot=ggObj, file="NFL_attendance.pdf", device=cairo_pdf, width=16, height=6)




lcd  <- read.csv("/Users/Prasoona/Downloads/LungCapData.csv")
lcd

lcd_nsf18p <- lcd[lcd$Smoke == "yes" & lcd$Gender == "female" & lcd$Age >= 18,]
lcd_nsf18p

summary(lcd_nsf18p)

data <- seq(from=1, to=97,by=4)
mymat <- matrix( data , 5, 5)
mymat

mysmallmat <- matrix( mymat , 3, 3)
mysmallmat

mymat <- matrix(seq(from=1, to=100, by=4), nrow=5)
mymat

mysmallmat <- mymat[2:4, 2:4]
mysmallmat

mynewsmallmat <- t(mysmallmat)
mynewsmallmat

a <- rep(seq(from=0, to=20, by=1), 10)
plot(a, type = "s", ylim=c(-20,50))

highval = 1000
for(i in seq(0,1,0.0001))
{
  for (j in seq(0,1,0.0001))
{
  if(highval>=sumsqdistV21(Ax,Ay, 3, i,j))
  {
    lowI= i
    lowJ= i
    highval=sumsqdistV21(Ax,Ay, 3, i,j)
  } }
}
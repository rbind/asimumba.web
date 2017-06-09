Portfolio Analysis
================
Aaron Simumba
2017-02-06

``` r
## Packages to load
library(quantmod)
library(ggplot2) 
library(xts)
library(highcharter)
library(PerformanceAnalytics)
library(dygraphs)
```

``` r
#loading the data
fundreturn <- read.csv("fundreturns.csv", header = T)

# quick peep  of the data
head(fundreturn, 3)
```

    ##        Dates    SPY    IJS    VTI    IYR     EFA    EFV    GOOG    AAPL
    ## 1 2007-06-01 0.0240 0.0875 0.0322 0.0730  0.0577 0.0589  0.0429  0.0504
    ## 2 2007-07-01 0.0057 0.0027 0.0022 0.0177 -0.0070 0.0010 -0.1619 -0.0930
    ## 3 2007-08-01 0.0165 0.0486 0.0205 0.0557  0.0401 0.0332  0.0755 -0.0842
    ##      AMZN    MSFT     AMD      GE   CSCO    HPQ     AXP     DIS    JPM
    ## 1 -0.0494  0.0765  0.3660 -0.0656 0.0847 0.0891  0.0216  0.0559 0.0101
    ## 2 -0.1647 -0.0422 -0.0749  0.0112 0.0899 0.0523  0.0273  0.1059 0.0350
    ## 3 -0.0243  0.0127 -0.1425  0.0581 0.0707 0.0052 -0.0247 -0.0036 0.0122
    ##     BBRY
    ## 1 0.0230
    ## 2 0.0444
    ## 3 0.2035

``` r
str(fundreturn)
```

    ## 'data.frame':    114 obs. of  19 variables:
    ##  $ Dates: Factor w/ 114 levels "2007-06-01","2007-07-01",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ SPY  : num  0.024 0.0057 0.0165 0.0126 -0.0301 0.0026 0.0045 0.0218 0.027 0.0315 ...
    ##  $ IJS  : num  0.0875 0.0027 0.0486 0.0018 -0.0455 0.0004 -0.031 0.027 0.0119 0.0552 ...
    ##  $ VTI  : num  0.0322 0.0022 0.0205 0.0096 -0.0322 0.0013 -0.0012 0.023 0.0226 0.0353 ...
    ##  $ IYR  : num  0.073 0.0177 0.0557 -0.0327 -0.0331 0.046 0.0365 0.0298 0.0238 0.0648 ...
    ##  $ EFA  : num  0.0577 -0.007 0.0401 0.0479 -0.0382 -0.0006 0.0081 0.0255 0.0022 0.0375 ...
    ##  $ EFV  : num  0.0589 0.001 0.0332 0.0524 -0.0388 0.0035 0.0133 0.0301 0.0077 0.0425 ...
    ##  $ GOOG : num  0.0429 -0.1619 0.0755 0.0716 -0.1104 ...
    ##  $ AAPL : num  0.0504 -0.093 -0.0842 0.1223 -0.1509 ...
    ##  $ AMZN : num  -0.0494 -0.1647 -0.0243 -0.0361 -0.017 ...
    ##  $ MSFT : num  0.0765 -0.0422 0.0127 -0.1125 -0.0585 ...
    ##  $ AMD  : num  0.366 -0.0749 -0.1425 -0.0244 -0.0451 ...
    ##  $ GE   : num  -0.0656 0.0112 0.0581 -0.0055 -0.0095 -0.0307 -0.0082 0.0419 0.0439 -0.0054 ...
    ##  $ CSCO : num  0.0847 0.0899 0.0707 -0.0332 -0.0606 ...
    ##  $ HPQ  : num  0.0891 0.0523 0.0052 -0.0131 -0.0028 ...
    ##  $ AXP  : num  0.0216 0.0273 -0.0247 0.0263 0.0102 -0.021 -0.0191 0.0092 0.0674 0.0336 ...
    ##  $ DIS  : num  0.0559 0.1059 -0.0036 0.0025 0.0908 ...
    ##  $ JPM  : num  0.0101 0.035 0.0122 0.0987 -0.0604 -0.015 0.0951 0.0009 0.0285 0.0175 ...
    ##  $ BBRY : num  0.023 0.0444 0.2035 -0.0972 -0.1532 ...

``` r
## Dates have been loaded as a factor instead of as dates. There is need to convert this variable to the date class and covert the rest of the variables to xts(Extensible Time Series)

temp <- xts(x =fundreturn[,-1], order.by = as.Date(fundreturn[,1])) 
# all the variables except data are coerced to xts using date as the index.
# Overwriting the fundreturn object with the xts temp object
fundreturn <- temp
str(fundreturn)
```

    ## An 'xts' object on 2007-06-01/2016-11-01 containing:
    ##   Data: num [1:114, 1:18] 0.024 0.0057 0.0165 0.0126 -0.0301 0.0026 0.0045 0.0218 0.027 0.0315 ...
    ##  - attr(*, "dimnames")=List of 2
    ##   ..$ : NULL
    ##   ..$ : chr [1:18] "SPY" "IJS" "VTI" "IYR" ...
    ##   Indexed by objects of class: [Date] TZ: UTC
    ##   xts Attributes:  
    ##  NULL

``` r
rm(temp) # gettting rid of temp object
## Next I, stack variables of the same unique class within the same column. That is the returns of all the stocks in one column and the tickers in another column, indexed by the date variable.

# make use of a temporary object.
temp <- data.frame(index(fundreturn), stack(as.data.frame(coredata(fundreturn))))
fundreturn_final <- temp
```

``` r
# Give the variables more descriptive names 
    names(fundreturn_final)[1] <-  "Year"
    names(fundreturn_final)[2] <-  "PercentageReturn"
    names(fundreturn_final)[3] <-  "Stockticker"
    names(fundreturn_final)
```

    ## [1] "Year"             "PercentageReturn" "Stockticker"

``` r
  rm(temp) # removing the temp. object
  # we coerce the data frame back to xts to be able to use quantmod and highcharter
  
#fundreturn_final <- xts(x=fundreturn_final[-1], order.by = as.Date(fundreturn_final[,1]))
```

``` r
ggplot(data = fundreturn_final, aes(x=Year, y=PercentageReturn, color=Stockticker)) +geom_line()
```

![](fund_returns_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
# Google stock Performance
# GOOG
GOOG <- subset(fundreturn_final, Stockticker=="GOOG")
g <- ggplot(data = GOOG, aes(x=Year, y=PercentageReturn)) +geom_line()
# add features
g <- g + ggtitle("Google Monthly Return", subtitle = "For the Period between June 2007 - Nov. 2016") + 
      theme(panel.background = element_rect(fill = "white", colour = "grey50"),
            axis.text = element_text(colour = "blue"),
            axis.title.y = element_text(size = rel(1.0), angle = 90),
            axis.title.x = element_text(size = rel(1.0), angle = 360))

g <- g + labs(x = "Year",
        y ="Percentage return") 

g + annotate("text",x=as.Date("2009-09-01"),y=0.3245,label="HR",fontface="bold",size=3, colour = "forestgreen") +
annotate("text",x=as.Date("2010-04-01"),y=-0.1900,label="LR",fontface="bold",size=3,colour ="red") 
```

![](fund_returns_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
# Portfolio Performance Appraisal
#-------------------------------------------------------------------------------

# Having the following portfolio

# Google = GOOG, Amazon = AZMN,Apple = AAPL JP Morgans = JPM, Microsoft = MSFT, General Electric = GE, and Hewlett Packard = HPQ
#, "GE", "HPQ"

p1 <- subset(fundreturn_final, Stockticker =="AMZN")
p2 <- subset(fundreturn_final, Stockticker =="MSFT")
p3 <- subset(fundreturn_final, Stockticker =="AAPL")
p4 <- subset(fundreturn_final, Stockticker =="GOOG")

portfolio <- rbind(p1,p2,p3,p4) # binding the returns into one returns variable
rm("p1","p2", "p3","p4") # Removal of the temp. subsets 
 
# quick visual representation of the data
p <- ggplot(data = portfolio, aes(x = Year, y =PercentageReturn, colour = Stockticker))+geom_line()
p + labs(
        x = " Year",
        y = "Percentage return",
        colour = "Stock ticker") +
    ggtitle(" Apple, Amazon and Google Stock Returns",subtitle =" For the period June 2007 - Nov. 2016")
```

![](fund_returns_files/figure-markdown_github/unnamed-chunk-6-1.png)

``` r
#Dygraphing

p1 <- subset(fundreturn_final, Stockticker =="AMZN")
p2 <- subset(fundreturn_final, Stockticker =="MSFT")
p3 <- subset(fundreturn_final, Stockticker =="AAPL")
p4 <- subset(fundreturn_final, Stockticker =="GOOG")


# Converting to xts before graphing
AMZN <- xts(x = p1[,c(-1,-3)], order.by = p1[,1])
MSFT <- xts(x = p2[,c(-1,-3)], order.by = p2[,1])
AAPL <- xts(x = p3[,c(-1,-3)], order.by = p3[,1])
GOOG_ <- xts(x = p4[,c(-1,-3)], order.by = p4[,1])

rm("p1","p2", "p3","p4") # Removal of the temp. subsets 
```

``` r
merged_returns <- merge.xts(AMZN,MSFT,AAPL,GOOG_) # merging the separate share returns into one xts object.

dygraph(merged_returns, main = "Amazon v Microsoft v Apple v Google") %>% # Using pipes to connect the codes
  dyAxis("y", label ="%") %>%
  dyAxis("x", label ="Year") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(4, "Set2")) 
```

![](fund_returns_files/figure-markdown_github/unnamed-chunk-8-1.png)

``` r
# Let's now evaluate the portfolio

## Part of the code is adapted from Jonathan Regenstein from RStudio

# We assume an equally weighted portfolio. Allocating 25% to all the stocks in our portfolio
w <- c(.25,.25,.25,.25)

# We use the performanceAnalytics built infuction Return.porftolio to calculate portfolio monthly returns

monthly_P_return <-  Return.portfolio(R = merged_returns, weights = w)

# Use dygraphs to chart the portfolio monthly returns.
dygraph(monthly_P_return, main = "Portfolio Monthly Return") %>% 
  dyAxis("y", label = "%")
```

![](fund_returns_files/figure-markdown_github/unnamed-chunk-9-1.png)

``` r
# Add the wealth.index = TRUE argument and, instead of returning monthly returns,
# the function will return the growth of $1 invested in the portfolio.
dollar_growth <- Return.portfolio(merged_returns, weights = w, wealth.index = TRUE)

# Use dygraphs to chart the growth of $1 in the portfolio.
dygraph(dollar_growth, main = "Growth of $1 Invested in Portfolio") %>% 
  dyAxis("y", label = "$")
```

![](fund_returns_files/figure-markdown_github/unnamed-chunk-10-1.png)

``` r
# Calculating the Sharpe Ratio
# Taking the US 10 Year Treasury Rate of 2.40% as the risk free rate.
# Making use of the built in SharpeRatio function in Performance Analytics package.
print(sharpe_ratio <- round(SharpeRatio(monthly_P_return, Rf = 0.024), 4))
```

    ##                                 portfolio.returns
    ## StdDev Sharpe (Rf=2.4%, p=95%):           -0.0634
    ## VaR Sharpe (Rf=2.4%, p=95%):              -0.0424
    ## ES Sharpe (Rf=2.4%, p=95%):               -0.0298

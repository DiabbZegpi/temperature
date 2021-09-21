# Example of the `frost` package
library(frost)
set.seed(123)
x1 <- rnorm(100, mean = 2, sd = 5) # Temp
x2 <- rnorm(100, mean = 1, sd = 3) # Dew Point
y <- rnorm(100, mean = 0, sd = 2)
fao_model <- buildFAO(dw = x2, temp = x1, tmin = y)
str(fao_model)
# Tp: predicted temperature using the equation
# Rp: residuals, the difference between y and Tp
# r2: determination coefficient 

# --------------------------------------------------------------------------------
# a, b and c coefs by hand
# --------------------------------------------------------------------------------

data <- as.data.frame(cbind(y, x1, x2))
fit1 <- lm(y ~ x1, data = data)
a <- fit1$coefficients[[2]]
w <- fit1$coefficients[[1]]

tp_1 <- a * x1 + w
residual11 <- y - tp_1

fit2 <- lm(residual11 ~ x2)
b <- fit2$coefficients[[2]]
c <- w + fit2$coefficients[[1]]

tp <- a * x1 + b * x2 + c
rp <- y - tp

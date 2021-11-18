library(ggplot2)
library(gapminder)
library(dplyr)
library(ggpmisc)

gapminder %>%
  filter(year == 2002) %>%
  ggplot(gapminder, mapping = aes(x = gdpPercap, y = lifeExp, size = pop, colour = continent)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  geom_smooth(method="lm") +
  stat_poly_eq(formula =  y ~ x, 
               aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
               parse = TRUE) +         
  scale_size(range = c(2, 12)) +
  scale_x_log10() + 
  facet_wrap(~continent)

library(ggplot2)
library(gapminder)
library(dplyr)

gapminder %>%
  filter(year == 1952) %>%
  ggplot(gapminder, mapping = aes(x = gdpPercap, y = lifeExp, size = pop, colour = continent)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  geom_smooth(method="lm",se = FALSE) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() + 
  facet_wrap(~continent)
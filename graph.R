library(ggplot2)
library(gapminder)
library(dplyr)


gapminder %>%
  filter(year == 1952) %>%
  ggplot(gapminder, mapping = aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent)
# Line graph that plots jail populations of different races 
# over time (2000-2018)

# Load packages
library(ggplot2)

# Clean data
chart_df <- jail_pop %>% 
  # Focus on Georgia as they have comparable black and white populations
  filter(state == "GA", year > 2000) %>% 
  mutate(other_jail_pop = aapi_jail_pop + native_jail_pop + latinx_jail_pop + other_race_jail_pop) %>% 
  # Choose columns of white, black, aapi, and native jail pop.
  select(year, white_jail_pop, black_jail_pop, other_jail_pop) %>%
  # Dropping NA values as they can affect the graph
  drop_na()

# Sum the jail populations from all counties in GA
chart_df <- chart_df %>% 
  group_by(year) %>% 
  summarise(across(c(white_jail_pop, black_jail_pop, other_jail_pop), sum))

# Combine columns into one column (groups)
chart_df <- chart_df %>% 
  pivot_longer(cols=c('white_jail_pop', 'black_jail_pop', 
                      'other_jail_pop'),
                                      names_to='race',
                                      values_to='pop')

# Plot data
plot1 <- ggplot(data = chart_df, aes(x = year, y = pop, group = race)) + 
  geom_line(aes(color = race), linewidth = 0.7) + 
  xlab("Year") +
  ylab("Jail Population") +
  ggtitle("Jail Populations in Georgia") +
  theme(plot.title = element_text(hjust=0.5)) +
  scale_color_manual(name = "Race", labels = c("Black", "Other", "White"), 
                     values = c('firebrick', 'cornflowerblue', 'darkseagreen4'))


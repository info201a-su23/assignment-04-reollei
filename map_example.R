# US map of black jail populations in 2015

# Load in state data
state <- map_data("state")

# Clean data
map_df <- jail_pop %>% 
  filter(year == 2014) %>% 
  select(year, state, black_jail_pop) %>% 
  drop_na()

# Sum jail populations from all counties within each state
map_df <- map_df %>% 
  group_by(state) %>% 
  summarise(across(black_jail_pop, sum))

# Rename state data to match abbreviations
state$region <- state.abb[match(state$region, tolower(state.name))]

# Rename column to region to join
map_df <- map_df %>% 
  rename("region" = "state")

# Join datasets
map_df_temp <- left_join(map_df, state)

# Plot data
# map <- plot_usmap(data = map_df, values = "black_jail_pop", regions = "states") + 
#  labs(title = "Black Jail Populations in US (2014)") +
#  scale_fill_continuous(low = "lightblue1", high = "lightblue4",
#                        name = "Black Jail Pop.", label = scales::comma) +
#  theme(legend.position = "right", plot.title = element_text(hjust = 0.5))

# Plot data using ggplot2
map <- ggplot(map_df_temp) +
  geom_polygon(aes(x = long, y = lat, group = group, fill = black_jail_pop), color = "lightblue4") +
  scale_fill_continuous(low = "lightblue1", high = "lightblue4", 
                        name = "Black Jail Pop.", label = scales::comma) +
  ggtitle("Black Jail Populations in US (2014)") +
  # Formatting the map
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5),
        axis.title = element_blank(), axis.ticks = element_blank(), 
        axis.text = element_blank())

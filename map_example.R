# US map of black jail populations in 2015

# Clean data
map_df <- jail_pop %>% 
  filter(year == 2014) %>% 
  select(year, state, black_jail_pop) %>% 
  drop_na()

# Sum jail populations from all counties within each state
map_df <- map_df %>% 
  group_by(state) %>% 
  summarise(across(black_jail_pop, sum))

# Plot data
map <- plot_usmap(data = map_df, values = "black_jail_pop", regions = "states") + 
  labs(title = "Black Jail Populations in US (2014)") +
  scale_fill_continuous(low = "lightblue1", high = "lightblue4",
                        name = "Black Jail Pop.", label = scales::comma) +
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5))

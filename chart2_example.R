# Scatterplot matrix of female and male jail populations/black and white 
# populations in Georgia

# Clean data
chart2_df <- jail_pop %>% 
  filter(state == "GA") %>% 
  select(female_jail_pop, male_jail_pop, white_jail_pop, black_jail_pop, year) %>% 
  drop_na()

# Sum populations over years
chart2_df <- chart2_df %>% 
  group_by(year) %>% 
  summarise(across(c(white_jail_pop, black_jail_pop, 
                     female_jail_pop, male_jail_pop), sum))

# Plot data
plot2 <- ggpairs(chart2_df, columns = 2:5,
        title = "Comparing White/Black and Female/Male Jail Pop.", 
        columnLabels = c("White", "Black", "Female", "Male")) +
  theme(plot.title = element_text(hjust = 0.5))

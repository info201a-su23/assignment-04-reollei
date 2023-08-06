## Summary Information

# Load datasets
prison_pop <- read.csv('https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true')
jail_pop <- read.csv('https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-jail-pop.csv?raw=true')
pop_rate_100k <- read.csv('https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates.csv?raw=true')

# Note:
#   Jail holds people awaiting trial/sentencing
#   Prisons house people who have been convicted of a crime

# Calculating 5 summary values

# The state with the largest jail population within urban communities
# from years 2000-2018
high_urban_state_jail_pop <- jail_pop %>% 
  filter(year > 2000, urbanicity == "urban") %>% 
  filter(total_jail_pop == max(total_jail_pop, na.rm = TRUE)) %>% 
  pull(state)

# Convert abbreviation to state name
high_urban_state_jail_pop <- state.name[match(high_urban_state_jail_pop, state.abb)]

# The state with the largest jail population within rural communities
# from years 2000-2018
high_rural_state_jail_pop <- jail_pop %>% 
  filter(year > 2000, urbanicity == "rural") %>% 
  filter(total_jail_pop == max(total_jail_pop, na.rm = TRUE)) %>% 
  pull(state)

# Convert abbreviation to state name
high_rural_state_jail_pop <- state.name[match(high_rural_state_jail_pop, state.abb)]

# The highest reported black and white jail population within the 2000s in Texas
high_black_jail_pop <- jail_pop %>% 
  filter(year > 2000, state == "TX") %>% 
  filter(black_jail_pop == max(black_jail_pop, na.rm = TRUE)) %>% 
  pull(black_jail_pop)

high_white_jail_pop <- jail_pop %>% 
  filter(year > 2000, state == "TX") %>% 
  filter(white_jail_pop == max(white_jail_pop, na.rm = TRUE)) %>% 
  pull(white_jail_pop)

# The state with largest ratio between black and white populations held in jail
# during 2015 and what the ratio is (B / W)
high_bw_ratio_state <- jail_pop %>% 
  filter(year == 2015) %>% 
  mutate(bw_ratio = black_jail_pop / white_jail_pop) %>% 
  filter(!is.infinite(bw_ratio)) %>% 
  filter(bw_ratio == max(bw_ratio, na.rm = TRUE)) %>% 
  pull(state)

# Convert abbreviation to state name
high_bw_ratio_state <- state.name[match(high_bw_ratio_state, state.abb)]

high_bw_ratio <- jail_pop %>% 
  filter(year == 2015) %>% 
  select(state, black_jail_pop, white_jail_pop) %>% 
  mutate(bw_ratio = black_jail_pop / white_jail_pop) %>% 
  filter(bw_ratio == max(bw_ratio, na.rm = TRUE)) %>% 
  pull(bw_ratio)

# The state with largest juvenile jail population (male and female)
# within the 2000s
high_juvenile_pop <- jail_pop %>% 
  filter(year > 2000) %>% 
  select(state, female_juvenile_jail_pop, male_juvenile_jail_pop) %>% 
  mutate(total_juvenile_pop = female_juvenile_jail_pop + 
           male_juvenile_jail_pop) %>%
  filter(total_juvenile_pop == max(total_juvenile_pop, na.rm = TRUE)) %>% 
  pull(state)

# Convert abbreviation to state name
high_juvenile_pop <- state.name[match(high_juvenile_pop, state.abb)]


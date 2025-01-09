##########################################################################
## Driver: (Name) (GitHub Handle)                                       ##
## Navigator: (Name) (GitHub Handle)                                    ##
## Date: (YYYY-MM-DD)                                                   ##
##########################################################################

library(marinecs100b)

# Guiding questions -------------------------------------------------------

# What does KEFJ stand for? Kenai Fjords National Park

# How was temperature monitored? HOBO V2 temperature loggers at the rocky sites.
# Recorded temp every 20, 30, or 60 minutes
# Logger wet when tide level at at nearest tide station was ≥1.5m or dry when ≤0
# Transition periods ommited
# Averaged: Jan-March, April-May, June-July, August-October, November-December

# What's the difference between absolute temperature and temperature anomaly?
# Anomaly: difference from the long term mean
# Absolute: the temp at a given time

# Begin exploring ---------------------------------------------------------

# How many kefj_* vectors are there? 6

# How long are they? 2187966

# What do they represent? Measurements + meta data for 2 million sampling events
# Temperature, site, date and time, tide level in meters, kind of temp reading
# (air, transition, or water), and the season bin

# Link to sketch

harris_datetime <- kefj_datetime[kefj_site == 'Harris']
harris_interval <- harris_datetime[-1] - harris_datetime[-2]
table(harris_interval)


harris_datetime[2] - harris_datetime[1]

# Problem decomposition ---------------------------------------------------

# When and where did the hottest and coldest air temperature readings happen?
kefj_datetime[which.min(kefj_temperature)]

# Link to sketch

# Plot the hottest day

hottest_idx <- ???(kefj_temperature)
hottest_time <- ???[hottest_idx]
??? <- kefj_site[???]
hotday_start <- as.POSIXct("???", tz = "Etc/GMT+8")
hotday_end <- as.POSIXct("???", tz = "Etc/GMT+8")
hotday_idx <- ??? == hottest_site &
  ??? >= hotday_start &
  ??? <= hotday_end
hotday_datetime <- ???[hotday_idx]
hotday_temperature <- ???
hotday_exposure <- ???
plot_kefj(???, ???, ???)

# Repeat for the coldest day

# What patterns do you notice in time, temperature, and exposure? Do those
# patterns match your intuition, or do they differ?

# How did Traiger et al. define extreme temperature exposure?

# Translate their written description to code and calculate the extreme heat
# exposure for the hottest day.

# Compare your answer to the visualization you made. Does it look right to you?

# Repeat this process for extreme cold exposure on the coldest day.


# Putting it together -----------------------------------------------------

# Link to sketch

# Pick one site and one season. What were the extreme heat and cold exposure at
# that site in that season?

# Repeat for a different site and a different season.

# Optional extension: Traiger et al. (2022) also calculated water temperature
# anomalies. Consider how you could do that. Make a sketch showing which vectors
# you would need and how you would use them. Write code to get the temperature
# anomalies for one site in one season in one year.

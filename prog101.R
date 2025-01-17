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
# Page 1-2

harris_datetime <- kefj_datetime[kefj_site == 'Harris']
harris_interval <- harris_datetime[-1] - harris_datetime[-length(harris_datetime)]
# alternatively <- harris_datetime[2:280498] - harris_datetime[1:280497]
table(harris_interval)
# 30 is the most common interval

length(harris_datetime)
harris_datetime[2] - harris_datetime[1]
harris_interval[1]
harris_interval[2]
harris_datetime[3] - harris_datetime[2]

# Problem decomposition ---------------------------------------------------
which.min(kefj_temperature) # Returning the element number of the lowest temp
kefj_datetime[63809]

# When and where did the hottest and coldest air temperature readings happen?
# Fetches the datetime element in the same position as the min and max temp
kefj_datetime[which.min(kefj_temperature)]
kefj_datetime[which.max(kefj_temperature)]
# Fetches the site element in the same position as the min and max temp
kefj_site[which.min(kefj_temperature)]
kefj_site[which.max(kefj_temperature)]

# Link to sketch
# Pages 3-5

# Plot the hottest day

# which.max(_temperature) is annoying to write repeatedly. It's output is just a
# random string of numbers. Give the output a var name so it's not confusing.
hottest_idx <- which.max(kefj_temperature)

# Use hottest_idx to store the values of time and site associated with that
# hottest temp (same element #) as named variables
hottest_time <- kefj_datetime[hottest_idx]
hottest_site <- kefj_site[hottest_idx]

# # Convert hottest_time into an object so numerical operations can be preformed
hottest_time_obj <- as.POSIXct(hottest_time, tz = "Etc/GMT+8")


# Add or subtract hours * 3600 (seconds in an hour) to get to the end of the day
hottest_start <- as.POSIXct(hottest_time_obj - (13 * 3600))
hottest_end <- as.POSIXct(hottest_time_obj+ (11 * 3600))

# Create a vector to index just the values associated with the hottest day
hotday_idx <- kefj_site == hottest_site &
  kefj_datetime >= hottest_start &
  kefj_datetime <= hottest_end

# Use hottday_idx to get vector sets of just the data for the hottest day
hotday_datetime <- kefj_datetime[hotday_idx]
hotday_temperature <- kefj_temperature[hotday_idx]
hotday_exposure <- kefj_exposure[hotday_idx]

# Plot the temperature over the course of the day w/exposure layered on it
plot_kefj(hotday_datetime, hotday_temperature, hotday_exposure)

?plot_kefj





# Repeat for the coldest day

# Make a variable for the sampling event we want to select
coldest_idx <- which.min(kefj_temperature)

# Use coldest_idx to store the values of time and site associated with that
# temp (aka the metadata for that sampling event) as named variables
coldest_time <- kefj_datetime[coldest_idx]
coldest_site <- kefj_site[coldest_idx]


# Convert coldest_time into an object so numerical operations can be preformed
coldest_time_obj <- as.POSIXct(coldest_time, tz = "Etc/GMT+8")

# Add or subtract hours * 3600 (seconds in an hour) to get to the ends of the day
coldest_start <- as.POSIXct(coldest_time_obj - (21 * 3600))
coldest_end <- as.POSIXct(coldest_time_obj+ (3 * 3600))
# Is there a shortcut im missing for this step?


# Create a vector to index just the values associated with the coldest day/site
coldday_idx <- kefj_site == coldest_site &
  kefj_datetime >= coldest_start &
  kefj_datetime <= coldest_end

# Use coldday_idx to get vector sets of just the data for the hottest day
coldday_datetime <- kefj_datetime[coldday_idx]
coldday_temperature <- kefj_temperature[coldday_idx]
coldday_exposure <- kefj_exposure[coldday_idx]

# Plot the temperature over the course of the day w/exposure layered on it
plot_kefj(coldday_datetime, coldday_temperature, coldday_exposure)

?plot_kefj



# What patterns do you notice in time, temperature, and exposure? Do those
# patterns match your intuition, or do they differ?

# Both extremes happen at the same site. Not surprising that one instrument's
# placement would make it the most sensitive. The coldest and hottest days were
# 6 months apart (different years). Checks out. The hottest and coldest days
# have very different exposure patterns. The coldest temp was recorded in a
# stretch of air exposure in between two shorter air/transition periods. The
# hottest temp was recorded in a long air/transition after a very brief air exposure.



# How did Traiger et al. define extreme temperature exposure?

# 1. Average max summer temps for upper limit of "normal", average min winter
# temps for lower limit
# 2. Counting up the hours that the air temp was at/above 25°C or at/below -4°C
# each day
# 3. Averaging those hours within each of the 5 seasons

# Translate their written description to code and calculate the extreme heat
# exposure for the hottest day.

# Make an index from all the temperatures in hotday_temp that are => 25
extreme_hot_idx <- hotday_temperature >= 25
# Pull the times associated w/extreme temps
extreme_hot_hours <- hotday_datetime[extreme_hot_idx]
extreme_hot_hours[1:7] # Look at all of those times! 3.5 hours of extreme exposure


# Compare your answer to the visualization you made. Does it look right to you?
# Calculated extreme temps every sampling event from 10am to 1pm
# On the graph, 10 and 1 look to be where the graphed line passes the 25° line

# Repeat this process for extreme cold exposure on the coldest day.
extreme_cold_idx <- coldday_temperature <= -4
extreme_cold_hours <- coldday_datetime[extreme_cold_idx]
extreme_cold_hours[1:8]
# Calculated extreme cold from 19 to 22:30. Matches graph
(length(extreme_cold_hours))/2 # 4 hours of extreme exposure

# Putting it together -----------------------------------------------------

?kefj_season


# Link to sketch
# Page 6

# For all extreme temperatures
extreme_temp_idx <- (kefj_temperature >= 25 | kefj_temperature <= -4) &
  (kefj_exposure == 'air' | kefj_exposure == 'air/trainsition')

# Pick one site and one season. What were the extreme heat and cold exposure at
# that site in that season?
# Step 1: find the # of days sampled at Nuka bay in the summer
# Narrow down the extreme index to just summer and Nuka_Bay
summer_idx <- kefj_season == 'Summer' & kefj_site == 'Nuka_Bay'

# Pull out extreme sampling events by indexing _datetime w/the summer index
summer_times <- kefj_datetime[summer_idx]

# The actual times don't matter, just grab the # of elements
summer_length <- length(summer_times)
summer_length <- summer_length/48 # Turns # of 30 minutes into # of days

# Step 2: find the # of hours of extreme air temperature
# Pull only the times that are true for both .idx summer_ex_times <-
# kefj_datetime[c(summer_idx, extreme_temp_idx)] doesn't seem to work
# Index for extreme sampling events at Nuka Bay in the summer
summer_ex_idx <- summer_idx == 'TRUE' & extreme_temp_idx == 'TRUE'

# Use that combined index to pull out all times of extreme temperature
summer_ex_times <- kefj_datetime[summer_ex_idx]

# Grab just number of extreme sampling events
extreme_summer <- length(summer_ex_times)
extreme_summer <- extreme_summer/2 # Convert # of 30 minutes into # of hours

# Step 3: Divide and store the number of extreme hours by the total number of
# summer hours at Nuka bay
average_summer_extreme <- extreme_summer/summer_length



# Repeat for a different site and a different season.------------

# Step 1: find the # of days sampled at McCarty in the early winter
# Narrow down the extreme index to just early winter and Mccarty
winter_idx <- kefj_season == 'Early winter' & kefj_site == 'McCarty'

# Pull out extreme sampling events by indexing _datetime w/the summer index
winter_times <- kefj_datetime[winter_idx]

# The actual times don't matter, just grab the # of elements
winter_length <- length(winter_times)
winter_length <- winter_length/48 # Turns # of 30 minutes into # of days

# Step 2: find the # of hours of extreme air temperature
# Pull only the times that are true for both .idx
# Index for extreme sampling events at McCarty in the early winter
winter_ex_idx <- winter_idx == 'TRUE' & extreme_temp_idx == 'TRUE'

# Use that combined index to pull out all times of extreme temperature
winter_ex_times <- kefj_datetime[winter_ex_idx]

# Grab just number of extreme sampling events
extreme_winter <- length(winter_ex_times)
extreme_winter <- extreme_winter/2 # Convert # of 30 minutes into # of hours

# Step 3: Divide and store the number of extreme hours by the total number of
# early winter hours at McCarty
average_winter_extreme <- extreme_winter/winter_length


# Optional extension: Traiger et al. (2022) also calculated water temperature
# anomalies. Consider how you could do that. Make a sketch showing which vectors
# you would need and how you would use them. Write code to get the temperature
# anomalies for one site in one season in one year.

# Sketch: pages 7 & 8

# Make datetime into time objects rstudio can recognize as times
datetime_obj <- as.POSIXct(kefj_datetime, tz = "Etc/GMT+8")
year <- format(datetime_obj, "%Y") # Simplify all datetimes into just the years
year_idx <- year == '2014' # Make an index showing where the year is 2014

# Make a vector of the water temps at Harris in spring of 2014
harris_spring <- kefj_temperature[kefj_season == 'Spring' &
                                    kefj_exposure == 'water' &
                                    kefj_site == 'Harris' &
                                    year_idx == 'TRUE']

# Make a vector of all of kefj's spring water temps
kefj_spring <- kefj_temperature[kefj_season == 'Spring' &
                                  kefj_exposure == 'water']

# Final step: subtracting the seasonal site mean from the regional one
anomaly <- mean(kefj_spring) - mean(harris_spring)

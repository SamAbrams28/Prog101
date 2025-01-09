# What does the following code do?
# Tip: `%%` is the remainder operator. E.g. 10 %% 4 is 2.
instrument_deployed_hm <- c(730, 915, 1345)
# Create a 3-element vector - hours:minutes -> hoursminutes.
instrument_deployed_h <- floor(instrument_deployed_hm / 100)
# Create a new 3-element vector that's the previous one divided by 100.
# This is the hours the instrument was deployed at.
# Floor gets rid of the minutes so it's just the hour data.
instrument_deployed_hdec <- (instrument_deployed_hm %% 100) / 60
# "Remainder" is the minutes. Converts the minutes into a decimal of an hour.
instrument_deployed <- instrument_deployed_h + instrument_deployed_hdec
# The deployment in hours with the minutes added as decimals.

# Based on the code above, calculate the duration of instrument deployments
# using the instrument recovery times below. What units do the durations have?
instrument_recovered_hm <- c(1600, 1920, 2015)
instrument_recovered_h <- floor(instrument_recovered_hm/100)
instrument_recovered_m <- (instrument_recovered_hm %% 100) / 60
instrument_recovered <- instrument_recovered_h + instrument_recovered_m

instrument_durations <- instrument_recovered - instrument_deployed

# Which site had the longest duration? Use conditional indexing.
site <- c("Santa Cruz", "Santa Rosa", "San Miguel")
site[instrument_durations == max(instrument_durations)]

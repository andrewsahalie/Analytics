# Analytics Data

# Analysis of screen positions to be passed to Tableau
##### This code requires derived fields that are created in "Analytics 02 Cleaning."

# Where ActionFix = “FromXToY”, grab Action, make separate table?, split out coordinates, filter out where change < 4 pixels.

# Time to split up all of these data that are currently in one value per row.
# Creates three temporary tables, each containing a UniqueID, splitting the X,Y location columns into four columns and putting them back into Analytics.
# Where ActionFix = “FromXToY”, grab Action, make separate table?, split out coordinates, filter out where change < 4 pixels.

Analytics$FromXToY[Analytics$ActionFix == 'FromXToY'] <- Analytics$Label[Analytics$ActionFix == 'FromXToY']
# Now Analytics$FromXToY is full of moves (e.g., "From 817/491;To 718/600;In2925ms"). Time to split those up into useful parts:
library(reshape2)
Analytics <- cbind(Analytics, colsplit(Analytics$FromXToY, ";", c("MovedFrom","MovedTo","MovedTime")))

# Separating X and Y location data in “from” locations, changing to numeric variables.
Analytics <- cbind(Analytics, colsplit(Analytics$MovedFrom, "/", c("MovedFromX","MovedFromY")))
Analytics$MovedFromX <- gsub("From ", "", Analytics$MovedFromX)
Analytics$MovedFromX <- as.numeric(Analytics$MovedFromX)
Analytics$MovedFromY <- as.numeric(Analytics$MovedFromY)

# Separating X and Y location data in “to” locations, changing to numeric variables.
Analytics <- cbind(Analytics, colsplit(Analytics$MovedTo, "/", c("MovedToX","MovedToY")))
Analytics$MovedToX <- gsub("To ", "", Analytics$MovedToX)
Analytics$MovedToX <- as.numeric(Analytics$MovedToX)
Analytics$MovedToY <- as.numeric(Analytics$MovedToY)

# Creating a variable (“Moved”) that can be used to filter out everything that is not a real move (>4 pixels)
Analytics$Distance <- (Analytics$MovedToX - Analytics$MovedFromX) + (Analytics$MovedToY - Analytics$MovedFromY)

Analytics$Moved <- ifelse(abs(Analytics$Distance) >= 5, "Yes Moved", NA)

# Removing temporary, intermediate variables:
Analytics <-  subset(Analytics, select = -c(MovedFrom, MovedTo))



# Establishing the display size for each user at the time of each record

# Sorting! (so that each users’ records are in a group with older records on the bottom)
Analytics <- Analytics[with(Analytics, order(UserIDMaybe, Date)), ]

# The following fills down the InstantaneousScreenWidth (etc.) values into EstimatedScreenWidth (etc.), but leaves NA for those records that
# are produced before a screen size is determined for a user.


# This fills down with values.
Analytics$EstimatedScreenWidth <- NA
require(dplyr)
Analytics <-  subset(Analytics, select = -c(DateTest))

# It doesn’t work to start with unknown screen sizes at new Lesson because Lesson is always “unknown” at Action = start. IPAddress is used instead.
Analytics$UserIPAddressInstance <- paste(Analytics$UserIDMaybe, Analytics$IPAddress, sep = "-")

library(zoo)
na.locf2 <- function(x) na.locf(x, na.rm = FALSE)
Analytics <- transform(Analytics, EstimatedScreenWidth = ave(InstantaneousScreenWidth, UserIPAddressInstance, FUN = na.locf2))

na.locf2 <- function(x) na.locf(x, na.rm = FALSE)
Analytics <- transform(Analytics, EstimatedScreenHeight = ave(InstantaneousScreenHeight, UserIPAddressInstance, FUN = na.locf2))


Analytics <-  subset(Analytics, select = -c(UserIPAddressInstance))

# Optional test files:
# TestyMcTestersonForScreenSizes <- subset(Analytics, select=c(UserIDMaybe, Date, Action, IPAddress, Label, EstimatedScreenWidth,
# EstimatedScreenHeight, InstantaneousScreenWidth, InstantaneousScreenHeight))

# write.csv(TestyMcTestersonForScreenSizes, file = "TestyMcTestersonForScreenSizes.csv", row.names = TRUE)





# Putting screen sizes and locations to use together to see screen positions in Tableau:
Analytics$FromXPct <- ifelse(Analytics$Moved == "Yes Moved", Analytics$MovedFromX / Analytics$EstimatedScreenWidth, NA)

Analytics$FromYPct <- ifelse(Analytics$Moved == "Yes Moved", Analytics$MovedFromY / Analytics$EstimatedScreenHeight, NA)

Analytics$ToXPct <- ifelse(Analytics$Moved == "Yes Moved", Analytics$MovedToX / Analytics$EstimatedScreenWidth, NA)

Analytics$ToYPct <- ifelse(Analytics$Moved == "Yes Moved", Analytics$MovedToY / Analytics$EstimatedScreenHeight, NA)

# This part (pair/listwise) removes values for which something was seemingly moved outside the bounds of the display. They are removed
# pair/listwise because we don’t want to see incomplete location information (might be confusing).
# Although the values of 0 and 1 for "...pct" are included, those values were not found in Y1RFS data.
Analytics$FromXPct[
	Analytics$FromXPct > 1 |
	Analytics$FromXPct < 0 |
	is.na(Analytics$FromXPct) |
	Analytics$FromYPct > 1 |
	Analytics$FromYPct < 0 |
	is.na(Analytics$FromYPct) |
	Analytics$ToXPct > 1 |
	Analytics$ToXPct < 0 |
	is.na(Analytics$ToXPct) |
	Analytics$ToYPct > 1 |
	Analytics$ToYPct < 0 |
	is.na(Analytics$ToYPct)
] <- NA

Analytics$FromYPct[
	Analytics$FromXPct > 1 |
	Analytics$FromXPct < 0 |
	is.na(Analytics$FromXPct) |
	Analytics$FromYPct > 1 |
	Analytics$FromYPct < 0 |
	is.na(Analytics$FromYPct) |
	Analytics$ToXPct > 1 |
	Analytics$ToXPct < 0 |
	is.na(Analytics$ToXPct) |
	Analytics$ToYPct > 1 |
	Analytics$ToYPct < 0 |
	is.na(Analytics$ToYPct)
] <- NA

Analytics$ToXPct[
	Analytics$FromXPct > 1 |
	Analytics$FromXPct < 0 |
	is.na(Analytics$FromXPct) |
	Analytics$FromYPct > 1 |
	Analytics$FromYPct < 0 |
	is.na(Analytics$FromYPct) |
	Analytics$ToXPct > 1 |
	Analytics$ToXPct < 0 |
	is.na(Analytics$ToXPct) |
	Analytics$ToYPct > 1 |
	Analytics$ToYPct < 0 |
	is.na(Analytics$ToYPct)
] <- NA

Analytics$ToYPct[
	Analytics$FromXPct > 1 |
	Analytics$FromXPct < 0 |
	is.na(Analytics$FromXPct) |
	Analytics$FromYPct > 1 |
	Analytics$FromYPct < 0 |
	is.na(Analytics$FromYPct) |
	Analytics$ToXPct > 1 |
	Analytics$ToXPct < 0 |
	is.na(Analytics$ToXPct) |
	Analytics$ToYPct > 1 |
	Analytics$ToYPct < 0 |
	is.na(Analytics$ToYPct)
] <- NA

############ Optional testing:############
	# head(unique(Analytics$FromXPct),100)
		# summary(Analytics$FromXPct)
	# head(unique(Analytics$FromYPct),100)
		# summary(Analytics$FromYPct)
	# head(unique(Analytics$ToXPct),100)
		# summary(Analytics$ToXPct)
	# head(unique(Analytics$ToYPct),100)
		# summary(Analytics$ToYPct)


# Creating a table (“LocationDataForTableau”). This involves creating two tables and combining them to duplicate the number of records -
# one record for each “to” move and one record for each “from” move. This is how Tableau needs it.

LocationDataA <- Analytics
LocationDataA$ToOrFrom <- 'To'
LocationDataA$XLoc <- LocationDataA$ToXPct
LocationDataA$YLoc <- LocationDataA$ToYPct

LocationDataB <- Analytics
LocationDataB$ToOrFrom <- 'From'
LocationDataB$XLoc <- LocationDataB$FromXPct
LocationDataB$YLoc <- LocationDataB$FromYPct

# Production of the data file for Tableau. To access, use the existing Tableau file (analytics/Location Data From R) and just refresh the data.
LocationDataForTableau <- rbind(LocationDataA, LocationDataB)
LocationDataForTableau <- LocationDataForTableau[!is.na(LocationDataForTableau$ToXPct),]


# Enabling filtering to only those users who had at least 20 actions in the given Lesson/Environment combination.
LocationDataForTableau$UserLessonEnvironment <-
paste(LocationDataForTableau$UserIDMaybe, LocationDataForTableau$Lesson, LocationDataForTableau$Environment, sep = "-")

# ActionsFilters comes from running "Analytics 05 Actions.R"
LocationDataForTableau <- merge(LocationDataForTableau, ActionsFilters, by = "UserLessonEnvironment", all = TRUE)



write.csv(LocationDataForTableau, file = "LocationDataForTableau.csv")
# you can find this file in Andrew/LocationDataForTableau.csv
# For more information, see “DragPaths” Tableau file



# IDForScreenSize is an intermediate variable used to determine when users’ display size has actually changed. Later, that info will be
# used to create a record of each display size that each user experienced.
Analytics$IDForScreenSize <- Analytics$EstimatedScreenWidth + (Analytics$EstimatedScreenHeight * 1000)

# Creating a table of users and unique screen sizes….
AggScreenSize1 <- aggregate(Analytics$IDForScreenSize, list(
	IDForScreenSize = Analytics$IDForScreenSize,
	UserIDMaybe = Analytics$UserIDMaybe,
	DisplayWidth = Analytics$EstimatedScreenWidth,
	DisplayHeight = Analytics$EstimatedScreenHeight), mean)
AggScreenSize1 <-  subset(AggScreenSize1, select = -c(x))

write.csv(AggScreenSize1, file = "DisplaySizeDataForTableau.csv")
# Find the Tableau file in Documents -> Analytics Testing, and then just overwrite the data and refresh in Tableau. But it’s
# easy to recreate if you don’t do that.

# Removing the temporary variable IDForScreenSize
Analytics <-  subset(Analytics, select = -c(IDForScreenSize))









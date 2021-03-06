# Analytics Data: A data manual exists for these data. See Andrew.

require(plyr)
require(dplyr)

# New YYYY.MM.DD format variable Analytics$Day for use in Kibana:
Analytics$Day <- gsub("-", ".", substr(Analytics$Date, 1, 10))
# There are problems with R changing date formats when writing to csv. See this link?
# http://stackoverflow.com/questions/23295571/how-to-prevent-write-csv-from-changing-posixct-dates-and-times-class-back-to-ch


# Dates - Analytics$Date has a stupid mm vs m thing, so this has leading zeroes:
Analytics$DateTest <- strptime(Analytics$Date, "%Y-%m-%d %H:%M:%S")


# Minutes used per student per lecture
# Creating a Minute variable and counting unique instances of minutes per student per lecture
Analytics$DateTest <- strptime(Analytics$Date, "%Y-%m-%d %H:%M:%S")
Analytics$Minute <- substr(Analytics$DateTest, 1, 16)

require(dplyr)
MinutesUserLesson <-  subset(Analytics[
	Analytics$Environment == "Hillock" |
	Analytics$Environment == "Lecture view" |
	Analytics$Environment == "Neuron" |
	Analytics$Environment == "SynapticCleft",
], select = -c(DateTest))

MinutesUserLessonSummary <- ddply(MinutesUserLesson,
	c("UserIDMaybe", "Lesson"), summarise, MinutesUsed = length(unique(Minute)), ActionCount = length(unique(UniqueID)))

# Don’t count the first minute - not a full minute:
MinutesUserLessonSummary$MinutesUsed <- MinutesUserLessonSummary$MinutesUsed - 1

# Minutes used per lesson
# Creating a Minute variable and counting unique instances of minutes per environment
# Only includes those users who performed at least 20 actions as per Y1RFS report.
require(dplyr)
MinutesLessonSummary <- ddply(MinutesUserLessonSummary[MinutesUserLessonSummary$ActionCount > 19, ],
	c("Lesson"), summarise, UserMinutes = sum(MinutesUsed), MeanUserMinutes = mean(MinutesUsed))



# Use this to select only records that happen after a specific time:
# MinutesAfter <- unique(Minutes[Minutes$Minute>"2016-02-16 11:59", ])

# Use this to test data:
# Test <- unique(Minutes[Minutes$UserIDMaybe == "27", ])

# Minutes used per student per environment
# Creating a Minute variable and counting unique instances of minutes per student per environment
Analytics$DateTest <- strptime(Analytics$Date, "%Y-%m-%d %H:%M:%S")
Analytics$Minute <- substr(Analytics$DateTest, 1, 16)

require(dplyr)

MinutesUserEnvironment <-
subset(Analytics[
	Analytics$Environment == "Hillock" |
	Analytics$Environment == "Lecture view" |
	Analytics$Environment == "Neuron" |
	Analytics$Environment == "SynapticCleft",
], select = -c(DateTest))

MinutesUserEnvironmentSummary <- ddply(MinutesUserEnvironment,
	c("UserIDMaybe", "Environment"), summarise, MinutesUsed = length(unique(Minute)), ActionCount = length(unique(UniqueID)))

# Don’t count the first minute - not a full minute:
MinutesUserEnvironmentSummary$MinutesUsed <- MinutesUserEnvironmentSummary$MinutesUsed - 1

# Minutes used per environment
# Creating a Minute variable and counting unique instances of minutes per environment
# Only includes those users who performed at least 20 actions as per Y1RFS report.
require(dplyr)
MinutesEnvironmentSummary <- ddply(MinutesUserEnvironmentSummary[MinutesUserEnvironmentSummary$ActionCount > 19,],
	c("Environment"), summarise, UserMinutes = sum(MinutesUsed), AvgUserMinutes = mean(MinutesUsed), UserActions = sum(ActionCount),
	AvgUserActions = mean(ActionCount))

MinutesUserLessonSummary$MinBin <- cut(MinutesUserLessonSummary$MinutesUsed, breaks = seq(0, 120, by = 5), include.lowest = TRUE)
MinutesUserLessonBins <- ddply(MinutesUserLessonSummary, c("MinBin"), summarise, Users = length(unique(UserIDMaybe)))


# MinutesUserLessonBinsOOC <-  subset(MinutesUserLessonBins, select = -c(DateTest))
MinutesUserLessonBinsOOC <- ddply(MinutesUserLessonSummary[MinutesUserLessonSummary$Lesson == "undefined", ],
	c("MinBin"), summarise, Users = length(unique(UserIDMaybe)))



# Use this to select only records that happen after a specific time:
# MinutesEnvironmentAfter <- unique(MinutesEnvironment[MinutesEnvironment$Minute>"2016-02-16 11:59",])
# Use this to test data:
# Test <- unique(MinutesEnvironment[MinutesEnvironment$UserIDMaybe == "27", ])













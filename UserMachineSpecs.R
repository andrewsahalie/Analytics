# User machine specifications:
# The analysis can’t be completed because Scott never matched the unique IDs in the spec grabber data - see 4/4/16 email to Scott that was never returned.

# This part brings a CanvasID from a csv into a subset of the Analytics data (with Action == “Start” where there are display size data).
IDLookup <- read.csv("~/Documents/Y1RFS/Y1RFS IDLookup.csv",  header=TRUE, sep=",", stringsAsFactors=FALSE)

# The result of this is a df with two unique ids (CanvasID and UserIDMaybe) and one record for each computer, hopefully, that each student used. Also included is “count,” which says how many times the user has a “Start” record for the specs in that row.
UserMachineSpecs <- merge(Analytics, IDLookup, by.x = "UserIDMaybe", by.y = "UserIDMaybe")

UserMachineSpecs <- UserMachineSpecs[c("Date", "UniqueID", "UserIDMaybe", "ActionFix", "StudentOrTeacher", "ScreenSizeRaw", "PixelRatio","CanvasID")]

UserMachineSpecs <- UserMachineSpecs[which(UserMachineSpecs$ActionFix=='Start'),]

require(plyr)
UserMachineSpecs <- ddply(UserMachineSpecs,.(UserIDMaybe,ScreenSizeRaw),transform,count = length(UserIDMaybe))

UserMachineSpecs <-  subset(UserMachineSpecs, select=-c(Date, UniqueID, ActionFix))
UserMachineSpecs <- unique(UserMachineSpecs, by=c("UserIDMaybe", "ScreenSizeRaw"))


#Analytics Data

#### First user selection criterion: If there’s a name in V2 (e.g., “Tom”), I want the record gone. (We’re interested in students
# only - not Dynamoidians or instructors for this part.) This part makes a temporary variable, replaces all single- and multi-digit
# numbers “1”, and then only numbers are accepted in the following part, which is what I want for these IDs that are unique to each user.

	MergedAnalyticsFile$TempNumberIDs <- gsub("1|2|3|4|5|6|7|8|9|0", "1", MergedAnalyticsFile$V2)
	MergedAnalyticsFile$TempNumberIDs <- gsub("1111", "1", MergedAnalyticsFile$TempNumberIDs)
	MergedAnalyticsFile$TempNumberIDs <- gsub("111", "1", MergedAnalyticsFile$TempNumberIDs)
	MergedAnalyticsFile$TempNumberIDs <- gsub("11", "1", MergedAnalyticsFile$TempNumberIDs)


#The result is a TempNumberIDs variable that is used to filter out non-numeric unique user IDs.

#### Second user selection criterion: If there’s not a date in V1, I want the record gone. This part makes a temporary variable,
# replaces all single- and multi-digit numbers “1”, and then only date formats are accepted in the following part.

	MergedAnalyticsFile$TempDateCheck <- gsub("1|2|3|4|5|6|7|8|9|0", "1", MergedAnalyticsFile$V1)
	MergedAnalyticsFile$TempDateCheck <- gsub("1111", "1", MergedAnalyticsFile$TempDateCheck)
	MergedAnalyticsFile$TempDateCheck <- gsub("111", "1", MergedAnalyticsFile$TempDateCheck)
	MergedAnalyticsFile$TempDateCheck <- gsub("11", "1", MergedAnalyticsFile$TempDateCheck)

#The result is a TempDateCheck variable that is used to filter out non-dates.

#### Moves the filtered data (meeting the above two criteria minus errors and rows without dates in the first column) to the final
# location (Analytics is the primary data frame now).
	Analytics <- MergedAnalyticsFile[MergedAnalyticsFile$V5 != 'Error' & MergedAnalyticsFile$V5 != 'Stored Error' & MergedAnalyticsFile$TempDateCheck == '1-1-1 1:1:1' & MergedAnalyticsFile$TempNumberIDs == '1',]

#Naming the columns in Analytics
colnames(Analytics) <- c("Date","UniqueID","UserIDMaybe","Lesson","Platform","UIThing","Action","Label","Environment","FrameRate", "StudentOrTeacher","IPAddress","TempNumberIDs","TempDateCheck")
#Removing the temporary variables
Analytics <-  subset(Analytics, select=-c(TempNumberIDs,TempDateCheck))

#Making sure we didn’t bring any error rows or other data that don’t have an associated Lesson (but out-of-class records are okay):
#The output should show “0” NAs in Lesson
Analytics$Lesson <- as.factor(Analytics$Lesson)
sum(is.na(Analytics$Lesson))

#Simplifying confusing Label values
# As possible, the code looks for generalizable patterns (using “grep”) to clean records. The “sub” function is used to clean more specific
# values for those cases where it would be irresponsible to generalize cleaning behaviors with grep.

# The variable LabelFix is used for most analyses in the future, but Label is still maintained in case the original information is needed
# for troubleshooting (or, in the case of screen size and position, to extract more information).

Analytics$LabelFix <- Analytics$Label


######This part fixes the x/y labels (e.g., x1385y721) by changing all digits to “1” into a TempXY variable and then
##### putting “OtherLabel” in LabelFix where a correct pattern exists in TempXY.

	Analytics$TempXY <- gsub("1|2|3|4|5|6|7|8|9|0", "1", Analytics$Label)
	Analytics$TempXY <- gsub("11", "1", Analytics$TempXY)
	Analytics$TempXY <- gsub("11", "1", Analytics$TempXY)
	Analytics$TempXY <- gsub("11", "1", Analytics$TempXY)
	Analytics$TempXY <- gsub("x1y1", "OtherLabel", Analytics$TempXY)
	Analytics$LabelFix[grep("OtherLabel",Analytics$TempXY)]<-paste(Analytics$TempXY[grep("OtherLabel",Analytics$TempXY)])

	#Cleaning up that temporary variable:
	Analytics <-  subset(Analytics, select=-c(TempXY))

######Similar to above, cleans FromXToY records:#####

	Analytics$TempXY <- gsub("1|2|3|4|5|6|7|8|9|0", "1", Analytics$Label)
	Analytics$TempXY <- gsub("1111", "1", Analytics$TempXY)
	Analytics$TempXY <- gsub("111", "1", Analytics$TempXY)
	Analytics$TempXY <- gsub("11", "1", Analytics$TempXY)
	Analytics$TempXY <- gsub("From 1/1;To 1/1;In1ms", "FromXToY", Analytics$TempXY)
	Analytics$LabelFix[grep("FromXToY",Analytics$TempXY)]<-paste(Analytics$TempXY[grep("FromXToY",Analytics$TempXY)])
	#Cleaning up that temporary variable:
	Analytics <-  subset(Analytics, select=-c(TempXY))

##### Creating LabelFix; simplified Label:########

	Analytics$LabelFix[grep("BUTTON;a",Analytics$LabelFix)] <- "Button"
	Analytics$LabelFix[grep("BUTTON;c",Analytics$LabelFix)] <- "Button"
	Analytics$LabelFix[grep("BUTTON;f",Analytics$LabelFix)] <- "Button"
	Analytics$LabelFix[grep("BUTTON;h",Analytics$LabelFix)] <- "Button"
	Analytics$LabelFix[grep("BUTTON;s",Analytics$LabelFix)] <- "Button"

	Analytics$LabelFix[grep("BODY;;   \n\n\n\n\n\n\nNeurobiology Lecture\n\n\n\n\n\n\n\n\n\nPopulating neighboring neurons",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("DIV;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("g;\\[object",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("H1;home;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("H2;;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("HTML;;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("I;lecture",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("I;student",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("INPUT;;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("logo-icon;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("MAIN;;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("OtherLabelPOLL",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("P;;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("P;response-",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("P;slide",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("P;text-disabled;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("P;timestamp;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("path;\\[o",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("SECTION; collap",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("SECTION;;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("SECTION;student",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("SPAN;;",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("SPAN;division",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("SVGAnimatedString",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("text;\\[object",Analytics$LabelFix)] <- "OtherLabel"
	Analytics$LabelFix[grep("UL;extra-options;",Analytics$LabelFix)] <- "OtherLabel"

	Analytics$LabelFix[grep(";To ",Analytics$LabelFix)] <- "FromXToY"

	Analytics$LabelFix[grep("P;message",Analytics$LabelFix)] <- "Message"

	Analytics$LabelFix[grep("LI;poll-option;",Analytics$LabelFix)] <- "PollOption"
	Analytics$LabelFix[grep("P;poll-title;",Analytics$LabelFix)] <- "PollTitle"

	Analytics$LabelFix[grep("resting_potential",Analytics$LabelFix)] <- "Resting Potential"

	Analytics$LabelFix[grep("VOLTAGE VS. TIME",Analytics$Label)] <- "Clicked Voltage Line"

#Fixing instances where Action should be Label, vice-versa:
#Action values that should be Label: “Voltage graph”, “poll”, “poll responses”, “message”
#Label (LabelFix) that should be Action: “FromXToY”

#Diagnosing these things:
#TempAnalytics <- Analytics[Analytics$Action == 'Voltage Graph' | Analytics$Action == 'poll' | Analytics$Action == 'poll responses' | Analytics$Action == 'message' | Analytics$LabelFix == 'FromXToY',]

# Diagnose: tail(TempAnalytics,250)

#...The results show that I should switch label and action for all these criteria.
# I do that here:
Analytics[Analytics$LabelFix == "FromXToY", c("Action", "LabelFix")] <- Analytics[Analytics$LabelFix == "FromXToY", c("LabelFix", "Action")]

#Diagnosing those others: (“poll” and “button,” for example, are both like labels, so they can stay.)
#table(Analytics$Action[Analytics$Action == 'poll'],Analytics$LabelFix[Analytics$Action == 'poll'])

#table(Analytics$Action[Analytics$Action == 'poll responses'],Analytics$LabelFix[Analytics$Action == 'poll responses'])

#table(Analytics$Action[Analytics$Action == 'message'], Analytics$LabelFix[Analytics$Action == 'message'])



####### Putting away screen sizes for later use before they get destroyed in the cleaning process:
# This grabs those records where the user starts a session, as identified by the presence of “screen:...”,
# and removes “screen:” from them to get down to the numbers.

	Analytics$ScreenSizeRaw <- NA
	Analytics$ScreenSizeRaw[grep("screen:",Analytics$Action)] <- Analytics$Action[grep("screen:",Analytics$Action)]
	Analytics$ScreenSizeRaw <- gsub("screen:", "", Analytics$ScreenSizeRaw)

	Analytics$ScreenSizeRaw[grep("Resize",Analytics$Action)] <- Analytics$Label[grep("Resize",Analytics$Action)]

	Analytics$ScreenSizeRaw[grep("Resize",Analytics$Action)] <- gsub("x","",Analytics$Label[grep("Resize",Analytics$Action)])

	#Getting the delimiters consistent (“x”)
	Analytics$ScreenSizeRaw <- gsub("y", "x", Analytics$ScreenSizeRaw)

	#Transforming ScreenSizeRaw into legit widths and heights.
	library(reshape2)
	Analytics <- cbind(Analytics, colsplit(Analytics$ScreenSizeRaw, "x", c("InstantaneousScreenWidth", "InstantaneousScreenHeight")))

	Analytics$InstantaneousScreenHeight <- as.numeric(Analytics$InstantaneousScreenHeight)

	# Establishing the starting screen Y size (minus 75 pixels for the address bar as per AJ+ in Y1RFS):
	Analytics$InstantaneousScreenHeight[grep("Resize",Analytics$Action)] <- Analytics$InstantaneousScreenHeight[grep("Resize",Analytics$Action)] -75

	# I’m keeping ScreenSizeRaw in here to make sure that the 75 pixels aren’t subtracted multiple times (confirmed by comparing ScreenSizeRaw
	# to ScreenHeight when Action==Resized.

	#TroubleshootingScreenSizes <- subset(Analytics, select=c(UserIDMaybe, Date, Action, Label,InstantaneousScreenWidth, InstantaneousScreenHeight,ScreenSizeRaw))
	#write.csv(TroubleshootingScreenSizes, file = "TroubleshootingScreenSizes.csv", row.names = TRUE)


# Handling records for “start” (UIThing is pixelratio when UIThing == Start (which should be an Action), and those should be sorted out).
# - the following parts clean up other crap that happens when UIThing == Start
# Move UIThing, when “Start” to Action
Analytics$Action[grep("Start",Analytics$UIThing)] <- "Start"

# Label is “window:undefinedxundefined” (which doesn’t make any sense) when Action == “Start”, so that is deleted here
Analytics$LabelFix[grep("window:undefinedxundefined",Analytics$LabelFix)] <- ""

# Populating a PixelRatio variable in case that’s useful in the future.

	Analytics$PixelRatio[grep("Start",Analytics$UIThing)] <- Analytics$Environment[grep("Start",Analytics$UIThing)]
	Analytics$Environment[grep("Start",Analytics$UIThing)] <- ""
	Analytics$FrameRate[grep("Start",Analytics$UIThing)] <- ""
	Analytics$UIThing[grep("Start",Analytics$UIThing)] <- ""



# Simplifying confusing strings: Data cleaning from Action to ActionFix

	Analytics$ActionFix <- Analytics$Action

	Analytics$TempXY <- gsub("1|2|3|4|5|6|7|8|9|0", "1", Analytics$Action)
	Analytics$TempXY <- gsub("1111", "1", Analytics$TempXY)
	Analytics$TempXY <- gsub("111", "1", Analytics$TempXY)
	Analytics$TempXY <- gsub("11", "1", Analytics$TempXY)

	Analytics$TempXY <- gsub("-", "", Analytics$TempXY)
	Analytics$TempXY <- gsub("Added at \\(1.1, 1.1, 1.1\\)", "Added", Analytics$TempXY)
	Analytics$TempXY <- gsub("Removed at \\(1.1, 1.1, 1.1\\)", "Added", Analytics$TempXY)
	Analytics$TempXY <- gsub("Moved to \\(1.1, 1.1, 1.1\\)", "Added", Analytics$TempXY)
	Analytics$TempXY <- gsub("Screen:1x1", "ScreenSize", Analytics$TempXY)

	Analytics$ActionFix[grep("Added",Analytics$TempXY)]<-paste(Analytics$TempXY[grep("Added",Analytics$TempXY)])
	Analytics$ActionFix[grep("Removed",Analytics$TempXY)]<-paste(Analytics$TempXY[grep("Removed",Analytics$TempXY)])
	Analytics$ActionFix[grep("Moved",Analytics$TempXY)]<-paste(Analytics$TempXY[grep("Moved",Analytics$TempXY)])
	Analytics$ActionFix[grep("ScreenSize",Analytics$TempXY)]<-paste(Analytics$TempXY[grep("ScreenSize",Analytics$TempXY)])

# Removing temporary variable TempXY from Analytics
Analytics <-  subset(Analytics, select=-c(TempXY))

# Creating ActionLabel
Analytics$ActionLabel <- paste(Analytics$ActionFix, Analytics$LabelFix, sep = "-")



#Creating a unique ID for each row! - Maybe it will come in handy later.
Analytics$UniqueID <- seq_len(nrow(Analytics))

# Enabling filtering to only those users who had at least 20 actions in the given Lesson/Environment combination.
Analytics$UserLessonEnvironment <- paste(Analytics$UserIDMaybe, Analytics$Lesson, Analytics$Environment, sep = "-")

# Output file!
write.csv(Analytics, file = "Analytics.csv")




########## Analytics inspection commands: #############
	#head(unique(Analytics$UniqueID), 150)
	#head(unique(Analytics$UserIDMaybe),150)
	#unique(Analytics$Lesson)
	#table(Analytics$LessonEnvironment)
	#unique(Analytics$Platform)
	#head(unique(Analytics$UIThing), 100)
	#unique(Analytics$Environment)
	#unique(Analytics$StudentOrTeacher)

	#unique(Analytics$LabelFix)

	#unique(Analytics$ActionFix)

	#unique(Analytics$ActionLabel)


	#table(Analytics$UserIDMaybe,Analytics$ActionFix)
	#table(Analytics$UserIDMaybe)
	#table(Analytics$UserIDMaybe,Analytics$Lesson)
	#table(Analytics$UniqueID,Analytics$Lesson)


	#table(Analytics$UserIDMaybe,Analytics$UniqueID)

	#table(Analytics$UniqueID,Analytics$StudentOrTeacher)

	#table(Analytics$Lesson)
	#table(Analytics$Platform)
	#table(Analytics$Lesson,Analytics$Platform)
	#table(Analytics$ActionFix,Analytics$Platform)
	#table(Analytics$LabelFix,Analytics$Platform)
	#table(Analytics$UserIDMaybe,Analytics$Environment)
	#table(Analytics$IPAddress)
	#table(Analytics$PixelRatio,Analytics$UserIDMaybe)










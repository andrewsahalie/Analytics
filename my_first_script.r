#LogsTable
# The code starts with data file and DF “Better” and spits out a finished “Voltage” DF.
LogsTableRaw<-fromJSON("URLFromCaz")
# extracting the data
LogsTable<-LogsTableRaw

Better <- read.csv("~/Downloads/Data/pyscratch/better.csv", header=FALSE)

# At this point, the DF (“Better”) is still a mess. Columns don’t line up, for example. Don’t bother doing diagnostics yet.

colnames(Better) <- c("Name","Hostname", "PID", "Level", "Subject", "Verb", "Voltage", "UserID", "Name2", "TimeStamp", "Msg",  "Time", "V")

## This filters, excludes logs that don’t meet analytics criteria (e.g., error logs, which are prolific in the source file)
Voltage<-Better[Better$Subject == 'subject:voltage',]



# The following bits align columns and clean things up.

#Fixing InstanceID first - where they exist
Voltage$InstanceIDFix <- "NA"
Voltage$InstanceIDFix[grep("instance",Voltage$UserID)]<-paste(Voltage$UserID[grep("instance",Voltage$UserID)])

#Fixing Voltage Column
Voltage$UserIDFix <- "NA"
Voltage$UserIDFix[grep("user:id",Voltage$UserID)]<-paste(Voltage$UserID[grep("user:id",Voltage$UserID)])
Voltage$UserIDFix[grep("user:id",Voltage$Name2)]<-paste(Voltage$Name2[grep("user:id",Voltage$Name2)])

#Fixing Timestamp Column (in msg too)
Voltage$TimestampFix <- "NA"
Voltage$TimestampFix[grep("timestamp",Voltage$TimeStamp)]<-paste(Voltage$TimeStamp[grep("timestamp",Voltage$TimeStamp)])
Voltage$TimestampFix[grep("timestamp",Voltage$Msg)]<-paste(Voltage$Msg[grep("timestamp",Voltage$Msg)])

#Fixing Name Column (in Name2 and timestamp)
Voltage$NameFix <- "NA"
Voltage$NameFix[grep("name:",Voltage$Name2)]<-paste(Voltage$Name2[grep("name:",Voltage$Name2)])
Voltage$NameFix[grep("name:",Voltage$TimeStamp)]<-paste(Voltage$TimeStamp[grep("name:",Voltage$TimeStamp)])

#Fixing V Column (in V and Other (was “NA” column))
Voltage$VFix <- "NA"
Voltage$VFix[grep("v:",Voltage$V)]<-paste(Voltage$V[grep("v:",Voltage$V)])
Voltage$VFix[grep("v:",Voltage$Other)]<-paste(Voltage$Other[grep("v:",Voltage$Other)])

# Optional intermediate variable diagnostics (these will change next)
#head(Voltage)
#unique(Voltage$InstanceIDFix)
#unique(Voltage$UserIDFix)
#head(Voltage$TimestampFix,100)
#unique(Voltage$NameFix)
# Above: Note that NameFix has string names in it - the Analytics data don’t, and the corresponding variable is numeric. Maybe this’ll be important later. But I want the names here, so it’ll change if/when needed.
#unique(Voltage$VFix)
#head(Voltage$VFix,100)



#Removing parts of strings 
Voltage$TimestampFix <- gsub("timestamp:", "", Voltage$TimestampFix, ignore.case = TRUE)
head(Voltage$TimestampFix,100)

Voltage$Voltage <- gsub("voltage:", "", Voltage$Voltage, ignore.case = TRUE)
Voltage$Voltage <- as.numeric(as.character(Voltage$Voltage))
head(Voltage$Voltage,100)

Voltage$NameFix <- gsub("name:", "", Voltage$NameFix, ignore.case = TRUE)
unique(Voltage$NameFix)

Voltage$Verb <- gsub("verb:", "", Voltage$Verb, ignore.case = TRUE)
unique(Voltage$Verb)

Voltage$UserIDFix <- gsub("user:id:", "", Voltage$UserIDFix, ignore.case = TRUE)
head(Voltage$UserIDFix,100)





# Time data stuff: This first part creates a TimeFromStamp that is used later.
Voltage$TimestampFix <- as.numeric(Voltage$TimestampFix)
Voltage$TimeFromStamp <- as.POSIXct(Voltage$TimestampFix, origin="1970-01-01")

# TimeBins are 1-minute periods that are used to diagnose connectivity issues, at least.
Voltage$Minute <- round(Voltage$TimeFromStamp,"mins")

# Tables of voltage by minute for the whole group and for each user (into the AggVoltage1 and AggVoltage2 DFs)
Voltage$MinuteChar <- as.character(Voltage$Minute)
AggVoltage1 <- aggregate(Voltage$Voltage, list(MinuteChar = Voltage$MinuteChar), mean)
AggVoltage2 <- aggregate(Voltage$Voltage, list(MinuteChar = Voltage$MinuteChar, UserID = Voltage$UserID), mean)

# Graph of voltage over time (will need to adjust xlim to graph only period of interest)
AggVoltage1$Minute <- as.POSIXct(AggVoltage1$MinuteChar)
plot(AggVoltage1$Minute, AggVoltage1$x, ylim = c(-100, 100), xlim=c(as.POSIXct('2016-02-10 12:30:00', format="%Y-%m-%d %H:%M:%S"), as.POSIXct('2016-02-11 12:30:00', format="%Y-%m-%d %H:%M:%S")))
# Analytics Data
# EXTRACTION: The real extraction code hasn’t been written yet
# LogsTableRaw<-fromJSON("URLFromCaz")

# Extracting the data
# LogsTable<-LogsTableRaw

# RawLogs <- read.csv("~/Documents/Y1RFS/Analytics Data/Y1RFS Day-2 Data.csv",  header=FALSE, sep="|", )

# Reading in raw data from CSV files. These files are created from https://destinationbiology.com/analytics/ (See documentation about how to get these data elsewhere)

	AnalyticsFeeder01 <- read.csv("~/Documents/Y1RFS/Analytics Data/Raw Data/Y1RFS Day 1 DataFix.csv",  header=FALSE, sep="|", stringsAsFactors=FALSE)
	AnalyticsFeeder01 <- AnalyticsFeeder01[, c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12")]

	AnalyticsFeeder02 <- read.csv("~/Documents/Y1RFS/Analytics Data/Raw Data/Y1RFS Day-2 Data.csv",  header=FALSE, sep="|", stringsAsFactors=FALSE)
	AnalyticsFeeder02 <- AnalyticsFeeder02[, c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12")]

	AnalyticsFeeder03 <- read.csv("~/Documents/Y1RFS/Analytics Data/Raw Data/Y1RFS Day3Data.csv",  header=FALSE, sep="|", stringsAsFactors=FALSE)
	AnalyticsFeeder03 <- AnalyticsFeeder03[, c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12")]

	AnalyticsFeeder04 <- read.csv("~/Documents/Y1RFS/Analytics Data/Raw Data/Y1RFS NonLectureDataFix.csv",  header=FALSE, sep="|", stringsAsFactors=FALSE)
	AnalyticsFeeder04 <- AnalyticsFeeder04[, c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12")]

#Merges files into a common temporary file. A good place to start when re-running stuff after breaking something.
MergedAnalyticsFile = rbind(AnalyticsFeeder01, AnalyticsFeeder02, AnalyticsFeeder03, AnalyticsFeeder04)

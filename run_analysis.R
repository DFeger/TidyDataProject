#####################################################################
### THE FOLLOWING SCRIPT EXTRACTS, TRANSFORMS AND LOADS MOTION DATA 
### THIS DATA IS SUBSEQUENTLY ANALYZED AND THE RESULTS ARE EXPORTED
### IN A TEXT FILE AS A TIDY DATA SET
#####################################################################

# CREATE ACTIVITY LABEL MERGE TABLE
ACTIVITYLABELS <- read.table("activity_labels.txt"
                             ,header=FALSE
                             ,col.name = c("ACTIVITYNUM","ACTIVITYNAME"))

# CREATE IMPROVED DATA COLUMN NAME VECTOR - CONTROL CHARACTERS ARE REMOVED
DATACOL <- read.table("features.txt"
                      ,header=FALSE)
DATACOLUMNS <- gsub("()","",DATACOL$V2,fixed=TRUE)

### READ TEST FILES INTO TABLES
# CREATE TEST SUBJECT TABLE
TESTSUBJECT <- read.table("subject_test.txt"
                    ,header=FALSE
                    ,col.name = "SUBJECT")
# CREATE TEST ACTIVITY TABLE
TESTACTIVITY <- read.table("y_test.txt"
                    ,header=FALSE
                    ,col.name = "ACTIVITYNUM")
# CREATE TEST DATA TABLE
TESTDATA <- read.fwf("X_test.txt"
                    ,header=FALSE
                    ,width = rep(16,561)
                    ,col.names = DATACOLUMNS
                    #,n=10
                    ,buffersize = 200
                    )

# EXTRACT MEAN AND STANDARD DEVIATION COLUMNS FOR EACH MEASUREMENT
TESTDATA <- TESTDATA[,grep("mean|std",colnames(TESTDATA),value=TRUE)]

# COMBINE SUBJECT, ACTIVITY AND DATA TABLES
TEST <- cbind(TESTSUBJECT,TESTACTIVITY,TESTDATA)

#str(TEST)

### READ TRAIN FILES INTO DATAFRAMES
# CREATE TRAIN SUBJECT TABLE
TRAINSUBJECT <- read.table("subject_train.txt"
                      ,header=FALSE
                      ,col.name = "SUBJECT")

# CREATE TRAIN ACTIVITY TABLE
TRAINACTIVITY <- read.table("y_train.txt"
                       ,header=FALSE
                       ,col.name = "ACTIVITYNUM")

# CREATE TRAIN DATA TABLE
TRAINDATA <- read.fwf("X_train.txt"
                     ,header=FALSE
                     ,width = rep(16,561)
                     ,col.names = DATACOLUMNS
                     ,buffersize=200
                    )

# EXTRACT MEAN AND STANDARD DEVIATION COLUMNS FOR EACH MEASUREMENT
TRAINDATA <- TRAINDATA[,grep("mean|std",colnames(TRAINDATA),value=TRUE)]

# COMBINE SUBJECT, ACTIVITY AND DATA TABLES
TRAIN <- cbind(TRAINSUBJECT,TRAINACTIVITY,TRAINDATA)

#str(TRAINDATA)

#COMBINE TEST AND TRAIN DATA INTO STAGING TABLE
STAGING <- rbind(TEST,TRAIN)

#str(STAGING)

# ADD DESCRIPTIVE ACTIVITY LABELS
FINALSTAGING <- merge(STAGING
                       ,ACTIVITYLABELS
                       ,by="ACTIVITYNUM"
                       ,sort=FALSE
                    )

# CREATE SUMMARY ANALYSIS TABLE 
library(plyr)

FINAL <- ddply(FINALSTAGING,c("SUBJECT","ACTIVITYNAME"),colwise(mean))

# SORT FINAL TABLE 
SORT.FINAL <- FINAL[order(FINAL$SUBJECT,FINAL$ACTIVITYNUM),]

# EXPORT FINAL TABLE AS TAB DELIMITED TEXT FILE
write.table(SORT.FINAL
            ,"TidyDataSet.txt"
            ,append=FALSE
            ,sep="\t"
            ,row.names=FALSE
            ,col.names=TRUE)

# Replication instructions for "Do Judges Favor Their Own Ethnicity and Gender? Evidence from Kenya."

The materials in the repository are used to replicate the tables and figures from "Do Judges Favor Their Own Ethnicity and Gender? Evidence from Kenya." The replication begin with a dataset that was created by the authors using methods described in the paper. 

**Overview of included folders:**

The Stata_scripts folder contains all scripts necessary for replication.

The Stata_outputs folder contains one necessary input, the stata scheme file. Outputs will be saved in this folder.

**Process for replication**

To set up for replication, place the Stata_scripts and and Stata_outputs folders in a project folder. Add another folder to the project folder titled Stata_inputs. The following data files should be added to this folder: IND_KEN_V12.csv, final_data.dta, and df_name_validation.dta. These files are located [here](https://www.dropbox.com/sh/zu54xz2tqsrr1l1/AAB7M_16qaCnu5kahofuh_nQa?dl=0).

The entire replication can be run using the master.do script in the Stata_scripts folder. Simply change the path associated with "global project" to the project folder containing the three other folders. Then run the script. 

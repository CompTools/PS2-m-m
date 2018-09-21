#!/bin/sh
#SBATCH --job-name=problem_set_02 # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=moeinraja@ufl.edu # Where to send mail
#SBATCH --nodes=1 # Use one node
#SBATCH --cpus-per-task=2 # Number of CPU cores per task
#SBATCH --ntasks=1 # Run a single task
#SBATCH --mem=8gb # Memory limit
#SBATCH --time=02:0:00 # Time limit hrs:min:sec
#SBATCH --output=problem_set_02_result_%j.out # Standard output and error log
#SBATCH --account=baer --qos=baer-b


#1. Counts the number of flights that were delayed more than 15 minutes into or out of Gainesville, FL (airport code GNV) during the timeframe covered by the dataset. (2 points)


awk -F',' '$3 ~/'GNV'/{print}' flights.May2017-Apr2018.csv > origin.txt
awk 'BEGIN{FS=","}{print $3,$13}' origin.txt > origin_delay.txt
grep -wc 1.00 origin_delay.txt
 
awk -F',' '$7 ~/'GNV'/{print}' flights.May2017-Apr2018.csv > dest.txt
awk 'BEGIN{FS=","}{print $7,$16}' dest.txt > dest_delay.txt
grep -wc 1.00 dest_delay.txt

#2. Produces a table (text is fine) with the data to fill in this table (13 points):

awk -F',' '$3 ~/'GNV'/{print}' flights.May2017-Apr2018.csv > origin.txt
grep -wc ATL origin.txt
grep -wc CLT origin.txt
grep -wc MIA origin.txt
-----------------------------------------------------------------------
awk -F',' '$7 ~/'ATL'/{print}' origin.txt > GNV_to_ATL.txt
awk 'BEGIN{FS=","}{print $3,$13}' GNV_to_ATL.txt > GNV_to_ATL_delay.txt
grep -wc 1.00 GNV_to_ATL_delay.txt

awk -F',' '$7 ~/'CLT'/{print}' origin.txt > GNV_to_CLT.txt
awk 'BEGIN{FS=","}{print $3,$13}' GNV_to_CLT.txt > GNV_to_CLT_delay.txt
grep -wc 1.00 GNV_to_CLT_delay.txt

awk -F',' '$7 ~/'MIA'/{print}' origin.txt > GNV_to_MIA.txt
awk 'BEGIN{FS=","}{print $3,$13}' GNV_to_MIA.txt > GNV_to_MIA_delay.txt
grep -wc 1.00 GNV_to_MIA_delay.txt
-----------------------------------------------------------------------
awk 'BEGIN{FS=","}{print $3,$25}' GNV_to_ATL.txt > GNV_to_ATL_delay_weather.txt
awk '{ if($2 >= 0.000000001) { print }}' GNV_to_ATL_delay_weather.txt > GNV_to_ATL_delay_weather_number.txt
grep -wc GNV GNV_to_ATL_delay_weather_number.txt

awk 'BEGIN{FS=","}{print $3,$25}' GNV_to_CLT.txt > GNV_to_CLT_delay_weather.txt
awk '{ if($2 >= 0.000000001) { print }}' GNV_to_CLT_delay_weather.txt > GNV_to_CLT_delay_weather_number.txt
grep -wc GNV GNV_to_CLT_delay_weather_number.txt

awk 'BEGIN{FS=","}{print $3,$25}' GNV_to_MIA.txt > GNV_to_MIA_delay_weather.txt
awk '{ if($2 >= 0.000000001) { print }}' GNV_to_MIA_delay_weather.txt > GNV_to_MIA_delay_weather_number.txt
grep -wc GNV GNV_to_MIA_delay_weather_number.txt





#
# End of script

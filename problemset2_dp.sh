ssh dpaluh@hpg.rc.ufl.edu
cd /ufrc/zoo6927/share/dpaluh/problemset2/

#data /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv

#1. Count the number of flights that were delayed more than 15 minutes into or out of Gainesville, FL (airport code GNV) during the timeframe covered by the dataset. (2 points)
cat flights.May2017-Apr2018.csv | awk -F',' '$3 ~ /"GNV"/ { print }' >> /ufrc/zoo6927/share/dpaluh/problemset2/GNV_departure.txt  #all flights which depart from GNV
cat flights.May2017-Apr2018.csv | awk -F',' '$7 ~ /"GNV"/ { print }' >> /ufrc/zoo6927/share/dpaluh/problemset2/GNV_arrival.txt  #all flights which depart from GNV
cat GNV_departure.txt | awk -F',' '$13 ~ ("1.00") { print }'>> GNV_depature_delay.txt  #departures out of GNV delayed more than 15 minutes
cat GNV_arrival.txt | awk -F',' '$16 ~ ("1.00") { print }' >> GNV_arrival_delay.txt  #arrivals into GNV delayed more than 15 minutes
wc -l GNV_depature_delay.txt + GNV_arrival_delay.txt #number of delayed depatures + number of delayed arrivals
#ANSWER: 2035 delayed flights


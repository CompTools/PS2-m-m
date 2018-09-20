ssh dpaluh@hpg.rc.ufl.edu
cd /ufrc/zoo6927/share/dpaluh/problemset2/

#data /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv

#1. Count the number of flights that were delayed more than 15 minutes into or out of Gainesville, FL (airport code GNV) during the timeframe covered by the dataset. (2 points)
cat flights.May2017-Apr2018.csv | awk -F',' '$3 ~ /"GNV"/ { print }' >> /ufrc/zoo6927/share/dpaluh/problemset2/GNV_departure.txt  #all flights which depart from GNV
cat flights.May2017-Apr2018.csv | awk -F',' '$7 ~ /"GNV"/ { print }' >> /ufrc/zoo6927/share/dpaluh/problemset2/GNV_arrival.txt  #all flights which arrive to GNV
cat GNV_departure.txt | awk -F',' '$13 ~ ("1.00") { print }'>> GNV_depature_delay.txt  #departures out of GNV delayed more than 15 minutes
cat GNV_arrival.txt | awk -F',' '$16 ~ ("1.00") { print }' >> GNV_arrival_delay.txt  #arrivals into GNV delayed more than 15 minutes
wc -l GNV_depature_delay.txt + GNV_arrival_delay.txt #number of delayed depatures + number of delayed arrivals
#ANSWER: 2035 delayed flights


#2. Produce a table with the data to fill in this table (13 points): total flights delayed, total flights delayed due to weather

cat GNV_departure.txt | awk -F',' '$7 ~ /"ATL"/ { print }' >> GNV_ATL.txt #all flights from Gainesville to Atlanta
cat GNV_departure.txt | awk -F',' '$7 ~ /"CLT"/ { print }' >> GNV_CLT.txt #all flights from Gainesville to Charlotte 
cat GNV_departure.txt | awk -F',' '$7 ~ /"MIA"/ { print }' >> GNV_MIA.txt #all flights from Gainesville to Miami 
wc -l GNV_ATL.txt >> ATL_total.txt #total number of flights from Gainesville to Atlanta
wc -l GNV_CLT.txt >> CLT_total.txt #total number of flights from Gainesville to Charlotte
wc -l GNV_MIA.txt >> MIA_total.txt #total number of flights from Gainesville to Miami 

cat GNV_ATL.txt | awk -F',' '$13 ~ ("1.00") { print }'>> ATL_depature_delay.txt #all delayed flights from Gainesville to Atlanta
cat GNV_CLT.txt | awk -F',' '$13 ~ ("1.00") { print }'>> CLT_depature_delay.txt #all delayed flights from Gainesville to Charlotte
cat GNV_MIA.txt | awk -F',' '$13 ~ ("1.00") { print }'>> MIA_depature_delay.txt #all delayed flights from Gainesville to Miami 
wc -l ATL_depature_delay.txt >> ATL_total.txt #total number of flights from Gainesville to Atlanta + total number of delayed flights
wc -l CLT_depature_delay.txt >> CLT_total.txt #total number of flights from Gainesville to Charlotte + total number of delayed flights
wc -l MIA_depature_delay.txt >> MIA_total.txt #total number of flights from Gainesville to Miami + total number of delayed flights

cat ATL_depature_delay.txt | awk -F',' '$24 ~ !("0.00") { print }'>> ATL_not_weather_delay.txt #Delayed Atlanta flights not due to weather
cat CLT_depature_delay.txt | awk -F',' '$24 ~ !("0.00") { print }'>> CLT_not_weather_delay.txt #Delayed Charlotte flights not due to weather
cat MIA_depature_delay.txt | awk -F',' '$24 ~ !("0.00") { print }'>> MIA_not_weather_delay.txt #Delayed Miami flights not due to weather
wc -l ATL_not_weather_delay.txt >> ATL_total.txt #total number of flights from Gainesville to Atlanta + total number of delayed flights + delayed flights not due to weather
wc -l CLT_not_weather_delay.txt >> CLT_total.txt #total number of flights from Gainesville to Charlotte + total number of delayed flights + delayed flights not due to weather
wc -l MIA_not_weather_delay.txt >> MIA_total.txt #total number of flights from Gainesville to Miami + total number of delayed flights + delayed flights not due to weather

#ssh dpaluh@hpg.rc.ufl.edu
#cd /ufrc/zoo6927/share/dpaluh/problemset2/

#data /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv
#my directory /ufrc/zoo6927/share/dpaluh/problemset2_final/

#1. Count the number of flights that were delayed more than 15 minutes into or out of Gainesville, FL (airport code GNV) during the timeframe covered by the dataset. (2 points)

cat /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv | awk -F',' '$3 ~ /"GNV"/ { print }' > GNV_departure.txt  #all flights which depart from GNV
cat /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv | awk -F',' '$7 ~ /"GNV"/ { print }' > GNV_arrival.txt  #all flights which arrive to GNV
cat GNV_departure.txt | awk -F',' '$13 ~ ("1.00") { print }' > GNV_depature_delay.txt  #departures out of GNV delayed more than 15 minutes
cat GNV_arrival.txt | awk -F',' '$16 ~ ("1.00") { print }' > GNV_arrival_delay.txt  #arrivals into GNV delayed more than 15 minutes
wc -l GNV_depature_delay.txt + GNV_arrival_delay.txt #number of delayed depatures + number of delayed arrivals
#ANSWER: 818 delayed flights


#2. Produce a table with the data to fill in this table (13 points): total flights delayed, total flights delayed due to weather

cat GNV_departure.txt | awk -F',' '$7 ~ /"ATL"/ { print }' > GNV_ATL.txt #all flights from Gainesville to Atlanta
cat GNV_departure.txt | awk -F',' '$7 ~ /"CLT"/ { print }' > GNV_CLT.txt #all flights from Gainesville to Charlotte
cat GNV_departure.txt | awk -F',' '$7 ~ /"MIA"/ { print }' > GNV_MIA.txt #all flights from Gainesville to Miami
wc -l GNV_ATL.txt > ATL_total.txt #total number of flights from Gainesville to Atlanta
wc -l GNV_CLT.txt > CLT_total.txt #total number of flights from Gainesville to Charlotte
wc -l GNV_MIA.txt > MIA_total.txt #total number of flights from Gainesville to Miami

cat GNV_ATL.txt | awk -F',' '$16 ~ ("1.00") { print }' > ATL_depature_delay.txt #all delayed flights from Gainesville to Atlanta
cat GNV_CLT.txt | awk -F',' '$16 ~ ("1.00") { print }' > CLT_depature_delay.txt #all delayed flights from Gainesville to Charlotte
cat GNV_MIA.txt | awk -F',' '$16 ~ ("1.00") { print }' > MIA_depature_delay.txt #all delayed flights from Gainesville to Miami
wc -l ATL_depature_delay.txt >> ATL_total.txt #total number of flights from Gainesville to Atlanta + total number of delayed flights
wc -l CLT_depature_delay.txt >> CLT_total.txt #total number of flights from Gainesville to Charlotte + total number of delayed flights
wc -l MIA_depature_delay.txt >> MIA_total.txt #total number of flights from Gainesville to Miami + total number of delayed flights

cat ATL_depature_delay.txt | awk -F',' '$24 > 0 { print }' > ATL_weather_delay.txt #Delayed Atlanta flights due to weather
cat CLT_depature_delay.txt | awk -F',' '$24 > 0 { print }' > CLT_weather_delay.txt #Delayed Charlotte flights due to weather
cat MIA_depature_delay.txt | awk -F',' '$24 > 0 { print }' > MIA_weather_delay.txt #Delayed Miami flights not to weather
wc -l ATL_weather_delay.txt >> ATL_total.txt #total number of flights from Gainesville to Atlanta + total number of delayed flights + delayed flights not due to weather
wc -l CLT_weather_delay.txt >> CLT_total.txt #total number of flights from Gainesville to Charlotte + total number of delayed flights + delayed flights not due to weather
wc -l MIA_weather_delay.txt >> MIA_total.txt #total number of flights from Gainesville to Miami + total number of delayed flights + delayed flights not due to weather


#3. Within a function, prints a list of all unique airport codes contained in the dataset. (3 points)

function report_airports {
awk -F',' '{print $3}' /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv | sort -uf >> departure.txt
awk -F',' '{print $7}' /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv | sort -uf >> arrival.txt
cat departure.txt arrival.txt | sort -uf | cut -c 2-4 >> Q3_answer.txt
return
}


#4. Within a function lists the cities in Florida that have airports in the dataset. (2 points)

function report_FLcities {
cat /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv | grep "FL" >> FLs.txt
awk -F',' '$6 ~ /"FL"/ { print $4}' FLs.txt | sort -uf >> cities1.txt
awk -F',' '$10 ~ /"FL"/ { print $8}' FLs.txt | sort -uf >> cities2.txt
cat cities1.txt cities2.txt | sort -uf | cut -c 2- >> Q4_answer.txt
return
}



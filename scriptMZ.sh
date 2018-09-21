#!/bin/bash
# problem set 2, by Min

# Counts the number of flights that were delayed more than 15 minutes into or out of Gainesville
cat flights.May2017-Apr2018.csv | awk -F',' '$3 ~ /"GNV"/ { print }' >> GNV_origins.txt # all flights which depart from GNV
awk -F',' '$12 > 15 {print}' GNV_origins.txt >> outDelay.txt
cat flights.May2017-Apr2018.csv | awk -F',' '$7 ~ /"GNV"/ { print }' >> GNV_arrivals.txt # all flights which arrive at GNV
awk -F',' '$15 > 15 {print}' GNV_arrivals.txt >> inDelay.txt
cat outDelay.txt inDelay.txt | wc -l >> Q1_answer.txt # count flight number (line numbers) 

# obtain info of flights which depart from GNV
#We can use GNV_origins.txt from the first question
cat GNV_origins.txt | awk -F',' '$7 ~ /"ATL"/ { print }' >> ATLs.txt # all flights which arrive at ATL
cat GNV_origins.txt | awk -F',' '$7 ~ /"CLT"/ { print }' >> CLTs.txt # all flights which arrive at CLT
cat GNV_origins.txt | awk -F',' '$7 ~ /"MIA"/ { print }' >> MIAs.txt # all flights which arrive at MIA
cat GNV_origins.txt | awk -F',' '$7 ~ /"ATL"/' | wc -l >> col1.txt
cat GNV_origins.txt | awk -F',' '$7 ~ /"CLT"/' | wc -l >> col1.txt
cat GNV_origins.txt | awk -F',' '$7 ~ /"MIA"/' | wc -l >> col1.txt
awk -F',' '$15 > 15 {print}' ATLs.txt | wc -l >> col2.txt
awk -F',' '$15 > 15 {print}' CLTs.txt | wc -l >> col2.txt
awk -F',' '$15 > 15 {print}' MIAs.txt | wc -l >> col2.txt
awk -F',' '$24 > 0 {print}' ATLs.txt | wc -l >> col3.txt
awk -F',' '$24 > 0 {print}' CLTs.txt | wc -l >> col3.txt
awk -F',' '$24 > 0 {print}' MIAs.txt | wc -l >> col3.txt
paste col1.txt col2.txt col3.txt | column -s $'\t' -t >> Q2_answer.txt

# prints a list of all unique airport codes contained in the dataset
function report_airports {
awk -F',' '{print $3}' flights.May2017-Apr2018.csv | sort -uf >> departure.txt
awk -F',' '{print $7}' flights.May2017-Apr2018.csv | sort -uf >> arrival.txt
cat departure.txt arrival.txt | sort -uf | cut -c 2-4 >> Q3_answer.txt
return
}

# list the cities in Florida that have airports in the dataset
function report_FLcities {
cat flights.May2017-Apr2018.csv | grep "FL" >> FLs.txt
awk -F',' '$6 ~ /"FL"/ { print $4}' FLs.txt | sort -uf >> cities1.txt
awk -F',' '$10 ~ /"FL"/ { print $8}' FLs.txt | sort -uf >> cities2.txt
cat cities1.txt cities2.txt | sort -uf | cut -c 2- >> Q4_answer.txt
return
}

# Ask for user input to enter either an airport code or city, state name
# then calculates the number of flights as in question 1
echo -n "Please enter an airport code or city, state name (example: GNV or Gainesville, FL) -> " 
read input
cat flights.May2017-Apr2018.csv | grep input | awk -F',' '$12 > 15 {print}' >> outDelay.txt
cat flights.May2017-Apr2018.csv | grep input | awk -F',' '$15 > 15 {print}' >> inDelay.txt
echo "The number of flights that were delayed more than 15 minutes into or out of your selected airport: "
cat outDelay.txt inDelay.txt | wc -l 
cat outDelay.txt inDelay.txt | wc -l >> Bonus_answer.txt

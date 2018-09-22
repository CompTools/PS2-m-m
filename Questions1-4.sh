#!/bin/bash
# problem set 2
# questions 1-4
# the original csv data file was copied to the working directory

# Counts the number of flights that were delayed more than 15 minutes into or out of Gainesville
cat flights.May2017-Apr2018.csv | awk -F',' '$3 ~ /"GNV"/ { print }' > GNV_origins.txt # all flights which depart from GNV
awk -F',' '$13 == 1.00 {print}' GNV_origins.txt > outDelay.txt
cat flights.May2017-Apr2018.csv | awk -F',' '$7 ~ /"GNV"/ { print }' > GNV_arrivals.txt # all flights which arrive at GNV
awk -F',' '$16 == 1.00 {print}' GNV_arrivals.txt > inDelay.txt
cat outDelay.txt inDelay.txt | wc -l > Q1_answer.txt
rm outDelay.txt inDelay.txt # remove intermediate files

# obtain info of flights which depart from GNV
#We can use GNV_origins.txt from the first question
cat GNV_origins.txt | awk -F',' '$7 ~ /"ATL"/ { print }' > ATLs.txt # all flights which arrive at ATL
cat GNV_origins.txt | awk -F',' '$7 ~ /"CLT"/ { print }' > CLTs.txt # all flights which arrive at CLT
cat GNV_origins.txt | awk -F',' '$7 ~ /"MIA"/ { print }' > MIAs.txt # all flights which arrive at MIA
cat GNV_origins.txt | awk -F',' '$7 ~ /"ATL"/' | wc -l >> col1.txt
cat GNV_origins.txt | awk -F',' '$7 ~ /"CLT"/' | wc -l >> col1.txt
cat GNV_origins.txt | awk -F',' '$7 ~ /"MIA"/' | wc -l >> col1.txt
awk -F',' '$16 == 1.00 {print}' ATLs.txt | wc -l >> col2.txt
awk -F',' '$16 == 1.00 {print}' CLTs.txt | wc -l >> col2.txt
awk -F',' '$16 == 1.00 {print}' MIAs.txt | wc -l >> col2.txt
awk -F',' '$24 > 0 {print}' ATLs.txt | wc -l >> col3.txt
awk -F',' '$24 > 0 {print}' CLTs.txt | wc -l >> col3.txt
awk -F',' '$24 > 0 {print}' MIAs.txt | wc -l >> col3.txt
paste col1.txt col2.txt col3.txt | column -s $'\t' -t > Q2_answer.txt
rm GNV_origins.txt GNV_arrivals.txt ATLs.txt CLTs.txt MIAs.txt col1.txt col2.txt col3.txt # remove intermediate files

# prints a list of all unique airport codes contained in the dataset
function report_airports {
awk -F',' '{print $3}' flights.May2017-Apr2018.csv | sort -uf > departure.txt
awk -F',' '{print $7}' flights.May2017-Apr2018.csv | sort -uf > arrival.txt
cat departure.txt arrival.txt | sort -uf | cut -c 2-4 > Q3_answer.txt
rm departure.txt arrival.txt
return
}
report_airports

# list the cities in Florida that have airports in the dataset
function report_FLcities {
cat flights.May2017-Apr2018.csv | grep "FL" > FLs.txt
awk -F',' '$6 ~ /"FL"/ { print $4}' FLs.txt | sort -uf > cities1.txt
awk -F',' '$10 ~ /"FL"/ { print $8}' FLs.txt | sort -uf > cities2.txt
cat cities1.txt cities2.txt | sort -uf | cut -c 2- > Q4_answer.txt
rm FLs.txt cities1.txt cities2.txt
return
}
report_FLcities


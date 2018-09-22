#!/bin/bash
# problem set 2
# questions 1-2

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

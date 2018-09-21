#!/bin/bash
# problem set 2
# questions 3&4

# prints a list of all unique airport codes contained in the dataset
function report_airports {
awk -F',' '{print $3}' flights.May2017-Apr2018.csv | sort -uf > departure.txt
awk -F',' '{print $7}' flights.May2017-Apr2018.csv | sort -uf > arrival.txt
cat departure.txt arrival.txt | sort -uf | cut -c 2-4 > Q3_answer.txt
return
}
report_airports

# list the cities in Florida that have airports in the dataset
function report_FLcities {
cat flights.May2017-Apr2018.csv | grep "FL" > FLs.txt
awk -F',' '$6 ~ /"FL"/ { print $4}' FLs.txt | sort -uf > cities1.txt
awk -F',' '$10 ~ /"FL"/ { print $8}' FLs.txt | sort -uf > cities2.txt
cat cities1.txt cities2.txt | sort -uf | cut -c 2- > Q4_answer.txt
return
}
report_FLcities

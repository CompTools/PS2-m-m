#!/usr/bin/bash
# Problem set 2 bonus question by group M-M
echo -n "Please enter an airport code or city-name or state-name (case sensitive, examples: GNV or Gainesville)-> " 
read input
len="$(echo "$input" | wc -c)" # count the lenght of input
if ((len >= 4));then
    cat flights.May2017-Apr2018.csv | grep $input | awk -F',' '{print $13,$16}' > flights.txt
    echo "The number of flights that were delayed more than 15 minutes into or out of your selected airport is: "
	cat flights.txt | grep 1.00 | wc -l
else
	echo "Invalid Input"
fi
rm flights.txt
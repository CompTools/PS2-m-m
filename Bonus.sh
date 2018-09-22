echo -n "Please enter an airport code or city-name or state-name (case sensitive, examples: GNV or Gainesville)-> " 
read input
len="$(echo "$input" | wc -c)"
if ((len == 4));then
cat flights.May2017-Apr2018.csv | awk -F',' '$3 ~ /"$input"/ { print }' > origins.txt
awk -F',' '$13 == 1.00 {print}' origins.txt > outDelay.txt
cat flights.May2017-Apr2018.csv | awk -F',' '$7 ~ /"$input"/ { print }' > arrival.txt
awk -F',' '$16 == 1.00 {print}' arrival.txt > inDelay.txt
echo "The number of flights that were delayed more than 15 minutes into or out of your selected airport is: "
cat outDelay.txt inDelay.txt | wc -l
else
if ((len > 4));then
cat flights.May2017-Apr2018.csv | awk -F',' '$4 ~ /"$input"/ { print }' > origins.txt
awk -F',' '$13 == 1.00 {print}' origins.txt > outDelay.txt
cat flights.May2017-Apr2018.csv | awk -F',' '$8 ~ /"$input"/ { print }' > arrival.txt
awk -F',' '$16 == 1.00 {print}' arrival.txt > inDelay.txt
echo "The number of flights that were delayed more than 15 minutes into or out of your selected airport is: "
cat outDelay.txt inDelay.txt | wc -l
else
echo "Invalid Input"
fi
fi

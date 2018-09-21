#2. Produce a table with the data to fill in this table (13 points): total flights delayed, total flights delayed due to weather

cat GNV_departure.txt | awk -F',' '$7 ~ /"ATL"/ { print }' >> GNV_ATL.txt #all flights from Gainesville to Atlanta
cat GNV_departure.txt | awk -F',' '$7 ~ /"CLT"/ { print }' >> GNV_CLT.txt #all flights from Gainesville to Charlotte
cat GNV_departure.txt | awk -F',' '$7 ~ /"MIA"/ { print }' >> GNV_MIA.txt #all flights from Gainesville to Miami
wc -l GNV_ATL.txt >> ATL_total.txt #total number of flights from Gainesville to Atlanta
wc -l GNV_CLT.txt >> CLT_total.txt #total number of flights from Gainesville to Charlotte
wc -l GNV_MIA.txt >> MIA_total.txt #total number of flights from Gainesville to Miami


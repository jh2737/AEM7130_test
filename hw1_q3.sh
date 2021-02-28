#!/bin/sh
# Step 1: change/make directory
cd /mnt/d/GitHub/AEM7130_test
mkdir create_files
cd create_files

# Step 2: create sub-sample (first 5) of adult data
for i in $"head -n 5000 ../adult.data";
do $i >> sub_adult_data.txt;
done

# Step 3: split sub_adult_data.txt by each row
split -d -l 1 -a 4 --additional-suffix=.txt sub_adult_data.txt file_ | find -name sub_adult_data.txt -delete

# Step 4 append all files
for file in $(ls *.txt);
do cat $file >> new_data_set.csv;
done

# Step 6 count how many males, append the number to output.txt
echo "Number of males:" $(grep -c 'Male' new_data_set.csv)>> output.txt

# Step 7 count how many unique entries for column 7, append to output.txt
echo "Number of professions:" $(cut -d "," -f 7 new_data_set.csv | sort -u | wc -l) >> output.txt

# Step 7 remove all created files except for output.txt
find . ! -name output.txt -delete

# Step 8 To execute bash file: chmod u+x hw1_q3.sh then bash hw1_q3.sh
#!/bin/bash/
# Use file created from parse.awk as parameter #1, should be in JSON format

while read line
do
	curl -i -H 'Content-Type: application/json' -H 'Accept: aplication/json' -X POST -d "$line" http://localhost:5000/questions/	
done < $1

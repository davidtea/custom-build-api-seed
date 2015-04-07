#!/bin/bash/

for i in `seq 1 30`;
do
	string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
	echo $string
	curl -i -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{"name":"'"$string"'"}' http://localhost:5000/students/	
done   

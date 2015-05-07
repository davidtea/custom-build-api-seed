#!/bin/bash/
# Use file created from parse.awk as parameter #1, should be in JSON format
counter=0
function increment {
  counter=`expr $counter + 1`
}

while read line
do
  if [ $counter -gt 250 ]
    then
      echo "DONE!!!"
      break
  fi
  curl -H "Content-Type: application/json" -X POST -d "$line" http://0.0.0.0:4000/questions/
  increment
done < $1
exit


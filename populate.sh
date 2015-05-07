#!/bin/bash/
# Use file created from parse.awk as parameter #1, should be in JSON format
counter=0
function increment {
  counter=`expr $counter + 1`
}

while read line
do
  if [ $counter -gt 100 ]
    then
      echo "DONE!!!"
      break
  fi
  curl -i -H 'Content-Type: application/json' -H 'Accept: aplication/json' -X POST -d "$line" http://localhost:5000/questions/
  #increment
done < $1
exit


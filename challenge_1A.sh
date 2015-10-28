#!/bin/bash/
# GET resources
curl -i -H "Accept: application/json" http://localhost:5000/students/

# POST 
curl -i -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{"name":"Bob"}' http://localhost:5000/students/

# GET a resource
curl -i -H "Accept: application/json" http://localhost:5000/students/1

# PUT a resource
curl -i -H 'Content-Type: application/json' -H 'Accept: application/json' -X PUT -d '{"name":"Bob"}' http://localhost:5000/students/1

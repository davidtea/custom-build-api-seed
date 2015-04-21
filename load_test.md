This is ApacheBench, Version 2.3 <$Revision: 1554214 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)

```
Server Software:        Werkzeug/0.9.6
Server Hostname:        localhost
Server Port:            5000

Document Path:          /questions/
Document Length:        2120 bytes

Concurrency Level:      10
Time taken for tests:   17.854 seconds
Complete requests:      1000
Failed requests:        0
Total transferred:      2267000 bytes
HTML transferred:       2120000 bytes
Requests per second:    56.01 [#/sec] (mean)
Time per request:       178.539 [ms] (mean)
Time per request:       17.854 [ms] (mean, across all concurrent requests)
Transfer rate:          124.00 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       1
Processing:     9  176 212.7     74     677
Waiting:        9  175 212.7     74     677
Total:         10  176 212.7     75     677

Percentage of the requests served within a certain time (ms)
  50%     75
  66%     82
  75%     98
  80%    105
  90%    643
  95%    645
  98%    649
  99%    671
 100%    677 (longest request)
```
#I chose -n 1000 -c 10 first because it seems like a standard test.

This is ApacheBench, Version 2.3 <$Revision: 1554214 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)

```
Server Software:        Werkzeug/0.9.6
Server Hostname:        localhost
Server Port:            5000

Document Path:          /questions/
Document Length:        2120 bytes

Concurrency Level:      100
Time taken for tests:   17.979 seconds
Complete requests:      1000
Failed requests:        0
Total transferred:      2267000 bytes
HTML transferred:       2120000 bytes
Requests per second:    55.62 [#/sec] (mean)
Time per request:       1797.919 [ms] (mean)
Time per request:       17.979 [ms] (mean, across all concurrent requests)
Transfer rate:          123.13 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.9      0       9
Processing:    10 1680 443.3   1906    1963
Waiting:        9 1679 443.3   1905    1963
Total:         19 1681 441.7   1906    1963

Percentage of the requests served within a certain time (ms)
  50%   1906
  66%   1922
  75%   1927
  80%   1936
  90%   1951
  95%   1954
  98%   1961
  99%   1962
 100%   1963 (longest request)
 ```
 # Next, I chose -n 1000 -c 100. I kept the total number of requests the same so that I could see the difference that concurrent requests makes on the
 # server. It looks like the increased concurrent requests didn't change the total request time by much.
 
 
This is ApacheBench, Version 2.3 <$Revision: 1554214 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)

```
Server Software:        Werkzeug/0.9.6
Server Hostname:        localhost
Server Port:            5000

Document Path:          /questions/
Document Length:        2120 bytes

Concurrency Level:      1
Time taken for tests:   17.906 seconds
Complete requests:      1000
Failed requests:        0
Total transferred:      2267000 bytes
HTML transferred:       2120000 bytes
Requests per second:    55.85 [#/sec] (mean)
Time per request:       17.906 [ms] (mean)
Time per request:       17.906 [ms] (mean, across all concurrent requests)
Transfer rate:          123.64 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:     7   18  73.0      7     577
Waiting:        7   17  73.0      7     577
Total:          7   18  73.0      7     578

Percentage of the requests served within a certain time (ms)
  50%      7
  66%      8
  75%      8
  80%      8
  90%     12
  95%     13
  98%     18
  99%    569
 100%    578 (longest request)
 ```
# For the final test I chose -n 1000 -c 1 to see what would happen if requests were handled one at a time. It didn't change the total time much. All the 
# tests were within ~0.1 secs of each other. It seems that the concurrent number of requests don't really affect the overall time.
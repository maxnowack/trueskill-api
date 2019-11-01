# trueskill-api
Simple trueskill api in ruby

## example
````sh
  $ curl http://localhost:5000 --data '{"team1":{"players":[{"userId": "1", "mean": 25, "deviation": 8.333, "activity": 1.0}, {"userId": "2", "mean": 25, "deviation": 8.333, "activity": 1.0}], "score": 10}, "team2":{"players":[{"userId": "3", "mean": 25, "deviation": 8.333, "activity": 1.0}],"score":0}}'
````

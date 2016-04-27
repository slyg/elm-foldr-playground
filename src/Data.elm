module Data where

import Date exposing (Day(Mon, Tue, Wed, Thu, Fri, Sat, Sun))
import Types exposing (ForecastItem, ForecastsPerDay)

input : List ForecastItem
input =
  [ {day = Mon, hour = 6}
  , {day = Mon, hour = 9}
  , {day = Tue, hour = 6}
  , {day = Tue, hour = 9}
  , {day = Wed, hour = 6}
  ]

output : List ForecastsPerDay
output =
  [ (Mon, [{day = Mon, hour = 6}, {day = Mon, hour = 9}])
  , (Tue, [{day = Tue, hour = 6}, {day = Tue, hour = 9}])
  , (Wed, [{day = Wed, hour = 6}])
  ]

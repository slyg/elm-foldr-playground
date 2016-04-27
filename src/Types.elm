module Types where

import Date exposing (Day)

type alias ForecastItem =
  { day: Day
  , hour: Int
  }

type alias ForecastsPerDay =
  (Day, List ForecastItem)

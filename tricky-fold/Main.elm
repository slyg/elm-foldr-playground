import Html exposing (text)
import Date exposing (Day(Mon, Tue, Wed))

type alias ForecastItem =
  { day: Day
  , hour: Int
  }

type alias ForecastsPerDay =
  (Day, List ForecastItem)

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

groupByDay : ForecastItem -> List ForecastsPerDay -> List ForecastsPerDay
groupByDay x acc =
  let
    { day } = x
    default = (day, [x]) :: acc
  in
    case acc of
      [] ->
        default
      h::_ ->
        let
          (hDay, hRef) = h
          accTail = List.drop 1 acc
        in
          if hDay == day then
              (day, x :: hRef) :: accTail
          else
            default

result =
  List.foldr groupByDay [] input

main =
  let
    hasSuceeded =
      if result == output then
        "OK"
      else
        "KO :( " ++ toString result
  in
    text hasSuceeded

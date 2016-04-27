import Html exposing (text)

type alias ForecastItem =
  { day: String
  , hour: Int
  }

type alias ForecastsPerDay =
  (String, List ForecastItem)

input : List ForecastItem
input =
  [ {day = "Mon", hour = 6}
  , {day = "Mon", hour = 9}
  , {day = "Tue", hour = 6}
  , {day = "Tue", hour = 9}
  , {day = "Wed", hour = 6}
  ]

output : List ForecastsPerDay
output =
  [ ("Mon", [{day = "Mon", hour = 6}, {day = "Mon", hour = 9}])
  , ("Tue", [{day = "Tue", hour = 6}, {day = "Tue", hour = 9}])
  , ("Wed", [{day = "Wed", hour = 6}])
  ]

groupByDay : ForecastItem -> List ForecastsPerDay -> List ForecastsPerDay
groupByDay x acc =
  let
    h = List.head (List.reverse acc)
    {day, hour} = x
    default = List.append acc [(day, [x])]
  in
    case h of
      Just h' ->
        let
          (hDay, hRef) = h'
        in
          if hDay == day then
            Debug.log "same"
            List.append
              (
                List.reverse acc
                  |> List.drop 1
                  |> List.reverse
              )
              [ (day, List.append hRef [x]) ]
          else
            Debug.log "different"
            default
      Nothing ->
        Debug.log "nothing"
        default


result =
  List.foldl groupByDay [] input

main =
  let
    hasSuceeded =
      if result == output then
        "OK"
      else
        "KO :("
  in
    text hasSuceeded

import String
import Html exposing (Html, text, ul, li)
import Date exposing (Day(Mon, Tue, Wed, Thu, Fri, Sat, Sun))

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

dateTranslation day =
  case day of
    Mon -> "Mon"
    Tue -> "Tue"
    Wed -> "Wed"
    Thu -> "Thu"
    Fri -> "Fri"
    Sat -> "Sat"
    Sun -> "Sun"

displayForecast : ForecastItem -> Html
displayForecast item =
  let
    { hour } = item
  in
    li []
      [ text (
        String.concat
          [ "Temp: "
          , toString hour
          , "°C"
          ]
        )
      ]

displayDay : ForecastsPerDay -> Html
displayDay groupItem =
  let
    (day, forecasts) = groupItem
  in
    li [] [
      text (dateTranslation day),
      ul [] (List.map displayForecast forecasts)
    ]

result : List ForecastsPerDay
result =
  List.foldr groupByDay [] input

main : Html
main =
  if result == output then
    Html.ul [] (List.map displayDay result)
  else
    Html.div [] [ text ("KO :( " ++ toString result) ]

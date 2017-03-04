module Routing exposing (..)

import Array exposing (get)
import Navigation exposing (Location)
import Models exposing (Model, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map AboutRoute top
        , map AboutRoute (s "about")
        , map ContactRoute (s "contact")
        ]


routeByIndex : Int -> Route
routeByIndex index =
    routeList
        |> Array.fromList
        |> get index
        |> Maybe.withDefault NotFoundRoute


routeStrings =
    List.map
        (\r ->
            case r of
                AboutRoute ->
                    "About"

                ContactRoute ->
                    "Contact"

                NotFoundRoute ->
                    "Route Not Found"
        )
        routeList


routeList =
    {--routes that have links in the header --}
    [ AboutRoute
    , ContactRoute
    ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

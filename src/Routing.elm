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
    let
        _ =
            Debug.log "index: " index
    in
        routeList
            |> Array.fromList
            |> get index
            |> (\maybeRoute ->
                    case maybeRoute of
                        Just r ->
                            r

                        Nothing ->
                            NotFoundRoute
               )


routeList =
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

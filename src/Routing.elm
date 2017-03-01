module Routing exposing (..)

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


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

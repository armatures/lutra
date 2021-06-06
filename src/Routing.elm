module Routing exposing (..)

import Array exposing (get)
import Models exposing (Model, Route(..))
import Navigation exposing (Location)
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map AboutRoute top
        , map AboutRoute (s "about")
        , map ContactRoute (s "contact")
        , map ClientsRoute (s "clients")
        , map ThanksRoute (s "thanks")
        ]


routeByIndex : Int -> Route
routeByIndex index =
    routeList
        |> Array.fromList
        |> get index
        |> Maybe.withDefault NotFoundRoute


routeStrings : List String
routeStrings =
    List.map routeAsString routeList


routeAsString : Route -> String
routeAsString r =
    case r of
        AboutRoute ->
            "About"

        ContactRoute ->
            "Contact"

        ThanksRoute ->
            "Thanks"

        ClientsRoute ->
            "Clients"

        NotFoundRoute ->
            "Route Not Found"


routeAsUrlFragment : Route -> String
routeAsUrlFragment =
    routeAsString >> String.toLower >> (++) "#"


routeList : List Route
routeList =
    {--routes that have links in the header --}
    [ AboutRoute
    , ClientsRoute
    , ContactRoute
    ]


parseLocation : Location -> Route
parseLocation location =
    case parseHash matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

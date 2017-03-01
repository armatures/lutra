module Models exposing (Route(..), Model)


type alias Model =
    { route : Route }


type Route
    = AboutRoute
    | ContactRoute
    | NotFoundRoute

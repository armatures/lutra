module Models exposing (Route(..), Model, Msg(..))

import Material
import Navigation


type alias Model =
    { route : Route
    , mdl : Material.Model
    }


type Route
    = AboutRoute
    | ContactRoute
    | NotFoundRoute


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | Mdl (Material.Msg Msg)
    | SelectTab Int
